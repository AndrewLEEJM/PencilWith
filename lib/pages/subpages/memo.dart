import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pencilwith/models/postitmodel.dart';
import 'package:pencilwith/models/todolistmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class MemoPage extends StatefulWidget {
  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  LabeledGlobalKey _containerKey = LabeledGlobalKey('containerKey');
  var containerHeight;
  int _current = 0;
  @override
  void initState() {
    super.initState();

    ///세로 고정
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
    //_groupingGrid();

    List<int> dummy = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    return Column(
      children: [
        Container(
            height: 360,
            //key: _containerKey,
            //color: Colors.yellow,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: CarouselSlider.builder(
                      itemCount: 3, //page count
                      options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                          //height: 500,
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 16 / 14,
                          // mainAxisSpacing: 5,
                          // crossAxisSpacing: 5,
                          crossAxisCount: 3,
                        ),
                        children: dummy
                            .map((e) => Card(
                                  child: Text('$e st'),
                                  color: Colors.red,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: dummy.map((url) {
                      int index = dummy.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
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
              ),
            )),
        Align(
          child: Text(
            '    Out Line',
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          ),
          alignment: Alignment.centerLeft,
        ),
        Divider(),
        Expanded(
          child: Container(
            //color: Colors.grey[400],
            child: _getTodoList(),
          ),
          flex: 3,
        ),
      ],
    );
  }

  Widget _getTodoList() {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            onChanged: (value) {
              setState(() {
                todoList[index]['isDone'] = value;
              });
            },
            dense: false,
            activeColor: Colors.grey,
            isThreeLine: false,
            selected: todoList[index]['isDone'], //체크여부
            value: todoList[index]['isDone'], //체크박스 값(표시)
            title: !todoList[index]['isDone']
                ? Text('${todoList[index]['content']}')
                : Text(
                    '${todoList[index]['content']}',
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  ),
          );
        });
  }

  List _makingGridList() {
    final int gridCount = 9;

    List<Widget> gridGroupList = [Text('a'), Text('b')];

    int listCount = postItModel.length;
    int gridPages = (listCount / gridCount).ceil();
    int lastPostit = listCount % gridCount;

    return gridGroupList;
  }
}
