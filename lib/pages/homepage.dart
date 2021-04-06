import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pencilwith/models/dropdownmodel.dart';
import 'package:pencilwith/pages/subpages/feedback.dart';
import 'package:pencilwith/pages/subpages/memo.dart';
import 'package:pencilwith/pages/subpages/write.dart';
import 'package:smart_select/smart_select.dart';
import '../models/getxcontroller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectWork = novels[0]['title'];
  GlobalKey _scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
//    Controller c = Get.find();

    List<Widget> subPageList = [MemoPage(), WritePage(), FeedBackPage()];
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          key: _scaffold,
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      //color: Colors.yellow,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _getDropDownMenu(),
                            Icon(Icons.keyboard_arrow_down),
                            Spacer(),
                            GestureDetector(
                              child: Text('저장'),
                              onTap: () => print('save'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TabBar(
                      isScrollable: false,
                      indicatorColor: Colors.grey[400],
                      tabs: [
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

  Widget _getDropDownMenu() {
    return SmartSelect<String>.single(
      title: 'work',
      placeholder: novels[0]['title'],
      value: _selectWork,
      onChange: (selected) {
        setState(() => _selectWork = selected.value);
      },
      choiceItems: S2Choice.listFrom<String, Map>(
        source: novels,
        value: (index, item) => item['id'],
        title: (index, item) => item['title'],
        group: (index, item) => item['category'],
      ),
      choiceGrouped: true,
      //modalType: S2ModalType.bottomSheet,
      modalType: S2ModalType.popupDialog,
      //modalFilter: true,
      modalFilter: false,
      tileBuilder: (ctx, state) {
        return S2Tile.fromState(
          state,
          isTwoLine: false,
          // leading: const CircleAvatar(
          //   backgroundImage: NetworkImage(
          //     'https://source.unsplash.com/xsGxhtAsfSA/100x100',
          //   ),
          //),
        );
      },
    );
  }
}
