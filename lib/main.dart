import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/user.dart' as kakaouser;
import 'package:pencilwith/models/newbie.dart';
import 'package:pencilwith/pages/mainpage.dart';
import 'package:pencilwith/pages/termspage.dart';
import 'package:http/http.dart' as http;
import 'package:pencilwith/values/commonfunction.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(GetMaterialApp(
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child);
      },
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    KakaoContext.clientId = '8468fb9fc49b635b980e625e78eb2f5f';

    isKakaoTalkInstalled();

    deviceWidth = MediaQuery.of(context).size.width.toDouble();
    deviceHeight = MediaQuery.of(context).size.height.toDouble();
    deviceRatio = deviceWidth / deviceHeight;

    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Center(
            child: Text('a'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MyMyApp();
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class MyMyApp extends StatefulWidget {
  @override
  _MyMyAppState createState() => _MyMyAppState();
}

class _MyMyAppState extends State<MyMyApp> {
  bool _isKakaoTalkInstalled = false;

  _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  @override
  void initState() {
    _initKakaoTalkInstalled();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: new Color(0xffF0A8AB),
        resizeToAvoidBottomPadding: false,
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (!snapshot.hasData) {
              return SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(),
                    Container(
                      color: Colors.grey[400],
                      child: Center(
                        child: Text(
                          '로고',
                          style: TextStyle(
                              fontSize: deviceWidth * 0.05,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      width: deviceWidth * 0.7,
                      height: deviceWidth * deviceRatio,
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    _loginButton(
                        '구글', deviceWidth, Colors.blue[900], Colors.white),
                    _loginButton(
                        '카카오', deviceWidth, Colors.yellow, Colors.black),
                  ],
                ),
              );
            } else {
              return TermsPage();
              //_moveNextPage();
              //_moveNextPage();
              // return Center(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text('${snapshot.data.displayName}님 환영합니다.'),
              //       Text('${snapshot.data.email}님 환영합니다.'),
              //       ClipRRect(
              //         child: Image.network(snapshot.data.photoURL),
              //         borderRadius: BorderRadius.circular(100),
              //       ),
              //       SizedBox(
              //         height: 50,
              //       ),
              //       FlatButton(
              //           color: Colors.grey[200],
              //           onPressed: FirebaseAuth.instance.signOut,
              //           child: Text('로그아웃'))
              //     ],
              //   ),
              // );
            }
          },
        ));
  }

  void _moveNextPage() {
    Get.off(() => TermsPage());
  }

  Widget _loginButton(
      String vendor, double _deviceWidth, Color color, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child: OutlineButton(
          onPressed: () {
            print('$vendor 로그인');
            if (vendor == '카카오') {
              if (_isKakaoTalkInstalled) {
                _loginWithTalk();
              } else {
                _loginWithKakao();
              }
            } else {
              signInWithGoogle();
            }
          },
          child: Text(
            '$vendor 로그인',
            style: TextStyle(
                fontSize: _deviceWidth * 0.06,
                color: textColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        width: _deviceWidth * 0.7,
        height: 60,
      ),
    );
  }

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance
          .toStore(token)
          .then((value) => print(value.accessToken));
      //print('accessToken:${token.accessToken.toString()}');
      _getCheckSignUP(token.accessToken.toString());
      //_moveNextPage();
    } catch (e) {
      print("error on issuing access token: $e");
    }
  }

  ///카카오톡이 인스톨 안 되어있을때,
  _loginWithKakao() async {
    try {
      var code = await AuthCodeClient.instance.request();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  ///카카오톡이 인스톨 되어있을때,
  _loginWithTalk() async {
    try {
      var code = await AuthCodeClient.instance.requestWithTalk();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  logOutTalk() async {
    try {
      var code = await kakaouser.UserApi.instance.logout();
      print(code.toString());
    } catch (e) {
      print(e);
    }
  }

  unlinkTalk() async {
    try {
      var code = await kakaouser.UserApi.instance.unlink();
      print(code.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getCheckSignUP(String accessToken) async {
    var url = 'https://pencil-with.com/api/auth/kakao/authentication';
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: '${accessToken.toString()}');

    print(accessToken.toString());
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      Newbie nb = Newbie.fromJson(jsonResponse);
      print(nb.body.registered);
      if (nb.body.registered) {
        //TODO : JWTtoken(nb.body.jwtToken)을 받아서, 진행
      } else {
        _moveNextPage();
      }
    } else {
      print('${response.statusCode}');
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    print('google token:${googleAuth.accessToken}');
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaa');

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
