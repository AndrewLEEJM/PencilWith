import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pencilwith/main.dart';
import 'package:http/http.dart' as http;
import 'package:pencilwith/models/signinobject.dart';
import 'package:pencilwith/pages/mainpage.dart';
import 'package:pencilwith/pages/termspage.dart';
import 'package:pencilwith/values/commonfunction.dart';

class GoogleLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("firebase load fail"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          returnGoogleToken().then((value) {
            print('google AccessToken : $myAccessToken');
          });
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<void> returnGoogleToken() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      Get.off(() => MyApp());
    } else {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      myAccessToken = googleAuth.accessToken.toString();
      _checkSignin();
    }
  }

  Future<void> _checkSignin() async {
    var url = 'https://pencil-with.com/api/auth/google/authentication';
    var response = await http.post(url,
        headers: {
          'Content-type': 'application/json ; charset=utf-8',
          'Accept': 'application/json ; charset=utf-8',
        },
        body: '$myAccessToken');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      SigninObject signinObject =
          SigninObject.fromJson(json.decode(response.body));

      print(response.body.toString());

      if (signinObject.body.registered) {
        //prefs = await SharedPreferences.getInstance();
        prefs.setString('JwtToken', signinObject.body.jwtToken.toString());
        prefs.setString('Div', 'google');
        prefs.setString('UserID', signinObject.body.userId);

        Get.off(() => MainPage());
      }
      // else if (response.statusCode == 401 || response.statusCode == 400) {
      //   prefs.setString('JwtToken', null);
      //   prefs.setString('Div', null);
      //   Get.off(() => MyApp());
      // }
      else {
        //가입페이지로 이동
        Get.off(() => TermsPage());
      }
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}
