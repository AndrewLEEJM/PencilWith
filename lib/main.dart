import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/user.dart';
import 'package:pencilwith/models/newbie.dart';
import 'package:pencilwith/pages/termspage.dart';
import 'package:http/http.dart' as http;
import 'package:pencilwith/values/commonfunction.dart';

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
  bool _isKakaoTalkInstalled = false;

  @override
  void initState() {
    super.initState();
    _initKakaoTalkInstalled();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  @override
  Widget build(BuildContext context) {
    KakaoContext.clientId = '8468fb9fc49b635b980e625e78eb2f5f';

    isKakaoTalkInstalled();

    deviceWidth = MediaQuery.of(context).size.width.toDouble();
    deviceHeight = MediaQuery.of(context).size.height.toDouble();
    deviceRatio = deviceWidth / deviceHeight;

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
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
              _loginButton('구글', deviceWidth, Colors.blue[900], Colors.white),
              _loginButton('카카오', deviceWidth, Colors.yellow, Colors.black),
            ],
          ),
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
              _moveNextPage();
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
      var code = await UserApi.instance.logout();
      print(code.toString());
    } catch (e) {
      print(e);
    }
  }

  unlinkTalk() async {
    try {
      var code = await UserApi.instance.unlink();
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

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      Newbie nb = Newbie.fromJson(jsonResponse);
      if (nb.body.registered) {
        //TODO : JWTtoken(nb.body.jwtToken)을 받아서, 진행

      } else {
        _moveNextPage();
      }
    } else {
      print('이건 서버문제야 확실해');
    }
  }
}
