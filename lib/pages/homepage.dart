import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:pencilwith/DBHelper/dbhelper.dart';
import 'package:pencilwith/models/allproject.dart';
import 'package:pencilwith/models/chapterobject.dart';
import 'package:pencilwith/models/getxcontroller.dart';
import 'package:pencilwith/models/noteobject.dart';
import 'package:pencilwith/models/postitmodel.dart';
import 'package:pencilwith/models/projectclass.dart';
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

  DBHelper dbHelper;
  var db;

  //나중에 정리
  // List<SaveNotes> aList = [];
  // List<NoteObject> allNoteList = [];

  List<Map<String, dynamic>> projectList = [];

  final TextEditingController _textEditingModalController =
      TextEditingController();

  TabController _tabController;
  var selectedPageIndex = 0;

  @override
  void initState() {
    //project 전체 list call
    dbHelper = DBHelper();
    db = dbHelper.initDatabase();
    _callBackServer(apiNames.callAllProject);
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textEditingModalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _createBody(context);
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
                  _callBackServer(apiNames.callEachProject,
                      index: '${element['projectId'].toString()}');

                  Get.find<Controller>().chapterListClear();
                  //챕터 부르기
                  _makingChapterList(element['projectId'].toString());
                  Navigator.pop(context);
                },
                onLongPress: () {
                  if (element['projectId'].toString() ==
                      Get.find<Controller>()
                          .currentProject
                          .value
                          .projectId
                          .toString()) {
                    Get.snackbar('프로젝트삭제 안내', '작업중인 프로젝트는 삭제하실 수 없습니다.',
                        snackPosition: SnackPosition.TOP);
                  } else {
                    Navigator.pop(context);
                    deleteProjectDialog(context, element);
                  }
                },
              );
            },
          ),
        ),
      ),
      direction: TopSheetDirection.TOP,
    );
  }

  // 해당 프로젝트에 관련된 모든 노트 조회
  _callDatabaseNoteList(String projectId) {
    Get.find<Controller>().noteListClear();
    db.then((database) {
      final _noteList = dbHelper.getNotes(projectId);
      _noteList.then((note) {
        note.forEach((e) {
          Get.find<Controller>().insertAllNoteList(NoteObject.fromJson(e));
        });
        Get.find<Controller>().splitList();
        //Get.find<Controller>().makingGridList2();
      });
    });
  }

  _createBody(BuildContext context) {
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
                                      return ConstrainedBox(
                                        child: Text(
                                          '${controller.currentProject.value?.title ?? 'Project'}',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7),
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
                                    child: Text('배포'),
                                    onTap: () {
//                                      Get.find<Controller>().saveInCtl();
                                    });
                              } else if (selectedPageIndex == 2) {
                                return GestureDetector(
                                    child: Text('테스트'),
                                    onTap: () {
                                      //getShowBottom();
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

  Future<String> deleteProjectDialog(
      BuildContext context, Map<String, dynamic> listProject) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text('해당 프로젝트를 삭제하시겠습니까?'),
            content: Text('프로젝트번호 : ${listProject['projectId']}\n'
                '프로젝트명 : ${listProject['title']}'),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('취소'),
              ),
              MaterialButton(
                onPressed: () {
                  _callBackServer(apiNames.deleteProject,
                      index: listProject['projectId']);
                  Navigator.of(context).pop();
                },
                child: Text('삭제', style: TextStyle(color: Colors.red)),
              )
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
              maxLength: 30,
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

  Future<void> _callBackServer(apiNames request, {String index}) async {
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
          throw Exception('프로젝트 전체 리스트 조회 에러');
        }
        break;

      case apiNames.callEachProject:
        url = 'https://pencil-with.com/api/projects/$index';
        response = await http.get(
          url,
          headers: {
            'Content-type': contextType,
            'Accept': contextType,
            'Authorization': 'Bearer $jwtToken'
          },
        );
        if (response.statusCode == 200) {
          ProjectBaby newProject = ProjectBaby.fromJson(
              json.decode(utf8.decode(response.bodyBytes)));
          Get.find<Controller>().changeProject(newProject);
          await _callDatabaseNoteList(index);
        } else {
          throw Exception('프로젝트 개별 리스트 조회 에러');
        }
        break;

      case apiNames.deleteProject:
        url = 'https://pencil-with.com/api/projects/$index';
        response = await http.delete(
          url,
          headers: {
            'Content-type': contextType,
            'Authorization': 'Bearer $jwtToken'
          },
        );
        if (response.statusCode == 200) {
          Get.snackbar('삭제완료 안내', '삭제가 완료되었습니다.',
              snackPosition: SnackPosition.TOP);
          _callBackServer(apiNames.callAllProject);
        } else {
          throw Exception('프로젝트 삭제 에러');
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
          //현재 프로젝트 변경
          ProjectBaby newProject = ProjectBaby.fromJson(
              json.decode(utf8.decode(response.bodyBytes)));
          Get.find<Controller>().changeProject(newProject);
          //조회리스트 변경해주는 부분
          _callBackServer(apiNames.callAllProject);
          _textEditingModalController.clear();
        } else {
          throw Exception('프로젝트 생성 에러');
        }
        break;
      default:
        break;
    }
  }

  void _makingChapterList(String projectId) {
    Get.find<Controller>().chapterListClear();
    db.then((database) {
      final _chapterList = dbHelper.getChapter(projectId);
      _chapterList.then((note) {
        note.forEach((e) {
          Get.find<Controller>()
              .insertAllChapterList(ChapterObject.fromJson(e));
        });
      });
    });
  }
}
