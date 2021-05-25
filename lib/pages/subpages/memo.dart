import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pencilwith/models/getxcontroller.dart';
import 'package:pencilwith/models/postitmodel.dart';
import 'package:pencilwith/models/todolistmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pencilwith/pages/subpages/suboptionpages/commonfunction.dart';

class MemoPage extends StatefulWidget {
  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  int _current = 0;

  bool visibleCheck = false;

  @override
  void initState() {
    Get.find<Controller>().makingGridList2();
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
                  Padding(
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
                            //childAspectRatio: 16 / 14,
                            childAspectRatio: 16 / 15,
                            // mainAxisSpacing: 5,
                            // crossAxisSpacing: 5,
                            crossAxisCount: 3,
                          ),
                          children: Get.find<Controller>()
                              .modifiedPostItList[index]
                              .map<Widget>((e) => GestureDetector(
                                  onTap: () {
                                    print('${e.content}을 클릭했네예');
                                  },
                                  child: Container(
                                    child: Stack(children: [
                                      Image.asset('images/posttemplete.png'),
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
                                              '#1',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              child: Text(
                                                '${e.title}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                                  )))
                              .toList()),
                    ),
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
                      child: _getTodoList(),
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
          return _makeTodoRow(index);
        });
  }

  Widget _makeTodoRow(index) {
    return Container(
      height: 25,
      child: GestureDetector(
        onTap: () {
          setState(() {
            Get.find<Controller>().getXTodoModelList[index].isDone =
                !Get.find<Controller>().getXTodoModelList[index].isDone;
          });
        },
        child: Row(
          children: [
            Checkbox(
              activeColor: Colors.grey[700],
              value: Get.find<Controller>().getXTodoModelList[index].isDone,
              onChanged: (value) {
                setState(() {
                  Get.find<Controller>().getXTodoModelList[index].isDone =
                      value;
                });
              },
            ),
            !Get.find<Controller>().getXTodoModelList[index].isDone
                ? Text(
                    '${Get.find<Controller>().getXTodoModelList[index].content}')
                : Text(
                    '${Get.find<Controller>().getXTodoModelList[index].content}',
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  ),
            //Text('${todoList[index]['content']}')
          ],
        ),
      ),
    );
  }
}
