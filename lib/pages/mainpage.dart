import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pencilwith/values/bottom_value.dart';
import 'package:pencilwith/models/getxcontroller.dart';
import 'package:pencilwith/pages/crewpage.dart';
import 'package:pencilwith/pages/homepage.dart';
import 'package:pencilwith/pages/profilepage.dart';

class MainPage extends StatelessWidget {
  List<Widget> mainPageList = [CrewPage(), HomePage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    Controller getController = Get.put(Controller());

    return FutureBuilder(
        future: checkValueZero(Stream.periodic(Duration(milliseconds: 100),
            (x) => MediaQuery.of(context).size.width)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                body: SafeArea(
                    child: Obx(
                        () => mainPageList[getController.selectedIndex.value])),
                // bottom navigation (디자인 변경시 수정)
                bottomNavigationBar: Obx(() => BottomNavigationBar(
                    currentIndex: getController.selectedIndex.value,
                    onTap: (index) {
                      getController.selectedIndex(index);
                    },
                    items: List.generate(
                        bottomIconData.length,
                        (index) => BottomNavigationBarItem(
                            icon: Icon(bottomIconData[index]),
                            label: bottomLabel[index])))));
          } else {
            return Scaffold(body: CircularProgressIndicator());
          }
        });
  }

  /// 디바이스마다 초기에 MediaQuery.size값을 못 가져오는 문제가 있다고 함.
  Future<double> checkValueZero(Stream<double> sizes) async {
    await for (double val in sizes) {
      if (val > 0) {
        mainWidth = val;
        return val;
      }
    }
  }
}
