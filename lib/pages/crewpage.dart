import 'package:flutter/material.dart';
import 'package:path/path.dart';

class fcontent extends StatelessWidget {
  String text;

  fcontent(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 66.07,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Color(0xffE3E3E3),
      ),
      child: Text(this.text,
        style: TextStyle(
          fontSize: 12,
          //fontFamily: ,
        ),
      ),
    );
  }
}

class CrewPage extends StatefulWidget {
  @override
  _CrewPageState createState() => _CrewPageState();
}

class _CrewPageState extends State<CrewPage> {

  void filtering() {
    // ???
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('C R E W',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              //fontFamily: ,
          ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 30,
                  height: 30,
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.wysiwyg),
                    onPressed: () {
                      filtering();
                    },
                    style: OutlinedButton.styleFrom(
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                  ),
                ),
                fcontent('성별'),
                fcontent('나이'),
                fcontent('작가'),
                fcontent('경력'),
              ],
            ),

            Container(
            width: 318,
            height: 155,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey[300],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                        '크루를 모집 중인 작가분이 현재 없습니다!\n\n아래 모집하기 버튼을 통해 피드백 크루를 모아보세요!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        //fontFamily: ,
                      ),
                    ),
                    rectBtn,
                ],
              ),
            ),
          ],
        ),
    );
  }
}


//크루 모집 버튼
var rectBtn= ElevatedButton(
  child: Text(
    'Crew 모집하기',
    textAlign: TextAlign.center,
  ),
  style: ElevatedButton.styleFrom(
    primary: Color(0xffF0A8AB),
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w400,
      //fontFamily: ,
    ),
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
  ),
  onPressed: () {
    rectInfo();
  },
);


//크루 모집 공고 박스
class rectInfo extends StatefulWidget {
  const rectInfo({Key key}) : super(key: key);

  @override
  _rectInfoState createState() => _rectInfoState();
}

class _rectInfoState extends State<rectInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              //아이콘 추가
              Column(
                children: <Widget>[
                  Text('제목'),
                  Text('닉네임'),
                ],
              ),
              TextButton(
                onPressed: () {

                },
                child: Text('신고'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text('모집인원'),
              Text('00명'),
            ],
          ),
          Row(
            children: <Widget>[
              Text('집필기간'),
              Text('~~~~'),
            ],
          ),
          Row(
            children: <Widget>[
              Text('장르'),
              Text('0000'),
            ],
          ),
        ],
      ),
      width: 325,
      height: 152,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5))
      ),
    );
  }
}


//크루 모집 창
class recruitment extends StatefulWidget {
  @override
  _recruitmentState createState() => _recruitmentState();
}

class _recruitmentState extends State<recruitment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check),
              tooltip: 'complete',
              onPressed: () {}
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: '제목'
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
