import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

closedKeyboard(BuildContext ctx) async {
  await FocusScope.of(ctx).requestFocus(new FocusNode());
}

String myAccessToken = '';

SharedPreferences prefs;

// String jwtToken =
//     'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ1c2VyMSIsImF1dGgiOiJST0xFX1VTRVIsIFJPTEVfQURNSU4iLCJleHAiOjE2MjM2ODc4NDl9.tt1J1_TddRAEl2UZOfmtQgvJMjIafjE72LJMdmRDyJ9f7_2oT-uj3C8S4MP2iz7GkcJcUWSj2Va2KSx5Klle0g';

double deviceWidth = 0.0;
double deviceHeight = 0.0;
double deviceRatio = 0.0;

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
