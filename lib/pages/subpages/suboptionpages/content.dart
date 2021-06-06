import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:pencilwith/DBHelper/dbhelper.dart';
import 'package:pencilwith/models/chapterobject.dart';
import 'package:pencilwith/models/getxcontroller.dart';
import 'package:pencilwith/values/commonfunction.dart';

//This could be StatelessWidget but it won't work on Dialogs for now until this issue is fixed: https://github.com/flutter/flutter/issues/45839
class Content extends StatefulWidget {
  final bool isDialog;
  final textTitleController;

  const Content(this.textTitleController, {Key key, this.isDialog = false})
      : super(key: key);

  @override
  _ContentState createState() => _ContentState(textTitleController);
}

class _ContentState extends State<Content> {
  final FocusNode _nodeText2 = FocusNode();
  final textTitleCtl;

  DBHelper dbHelper;
  var db;

  _ContentState(this.textTitleCtl);

  TextEditingController _textEditingController = TextEditingController();
  Controller getc = Get.put(Controller());

  String codeDialog;
  String valueText;

  List<String> chapterList = [
    '무지개',
    '그때그날',
    '사건',
    '무지개',
    '어머니',
    '아버지',
  ];

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
            onTapAction: () {},
            displayActionBar: false,
            focusNode: _nodeText2,
            footerBuilder: (_) => PreferredSize(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Obx(() =>
                        Text('위치 : ${getc.textIndex}/${getc.maxTextCount}')),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios_sharp),
                        onPressed: () => _textEditingController.selection =
                            int.parse(getc.textIndex.value.toString()) == 0
                                ? TextSelection.collapsed(offset: 0)
                                : TextSelection.collapsed(
                                    offset: int.parse(
                                            getc.textIndex.value.toString()) -
                                        1)),
                    IconButton(
                        icon: Icon(Icons.arrow_forward_ios_sharp),
                        onPressed: () => _textEditingController.selection = int
                                    .parse(getc.textIndex.value.toString()) ==
                                int.parse(getc.maxTextCount.value.toString())
                            ? TextSelection.collapsed(offset: 0)
                            : TextSelection.collapsed(
                                offset:
                                    int.parse(getc.textIndex.value.toString()) +
                                        1)),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      child: Text('저장'),
                      onTap: () {
                        if (Get.find<Controller>()
                                .currentProject
                                .value
                                .projectId ==
                            null) {
                          Get.snackbar('프로젝트 선택', '작업하실 프로젝트를 먼저 선택해주세요.',
                              snackPosition: SnackPosition.TOP);
                        } else {
                          db.then((database) {
                            if (_textEditingController.text
                                        .replaceAll(' ', '')
                                        .length ==
                                    0 ||
                                textTitleCtl.text.replaceAll(' ', '').length ==
                                    0) {
                              Get.snackbar('챕터 입력', '챕터의 제목 및 내용을 입력해주세요.',
                                  snackPosition: SnackPosition.TOP);
                            }

                            final _dateFormatter = DateFormat('yyyyMMdd');
                            int rowCount = 0;
                            dbHelper
                                .getAllCount(Get.find<Controller>()
                                    .currentProject
                                    .value
                                    .projectId
                                    .toString())
                                .then((value) {
                              print(value);
                              rowCount = value + 1;

                              ChapterObject ii = ChapterObject(
                                  id:
                                      '${Get.find<Controller>().currentProject.value.projectId}',
                                  idx: rowCount.toString(),
                                  title: '${textTitleCtl.text.toString()}',
                                  content:
                                      '${_textEditingController.text.toString()}',
                                  date:
                                      '${_dateFormatter.format(DateTime.now())}');
                              dbHelper.insertChapter(ii).then((value) {
                                //TODO 챕터 리스트 만들고

                                _makingChapterList(Get.find<Controller>()
                                    .currentProject
                                    .value
                                    .projectId
                                    .toString());
                              });
                            });
                          });
                        }
                      },
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Row(
                        children: [
                          Text('챕터'),
                          Icon(Icons.expand_more),
                        ],
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0))),
                            backgroundColor: Colors.white,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom -
                                                  50),
                                          child: GetBuilder<Controller>(
                                              init: Controller(),
                                              builder: (controller) {
                                                return ListView.builder(
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ListTile(
                                                      onTap: () {
                                                        _getEachChapterSqlflite(
                                                            Get.find<
                                                                    Controller>()
                                                                .chapterRealList[
                                                                    index]
                                                                .id,
                                                            Get.find<
                                                                    Controller>()
                                                                .chapterRealList[
                                                                    index]
                                                                .idx);
                                                      },
                                                      // onLongPress: () {

                                                      dense: true,
                                                      title: Text(
                                                          '${index + 1}. ${Get.find<Controller>().chapterRealList[index].title}',
                                                          style: TextStyle(
                                                              fontSize: 15)),
                                                      trailing: TextButton(
                                                        onPressed: () {
                                                          db.then((database) {
                                                            dbHelper
                                                                .deleteEachChapter(
                                                                    Get.find<
                                                                            Controller>()
                                                                        .chapterRealList[
                                                                            index]
                                                                        .id,
                                                                    Get.find<
                                                                            Controller>()
                                                                        .chapterRealList[
                                                                            index]
                                                                        .idx)
                                                                .then((value) {
                                                              _makingChapterList(Get
                                                                      .find<
                                                                          Controller>()
                                                                  .chapterRealList[
                                                                      index]
                                                                  .id);
                                                            });
                                                          });
                                                          // closedKeyboard(
                                                          //     context);
                                                          // Get.back();
                                                          // deleteChapterDialog(
                                                          //     context,
                                                          //     Get.find<Controller>()
                                                          //             .chapterRealList[
                                                          //         index]);
                                                        },
                                                        child: Text('DEL'),
                                                      ),
                                                    );
                                                  },
                                                  itemCount:
                                                      Get.find<Controller>()
                                                          .chapterRealList
                                                          .length,
                                                );
                                              }),
                                        ),
                                        height: 500,
                                      ),
                                      //편법용
                                      TextField(
                                        decoration:
                                            InputDecoration(hintText: ''),
                                        autofocus: true,
                                      ),
                                      //SizedBox(height: 10),
                                    ],
                                  ),
                                ));
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                preferredSize: Size.fromHeight(50.0))),
      ],
    );
  }

  @override
  void initState() {
    _textEditingController.addListener(() {
      Get.find<Controller>().maxTextCount(_textEditingController.text.length);
      Get.find<Controller>().textIndex.value =
          int.parse(_textEditingController.selection.base.offset.toString());
    });
    dbHelper = DBHelper();
    db = dbHelper.initDatabase();
    _makingChapterList(
        Get.find<Controller>().currentProject.value.projectId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      isDialog: widget.isDialog,
      config: _buildConfig(context),
      child: Container(
        child: TextField(
          maxLines: null,
          style:
              TextStyle(fontSize: (MediaQuery.of(context).size.width * 0.045)),
          keyboardType: TextInputType.multiline,
          focusNode: _nodeText2,
          controller: _textEditingController,
          decoration: InputDecoration.collapsed(
              hintText: "소설을 집필해보세요",
              border: InputBorder.none,
              hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.4),
                  fontWeight: FontWeight.normal)),
        ),
      ),
    );
  }

  void _prefixTextSelection(String left, TextSelection selection) {
    final currentTextValue = _textEditingController.value.text;
    final middle = selection.textInside(currentTextValue);
    final newTextValue = selection.textBefore(currentTextValue) +
        '$left$middle' +
        selection.textAfter(currentTextValue);
    _textEditingController.value = _textEditingController.value.copyWith(
      text: newTextValue,
      selection: TextSelection.collapsed(
        offset: selection.baseOffset + left.length + middle.length,
      ),
    );
  }

  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController _textEditingModalController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Chater1'),
            content: TextField(
              controller: _textEditingModalController,
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(_textEditingModalController.text.toString());
                },
                child: Text('Submit'),
              )
            ],
          );
        });
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

  void _insertChapterApi(String title, String id) {
    // print(int.parse(id));
    //
    // db.then((database) {
    //   final _chapterList = dbHelper.insertChapter(ChapterObject(
    //     id: ,content: ,
    //   ));
    //   _chapterList.then((note) {
    //     note.forEach((e) {
    //       Get.find<Controller>()
    //           .insertAllChapterList(ChapterObject.fromJson(e));
    //     });
    //   });
    // });
  }

  void _getEachChapterSqlflite(String id, String idx) {
    db.then((database) {
      final _chapterEachList = dbHelper.getEachChapter(id, idx);
      _chapterEachList.then((chapter) {
        widget.textTitleController.text = chapter.first['title'];
        _textEditingController.text = chapter.first['content'];
        Get.back();
      });
    });
  }

  Future<String> deleteChapterDialog(
      BuildContext context, ChapterObject chapter) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text('해당 챕터를 삭제하시겠습니까?'),
            content: Text('chapter no : ${chapter.id}\n'
                'chapter name : ${chapter.title}'),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('취소'),
              ),
              MaterialButton(
                onPressed: () {
                  db.then((database) {
                    dbHelper
                        .deleteEachChapter(chapter.id, chapter.idx)
                        .then((value) {
                      _makingChapterList(chapter.id.toString());
                    });
                  });

                  Navigator.of(context).pop();
                },
                child: Text('삭제', style: TextStyle(color: Colors.red)),
              )
            ],
          );
        });
  }
}
