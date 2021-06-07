import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pencilwith/models/getxcontroller.dart';
import 'package:pencilwith/models/userprofile.dart';
import 'package:pencilwith/values/bottom_value.dart';
import 'package:pencilwith/pages/crewpage.dart';
import 'package:pencilwith/pages/homepage.dart';
import 'package:pencilwith/pages/profilepage.dart';
import 'package:pencilwith/values/commonfunction.dart';
import 'package:http/http.dart' as http;

//TODO JWTTOKEN 유효성을 확인 로직이 필요할것 같다.

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> mainPageList = [CrewPage(), HomePage(), ProfilePage()];

  int selectedIndex = 0;
  FlutterToast flutterToast;
  Controller _controller = Get.put(Controller());

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    flutterToast = FlutterToast(context);
    _callProfile(prefs.getString('UserID'));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _callProfile(String userId) async {
    print(userId);
    var url = 'https://pencil-with.com/api/my/user/' + userId;
    var response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json ; charset=utf-8',
        'Authorization': prefs.getString('JwtToken')
      },
    );

    if (response.statusCode == 200) {
      print('response.body.toString()');
      print(response.body.toString());

      var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      UserProfile uu = UserProfile.fromJson(jsonResponse);
      Get.find<Controller>().insertProfile(uu);
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool result = onPressBackButton(context);
        return await Future.value(result);
      },
      child: Scaffold(
        body: SafeArea(child: mainPageList[selectedIndex]),
        bottomNavigationBar: Container(
          height: 65,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                bottomIconData.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          selectedIndex == index ? bottomNavigatorColor : null,
                    ),
                    child: Icon(
                      bottomIconData[index],
                      size: 30,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }

  bool onPressBackButton(context) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;

      _showToast();
      //Scaffold.of(context).showSnackBar(SnackBar(content: Text('종료')));
      // Get.snackbar('종료안내', '2초내에 뒤로가기를 누르시면 종료됩니다.',
      //     snackPosition: SnackPosition.BOTTOM, );

      return false;
    }
    return true;
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: bottomNavigatorColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(
            "종료하시려면 2초내에\n뒤로가기를 한번 더 눌러주세요",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );

    flutterToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
