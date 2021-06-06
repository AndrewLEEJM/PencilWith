import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pencilwith/DBHelper/dbhelper.dart';
import 'package:pencilwith/models/getxcontroller.dart';
import 'package:pencilwith/models/noteobject.dart';
import 'package:pencilwith/models/postitmodel.dart';
import 'package:pencilwith/models/todolistmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pencilwith/values/bottom_value.dart';
import 'package:pencilwith/values/commonfunction.dart';

class MemoPage extends StatefulWidget {
  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  int _current = 0;
  bool visibleCheck = false;
  DBHelper dbHelper;
  final memoFormatter = DateFormat('yyMMddHHmmss');

  var db;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    dbHelper = DBHelper();
    db = dbHelper.initDatabase();
    super.initState();

    ///세로 고정
//    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    ///build가 실행되어 위젯이 그려진 후 해당 함수 실행
    //WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //_getSize();
    //});
  }

  //_getSize() {
  //위젯 key로 RenderBox를 정의한다.
  //RenderBox _viewBox = _containerKey.currentContext.findRenderObject();
  // Offset offset = _viewBox.localToGlobal(Offset.zero);

  //위젯의 좌표를 반환받는다
  // var cdx = offset.dx;
  // var cdy = offset.dy;

  //위젯의 크기를 반환받는다.
  // setState(() {
  //   containerHeight = _viewBox.size.height;
  // });
  //}

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///지금까지 이것때문에 개짱남
    //closedKeyboard(context);

    ///이 설정을 해줘야할듯;;
    // double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    // double px = 1 / pixelRatio;
    // print('pixelRatio:$pixelRatio');
    // print('px:$px');
    //print('height:${MediaQuery.of(context).size.height}');

    var _subPageHeight = 0.0;

    if (Platform.isIOS) {
      _subPageHeight = MediaQuery.of(context).size.height * 0.76;
    } else {
      _subPageHeight = MediaQuery.of(context).size.height * 0.74;
    }

    final memoPadding = 10.0;

    return SafeArea(
        child: Container(
      height: _subPageHeight,
      child: Column(
        children: [
          Expanded(
              flex: 6,
              child: Column(
                children: [
                  GetBuilder<Controller>(
                    builder: (controller) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: CarouselSlider.builder(
                          itemCount: Get.find<Controller>()
                              .modifiedPostItList
                              .length, //page count
                          options: CarouselOptions(
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              },
                              height: 300,
                              autoPlay: false,
                              enlargeCenterPage: true,
                              viewportFraction: 0.8,
                              aspectRatio: 16 / 12,
                              initialPage: 0,
                              enableInfiniteScroll: false),
                          itemBuilder: (context, index, realIndex) => GridView(
                              scrollDirection: Axis.vertical,
                              reverse: false,
                              controller: ScrollController(),
                              physics: ScrollPhysics(),
                              //padding: EdgeInsets.all(0.0),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 16 / 15,
                                // mainAxisSpacing: 5,
                                // crossAxisSpacing: 5,
                                crossAxisCount: 3,
                              ),
                              children: Get.find<Controller>()
                                  .modifiedPostItList[index]
                                  .map<Widget>((e) => GestureDetector(
                                      onTap: () {
                                        if (Get.find<Controller>()
                                                .currentProject
                                                .value
                                                .projectId ==
                                            null) {
                                          Get.snackbar('프로젝트 선택',
                                              '작업하실 프로젝트를 먼저 선택해주세요.',
                                              snackPosition: SnackPosition.TOP);
                                        } else {
                                          if (e.id == 'plus') {
                                            getShowBottom('POSTIT');
                                          } else {
                                            showMemoDialog(context, e);
                                          }
                                        }
                                      },
                                      child: Container(
                                        child: Stack(children: [
                                          Image.asset(
                                              'images/posttemplete.png'),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: memoPadding,
                                                right: memoPadding,
                                                top: memoPadding * 1.5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Container(
                                                  child: Center(
                                                    child: e.id != 'plus'
                                                        ? Text(
                                                            '${e.title}',
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.0275),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 3,
                                                          )
                                                        : Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(3),
                                                            //decoration:
                                                            // BoxDecoration(
                                                            // color:
                                                            //     bottomNavigatorColor
                                                            //         .withOpacity(
                                                            //             0.7),
                                                            // shape: BoxShape.circle),
                                                            child: Icon(
                                                              Icons.add,
                                                              color: bottomNavigatorColor
                                                                  .withOpacity(
                                                                      0.7),
                                                            )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ]),
                                      )))
                                  .toList()),
                        ),
                      );
                    },
                    init: Controller(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        Get.find<Controller>().modifiedPostItList.map((url) {
                      int index = Get.find<Controller>()
                          .modifiedPostItList
                          .indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Color.fromRGBO(0, 0, 0, 0.9)
                              : Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              )),
          Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(),
                  Text(
                    '    Out Line',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: Container(
                      child: GetBuilder<Controller>(
                        init: Controller(),
                        builder: (controller) {
                          return _getTodoList();
                        },
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    ));
  }

  Widget _getTodoList() {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: Get.find<Controller>().getXTodoModelList.length,
        itemBuilder: (context, index) {
          if (Get.find<Controller>().getXTodoModelList[index].id == 'plus') {
            return GestureDetector(
              onTap: () {
                if (Get.find<Controller>().currentProject.value.projectId ==
                    null) {
                  Get.snackbar('프로젝트 선택', '작업하실 프로젝트를 먼저 선택해주세요.',
                      snackPosition: SnackPosition.TOP);
                } else {
                  getShowBottom('TODO');
                }
              },
              child: Container(
                height: 25,
                child: Icon(
                  Icons.add,
                  color: bottomNavigatorColor.withOpacity(0.7),
                ),
              ),
            );
          }
          return _makeTodoRow(index);
        });
  }

  Widget _makeTodoRow(index) {
    return Container(
      height: 25,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (Get.find<Controller>().getXTodoModelList[index].done ==
                'false') {
              Get.find<Controller>().getXTodoModelList[index].done = 'true';
            } else {
              Get.find<Controller>().getXTodoModelList[index].done = 'false';
            }

            db.then((database) {
              dbHelper
                  .updateDoneNote(
                      Get.find<Controller>().getXTodoModelList[index].id,
                      Get.find<Controller>().getXTodoModelList[index].idx,
                      Get.find<Controller>().getXTodoModelList[index].done)
                  .then((value) {
                print('complete update');
              });
            });
          });
        },
        child: Row(
          children: [
            Checkbox(
              activeColor: Colors.grey[700],
              value: Get.find<Controller>()
                          .getXTodoModelList[index]
                          .done
                          .toString() ==
                      'true'
                  ? true
                  : false,
              onChanged: (value) {
                setState(() {
                  Get.find<Controller>().getXTodoModelList[index].done =
                      value ? 'true' : 'false';
                });
              },
            ),
            Get.find<Controller>().getXTodoModelList[index].done == 'false'
                ? Expanded(
                    child: Text(
                      '${Get.find<Controller>().getXTodoModelList[index].content}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : Expanded(
                    child: Text(
                        '${Get.find<Controller>().getXTodoModelList[index].content}',
                        style:
                            TextStyle(decoration: TextDecoration.lineThrough),
                        overflow: TextOverflow.ellipsis),
                  ),
            //Text('${todoList[index]['content']}')
          ],
        ),
      ),
    );
  }

  getShowBottom(String index) {
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
                            _displayTextInputDialog(context, index);
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

  Future<void> _displayTextInputDialog(
      BuildContext context, String index) async {
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
                  Text('메모작성'),
                  Divider(),
                  Text('작성일 :${dateFormatter.format(DateTime.now())}',
                      style: TextStyle(fontSize: 10)),
                  TextField(
                    autofocus: true,
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
                    maxLength: 200,
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

            /// this actions button merge !!!!
            actions: <Widget>[
              Visibility(
                visible: index == 'POSTIT' ? true : false,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.grey,
                  textColor: Colors.white,
                  child: Text('MEMO'),
                  onPressed: () {
                    db.then((database) {
                      final _dateFormatter = DateFormat('yyyyMMdd');
                      dbHelper
                          .insertNote(NoteObject(
                              id:
                                  '${Get.find<Controller>().currentProject.value.projectId}',
                              idx:
                                  '${Get.find<Controller>().currentProject.value.projectId}${memoFormatter.format(DateTime.now())}',
                              div: 'POST',
                              title:
                                  '${_textEditingController.text.toString()}',
                              content:
                                  '${_textEditingController.text.toString()}',
                              date: '${_dateFormatter.format(DateTime.now())}',
                              done: 'false'))
                          .then((value) {
                        _callDatabaseNoteList(Get.find<Controller>()
                            .currentProject
                            .value
                            .projectId
                            .toString());
                        Get.find<Controller>().splitList();
                        _textEditingController.clear();
                      });
                    });
                    Get.back();
                  },
                ),
              ),
              Visibility(
                visible: index == 'TODO' ? true : false,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.grey,
                  textColor: Colors.white,
                  child: Text('TODO'),
                  onPressed: () {
                    db.then((database) {
                      final _dateFormatter = DateFormat('yyyyMMdd');
                      dbHelper
                          .insertNote(NoteObject(
                              id:
                                  '${Get.find<Controller>().currentProject.value.projectId}',
                              idx:
                                  '${Get.find<Controller>().currentProject.value.projectId}${memoFormatter.format(DateTime.now())}',
                              div: 'TODO',
                              title:
                                  '${_textEditingController.text.toString()}',
                              content:
                                  '${_textEditingController.text.toString()}',
                              date: '${_dateFormatter.format(DateTime.now())}',
                              done: 'false'))
                          .then((value) {
                        _callDatabaseNoteList(Get.find<Controller>()
                            .currentProject
                            .value
                            .projectId
                            .toString());
                        Get.find<Controller>().splitList();
                        _textEditingController.clear();
                      });
                    });
                    Get.back();
                  },
                ),
              ),
            ],
          );
        });
  }

  _callDatabaseNoteList(String projectId) {
    Get.find<Controller>().noteListClear();
    db.then((database) {
      final _noteList = dbHelper.getNotes(projectId);
      _noteList.then((note) {
        note.forEach((e) {
          Get.find<Controller>().insertAllNoteList(NoteObject.fromJson(e));
          print(
              'Get.find<Controller>().allNoteList.length:${Get.find<Controller>().allNoteList.length}');
          print('note : ${note.toString()}');
        });
        Get.find<Controller>().splitList();
        //Get.find<Controller>().makingGridList2();
      });
    });
  }

  void showMemoDialog(BuildContext context, NoteObject p) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${p.date}'),
          content: Text("${p.content}"),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context, "OK");
              },
            ),
          ],
        );
      },
    );
  }
}
