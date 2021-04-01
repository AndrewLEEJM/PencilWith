import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pencilwith/pages/mainpage.dart';
import 'models/getxcontroller.dart';

void main() => runApp(GetMaterialApp(
      //theme: ThemeData(primarySwatch: Colors.red, accentColor: Colors.yellow),
      home: MyApp(),
      //theme: ThemeData(brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());
    c.width(MediaQuery.of(context).size.width);
    return Obx(() => c.width > 0.0
        ? Scaffold(
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
                          fontSize: c.width * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  height: 200,
                  width: 250,
                ),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue[900],
                    ),
                    child: OutlineButton(
                      onPressed: () {
                        print('구글 로그인');
                        _moveNextPage();
                      },
                      child: Text(
                        '구글 로그인',
                        style: TextStyle(
                            fontSize: c.width * 0.06,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    width: c.width.value * 0.7,
                    height: 60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.yellow,
                    ),
                    child: OutlineButton(
                      onPressed: () {
                        print('카카오 로그인');
                        _moveNextPage();
                      },
                      child: Text(
                        '카카오 로그인',
                        style: TextStyle(
                            fontSize: c.width * 0.06,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    width: c.width.value * 0.7,
                    height: 60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      //color: Colors.blue[900],
                    ),
                    child: OutlineButton(
                      onPressed: () {
                        print('다른 방법으로 시작하기');
                        _moveNextPage();
                      },
                      child: Text(
                        '다른 방법으로 시작하기',
                        style: TextStyle(
                            fontSize: c.width * 0.045,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    width: c.width.value * 0.7,
                    height: 60,
                  ),
                ),
              ],
            ),
          ))
        : Center(child: Text('Loading')));
  }

  void _moveNextPage() {
    Get.off(MainPage());
  }
}
