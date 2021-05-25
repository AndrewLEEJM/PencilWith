import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pencilwith/values/bottom_value.dart';
import 'package:pencilwith/pages/crewpage.dart';
import 'package:pencilwith/pages/homepage.dart';
import 'package:pencilwith/pages/profilepage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> mainPageList = [CrewPage(), HomePage(), ProfilePage()];

  int selectedIndex = 0;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    color: selectedIndex == index ? bottomNavigatorColor : null,
                  ),
                  child: Icon(
                    bottomIconData[index],
                    size: 30,
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
