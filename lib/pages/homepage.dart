import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:pencilwith/DBHelper/dbhelper.dart';
import 'package:pencilwith/models/allproject.dart';
import 'package:pencilwith/models/getxcontroller.dart';
import 'package:pencilwith/models/postitmodel.dart';
import 'package:pencilwith/models/savenotes.dart';
import 'package:pencilwith/models/todolistmodel.dart';
import 'package:pencilwith/pages/subpages/feedback.dart';
import 'package:pencilwith/pages/subpages/memo.dart';
import 'package:pencilwith/pages/subpages/newwritepage.dart';
import 'package:pencilwith/values/commonfunction.dart';
import 'package:top_sheet/top_sheet.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Controller _controller = Get.put(Controller());
  DBHelper dbHelper = DBHelper();
  List<SaveNotes> aList = [];
  List<Map<String, dynamic>> projectList = [];

  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingModalController =
      TextEditingController();

  TabController _tabController;
  var selectedPageIndex = 0;

  @override
  void initState() {
    //getData();
    //project 전체 list call
    _callBackServer(apiNames.callAllProject);
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textEditingController.dispose();
    _textEditingModalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _createBody(aList, context);
  }

  _onAlertWithCustomContentPressed(context) {
    TopSheet.show(
      context: context,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 15),
          height: 350,
          child: GroupedListView<dynamic, String>(
            elements: projectList,
            groupBy: (element) => element['group'],
            groupComparator: (value1, value2) => value2.compareTo(value1),
            itemComparator: (item1, item2) =>
                item1['title'].compareTo(item2['title']),
            order: GroupedListOrder.ASC,
            groupSeparatorBuilder: (String value) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value,
                textAlign: TextAlign.left, //grouping title
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            itemBuilder: (c, element) {
              return InkWell(
                child: Container(
                  padding: const EdgeInsets.only(left: 30),
                  height: 40,
                  child: Text(element['title']),
                ),
                onTap: () {
                  ProjectInfo clickProject = new ProjectInfo(
                      element['projectId'].toString(),
                      element['title'].toString(),
                      element['group'].toString());
                  Get.find<Controller>().changeClass(clickProject);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
      direction: TopSheetDirection.TOP,
    );
  }

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
      });
    });
  }

  _createBody(List<SaveNotes> aList, BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //_getDropDownMenu(),
                        TextButton(
                            onPressed: () {
                              //_showModalDropdown(context);
                              _onAlertWithCustomContentPressed(context);
                            },
                            child: Row(
                              children: [
                                GetBuilder<Controller>(
                                    init: Controller(),
                                    builder: (controller) {
                                      return Text(
                                        '${controller.selectProjectInfo.value.title.toString()}',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      );
                                    }),
                                // Obx(
                                //   () => Text(
                                //     //TODO 이부분 변경 실시간 변경되도록
                                //     '${Get.find<Controller>().selectProject.value.toString()}',
                                //     style: TextStyle(
                                //       color: Colors.black,
                                //     ),
                                //     overflow: TextOverflow.ellipsis,
                                //   ),
                                // ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                )
                              ],
                            )),
                        Spacer(),
                        GetBuilder<Controller>(
                            init: Controller(),
                            builder: (_) {
                              if (selectedPageIndex == 0) {
                                return GestureDetector(
                                  child: Icon(Icons.add),
                                  onTap: () {
                                    createProjectDialog(context);
                                  },
                                );
                              } else if (selectedPageIndex == 1) {
                                return GestureDetector(
                                    child: Text('DB저장'),
                                    onTap: () {
                                      print('save');
                                      Get.find<Controller>().saveInCtl();
                                    });
                              } else if (selectedPageIndex == 2) {
                                // print(
                                //     '2selectedIndex : ${getc.selectedIndex.value}');
                                return GestureDetector(
                                    child: Text('테스트'),
                                    onTap: () {
                                      print('save');
                                      getShowBottom();
                                    });
                              } else {
                                return null;
                              }
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.bottom -
            50 - //상단
            20 - //?
            65 - //하단
            MediaQuery.of(context).padding.top,
        child: ListView(children: [
          TabBar(
            onTap: (index) {
              setState(() {
                closedKeyboard(context);
                selectedPageIndex = index;
              });
            },
            labelColor: Colors.black87,
            unselectedLabelStyle: TextStyle(
              fontSize: deviceWidth * 0.040,
              fontWeight: FontWeight.normal,
            ),
            controller: _tabController,
            tabs: tabs,
            labelStyle: TextStyle(
              fontSize: deviceWidth * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity > 0) {
                print(details.primaryVelocity);
                if (selectedPageIndex != 0) {
                  setState(() {
                    selectedPageIndex--;
                    _tabController.index--;
                  });
                }
              } else if (details.primaryVelocity < 0) {
                //left direction
                if (selectedPageIndex != 2) {
                  setState(() {
                    selectedPageIndex++;
                    _tabController.index++;
                  });
                }
              }
            },
            child: IndexedStack(
              children: <Widget>[
                Visibility(
                  child: MemoPage(),
                  maintainState: true,
                  visible: selectedPageIndex == 0,
                ),
                Visibility(
                  // TODO : Keyboard size 적용
                  child: NewWritePage(),
                  maintainState: true,
                  visible: selectedPageIndex == 1,
                ),
                // Visibility(
                //   child: WritePage(aList == null ? [] : aList),
                //   maintainState: true,
                //   visible: selectedPageIndex == 1,
                // ),
                Visibility(
                  child: FeedBackPage(),
                  maintainState: true,
                  visible: selectedPageIndex == 2,
                ),
              ],
              index: selectedPageIndex,
            ),
          ),
        ]),
      ),
    );
  }

  getShowBottom() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.only(bottom: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Icon(Icons.drive_file_rename_outline),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            _displayTextInputDialog(context);
                          },
                          child: Text(
                            '문자노트',
                            style: TextStyle(fontSize: 17),
                          ),
                        )
                      ])),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  height: 50,
                  width: double.infinity,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    showModalBottomSheet(
                        //backgroundColor: Colors.white.withOpacity(1.0),
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(00),
                                    topRight: Radius.circular(30))),
                            //child: Center(child: MyRCApp()),
                            child: Center(child: Text('레코드')),
                            height: 300,
                          );
                        });
                    // setState(() {
                    //   visibleCheck = false;
                    // });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Icon(Icons.mic_none_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '음성노트',
                            style: TextStyle(fontSize: 17),
                          )
                        ])),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12))),
                    height: 50,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      context: context,
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    final dateFormatter = DateFormat('yy.MM.dd');
    var tmpMemo;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('tempo'),
                  Divider(),
                  Text('작성일 :${dateFormatter.format(DateTime.now())}',
                      style: TextStyle(fontSize: 10)),
                  TextField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        focusColor: Colors.grey,
                        hoverColor: Colors.red,
                        fillColor: Colors.yellowAccent),
                    onChanged: (value) {
                      setState(() {
                        tmpMemo = value;
                      });
                    },
                    controller: _textEditingController,
                    maxLength: 500,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    //decoration: InputDecoration(hintText: 'write memo'),
                    // decoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(20)))
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Colors.grey,
                textColor: Colors.white,
                child: Text('MEMO'),
                onPressed: () {
                  setState(() {
                    PostModel _postModel = PostModel(
                        id: 3,
                        date: '210515',
                        title: 'insert',
                        content: 'content');
                    Get.find<Controller>().insertPostModel(_postModel);
                  });
                  _textEditingController.clear();
                  Get.back();
                },
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Colors.grey,
                textColor: Colors.white,
                child: Text('TODO'),
                onPressed: () {
                  setState(() {
                    TodoModel _todoModel = TodoModel(
                        id: 3,
                        date: '210515',
                        title: 'insert',
                        isDone: false,
                        content: 'content');
                    Get.find<Controller>().insertTodoModel(_todoModel);
                  });
                  _textEditingController.clear();
                  Get.back();
                },
              ),
            ],
          );
        });
  }

  Future<String> createProjectDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text('프로젝트 생성'),
            content: TextField(
              controller: _textEditingModalController,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: "프로젝트명을 입력하세요.",
                hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.4),
                    fontWeight: FontWeight.normal),
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  _textEditingModalController.clear();
                  Navigator.of(context).pop();
                },
                child: Text('취소'),
              ),
              MaterialButton(
                onPressed: () {
                  // Navigator.of(context)
                  //     .pop(_textEditingModalController.text.toString());
                  _callBackServer(apiNames.createProject);
                  Navigator.of(context).pop();
                },
                child: Text('생성'),
              )
            ],
          );
        });
  }

  Future<void> _callBackServer(apiNames request) async {
    String url;
    String method;
    String contextType = 'application/json ; charset=utf-8';
    var response;

    switch (request) {
      case apiNames.callAllProject:
        url = 'https://pencil-with.com/api/projects/my';
        response = await http.get(
          url,
          headers: {
            'Content-type': contextType,
            'Accept': contextType,
            'Authorization': 'Bearer $jwtToken'
          },
        );
        if (response.statusCode == 200) {
          projectList = [];
          AllProject ap =
              AllProject.fromJson(json.decode(utf8.decode(response.bodyBytes)));
          ap.crewProjects.forEach((element) {
            projectList.add({
              'projectId': '${element.projectId}',
              'title': '${element.title}',
              'group': 'Crew'
            });
          });
          ap.ownerProjects.forEach((element) {
            projectList.add({
              'projectId': '${element.projectId}',
              'title': '${element.title}',
              'group': 'My'
            });
          });
        } else {
          throw Exception('프로젝트 리스트 조회 에러');
        }
        break;

      case apiNames.createProject:
        Map data = {"title": _textEditingModalController.text.toString()};
        var body = json.encode(data);
        url = 'https://pencil-with.com/api/projects';
        response = await http.post(url,
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer $jwtToken'
            },
            body: body);
        if (response.statusCode == 200) {
          _callBackServer(apiNames.callAllProject);
          _textEditingModalController.clear();
          print('insert project complete');
        } else {
          print(response.statusCode);
          throw Exception('프로젝트 생성 에러');
        }
        break;
      default:
        break;
    }
  }
}
