import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

closedKeyboard(BuildContext ctx) async {
  await FocusScope.of(ctx).requestFocus(new FocusNode());
}

String myAccessToken = '';

GoogleSignIn googleSignIn = GoogleSignIn();

SharedPreferences prefs;

double deviceWidth = 0.0;
double deviceHeight = 0.0;
double deviceRatio = 0.0;

String buttonDiv = '';

List<Widget> tabs = [
  Tab(
    text: '메모',
  ),
  Tab(
    text: '글쓰기',
  ),
  Tab(
    text: '피드백',
  ),
];

enum apiNames { callAllProject, createProject, callEachProject, deleteProject }

DateTime currentBackPressTime;

TextEditingController newWriteTitleController = TextEditingController();
TextEditingController newWriteContentController = TextEditingController();
