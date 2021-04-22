import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pencilwith/DBHelper/dbhelper.dart';
import 'package:pencilwith/models/dropdownmodel.dart';
import 'package:pencilwith/models/getxcontroller.dart';
import 'package:pencilwith/models/savenotes.dart';
import 'package:pencilwith/pages/subpages/feedback.dart';
import 'package:pencilwith/pages/subpages/memo.dart';
import 'package:pencilwith/pages/subpages/write.dart';
import 'package:smart_select/smart_select.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectWork = novels[0]['title'];
  GlobalKey _dropKey = GlobalKey();

  Controller getc = Get.put(Controller());

  DBHelper dbHelper = DBHelper();

  List<SaveNotes> aList;

  // List<Widget> subList = [
  //   Text('a'),
  //   Text('b'),
  //   Text('c'),
  // ];

  //var c = Get.put(Controller());
  //  Future<List<SaveNotes>> futureList;
  //  List<SaveNotes> loadNovelList;

  //List<Widget> subPageList;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print(aList.length);
    // if (c.novelList.length == 0) {
    //   //loading();
    // }
    //Future<List<SaveNotes>> loadNovelList = getData();
    //print(aList.length);
    //널이라고;
    return _createBody(aList);
    //print(loadNovelList.then((value) => print(value.length)));
    // return FutureBuilder(
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return Text('a');
    //     } else {
    //       print('snapshot data : ${snapshot.data}');
    //       return CircularProgressIndicator();
    //       //return _createBody();
    //       //return Text('b');
    //     }
    //   },
    //   future: loadNovelList,
    // );
    //_createBody();
  }

  Widget _getDropDownMenu() {
    return SmartSelect<String>.single(
      title: 'work',
      key: _dropKey,
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
      modalFilter: true,
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

  //Future<List<SaveNotes>> getData() {
  getData() {
    final dbFuture = dbHelper.initDatabase();
    dbFuture.then((result) {
      final noteList = dbHelper.getNotes(); //전체노트 list를 생성
      noteList.then((result) {
        List<SaveNotes> tempList = List<SaveNotes>();
        int count = result.length;
        for (int i = 0; i < count; i++) {
          tempList.add(SaveNotes.fromObject(result[i]));
        }
        setState(() {
          aList = tempList;
        });
        //  c.novelList(tempList);
      });
    });
  }

  _createBody(List<SaveNotes> aList) {
    //print('id: ${c.novelList.value[9].id}');
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
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
                                onTap: () {
                                  print('save');
                                  getc.saveInCtl();
                                  // setState(() {
                                  //   subList = [
                                  //     Text('d'),
                                  //     Text('e'),
                                  //     Text('f'),
                                  //   ];
                                  // });
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TabBar(tabs: [
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
          body: TabBarView(
              children: [MemoPage(), WritePage(aList), FeedBackPage()])),
      //children: subList)),
    );
  }

  // Future<void> loading() async {
  //   await getData();
  // }

}
