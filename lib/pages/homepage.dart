import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pencilwith/pages/subpages/feedback.dart';
import 'package:pencilwith/pages/subpages/memo.dart';
import 'package:pencilwith/pages/subpages/write.dart';
import '../models/getxcontroller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Controller c = Get.find();

    List<Widget> subPageList = [MemoPage(), WritePage(), FeedBackPage()];
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.yellow,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showDialog(context);
                              },
                              child: Row(
                                children: [
                                  Text('work'),
                                  Icon(Icons.keyboard_arrow_down)
                                ],
                              ),
                            ),
                            Spacer(),
                            Text('저장'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TabBar(isScrollable: false, tabs: [
                    Tab(
                      child: Text(
                        '메모모음',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        '글쓰기',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        '피드백',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ])
                ],
              ),
            ),
          ),
          body: TabBarView(children: subPageList)),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.FirstItem) {
      print('I First Item');
    } else if (choice == Constants.SecondItem) {
      print('I Second Item');
    } else if (choice == Constants.ThirdItem) {
      print('I Third Item');
    }
  }
}

_showDialog(BuildContext ctx) {
  showDialog(
    context: ctx,
    builder: (BuildContext context) {
      // return alert dialog object
      return AlertDialog(
        title: new Text('I am Title'),
        content: Container(
          height: 150.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Icon(Icons.toys),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new Text('First Item'),
                  ),
                ],
              ),
              new SizedBox(
                height: 20.0,
              ),
              new Row(
                children: <Widget>[
                  new Icon(Icons.toys),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new Text('Second Item'),
                  ),
                ],
              ),
              new SizedBox(
                height: 20.0,
              ),
              new Row(
                children: <Widget>[
                  new Icon(Icons.toys),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

class Constants {
  static const String FirstItem = 'First Item';
  static const String SecondItem = 'Second Item';
  static const String ThirdItem = 'Third Item';

  static const List<String> choices = <String>[
    FirstItem,
    SecondItem,
    ThirdItem,
  ];
}
