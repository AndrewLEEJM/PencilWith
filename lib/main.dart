import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:pencilwith/pages/termspage.dart';
import 'models/getxcontroller.dart';

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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _deviceWidth = MediaQuery.of(context).size.width.toDouble();
    var _deviceHeight = MediaQuery.of(context).size.height.toDouble();
    var _deviceRatio = _deviceWidth / _deviceHeight;

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
                        fontSize: _deviceWidth * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                width: _deviceWidth * 0.7,
                height: _deviceWidth * _deviceRatio,
              ),
              SizedBox(
                height: 100,
              ),
              _loginButton('구글', _deviceWidth, Colors.blue[900], Colors.white),
              _loginButton('카카오', _deviceWidth, Colors.yellow, Colors.black),
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
            _moveNextPage();
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
}
