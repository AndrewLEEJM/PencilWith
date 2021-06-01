import 'package:flutter/material.dart';
import 'package:path/path.dart';

//성별 필터
class ftGender extends StatefulWidget {
  const ftGender({Key key}) : super(key: key);

  @override
  _ftGenderState createState() => _ftGenderState();
}

class _ftGenderState extends State<ftGender> {
  var _selectedValue;
  final _valueList = {'남성', '여성'};

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 66.07,
      height: 30,
      margin: EdgeInsets.only(top: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Color(0xffE3E3E3),
      ),
      child: DropdownButton(
        hint: Text('성별'),
        value: _selectedValue,
        items: _valueList.map((value) {
          return DropdownMenuItem(value: value, child: Text(value));
        }).toList(),
        onChanged: (value) {
          print(value);
          setState(() {
            _selectedValue = value;
          });
        },
        iconSize: 0,
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
    );
  }
}

//나이 필터
class ftAge extends StatefulWidget {
  const ftAge({Key key}) : super(key: key);

  @override
  _ftAgeState createState() => _ftAgeState();
}

class _ftAgeState extends State<ftAge> {
  var _selectedValue;
  final _valueList = {'10대', '20대', '30대', '40대', '50대', '60대'};

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 66.07,
      height: 30,
      margin: EdgeInsets.only(top: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Color(0xffE3E3E3),
      ),
      child: DropdownButton(
        hint: Text('나이'),
        value: _selectedValue,
        items: _valueList.map((value) {
          return DropdownMenuItem(value: value, child: Text(value));
        }).toList(),
        onChanged: (value) {
          print(value);
          setState(() {
            _selectedValue = value;
          });
        },
        iconSize: 0,
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
    );
  }
}

//작가 필터
class ftAuthor extends StatefulWidget {
  const ftAuthor({Key key}) : super(key: key);

  @override
  _ftAuthorState createState() => _ftAuthorState();
}

class _ftAuthorState extends State<ftAuthor> {
  var _selectedValue;
  final _valueList = {'10대', '20대', '30대', '40대', '50대', '60대'};

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 66.07,
      height: 30,
      margin: EdgeInsets.only(top: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Color(0xffE3E3E3),
      ),
      child: DropdownButton(
        hint: Text('작가'),
        value: _selectedValue,
        items: _valueList.map((value) {
          return DropdownMenuItem(value: value, child: Text(value));
        }).toList(),
        onChanged: (value) {
          print(value);
          setState(() {
            _selectedValue = value;
          });
        },
        iconSize: 0,
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
    );
  }
}

class ftCareer extends StatefulWidget {
  const ftCareer({Key key}) : super(key: key);

  @override
  _ftCareerState createState() => _ftCareerState();
}

class _ftCareerState extends State<ftCareer> {
  var _selectedValue;
  final _valueList = {'초보자', '중급자', '숙련자'};

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 66.07,
      height: 30,
      margin: EdgeInsets.only(top: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Color(0xffE3E3E3),
      ),
      child: DropdownButton(
        hint: Text('경력'),
        value: _selectedValue,
        items: _valueList.map((value) {
          return DropdownMenuItem(value: value, child: Text(value));
        }).toList(),
        onChanged: (value) {
          print(value);
          setState(() {
            _selectedValue = value;
          });
        },
        iconSize: 0,
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
    );
  }
}

//메인
class CrewPage extends StatefulWidget {
  @override
  _CrewPageState createState() => _CrewPageState();
}

class _CrewPageState extends State<CrewPage> {
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ftGender(),
                ftAge(),
                ftAuthor(),
                ftCareer(),
              ],
            ),
            Container(
              height: 1.0,
              width: 500,
              color: Color(0xffE5E5E5),
              margin: EdgeInsets.only(top: 8),
            ),
            if(/*no data*/)
              Container(

              )
            else if(/*data*/)
            Container(
              width: 318,
              height: 210,
              margin: EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Color(0xffE3E3E3),
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(24, 20, 40, 0),
                    child: Text(
                      '크루를 모집 중인 작가분이 현재 없습니다ㅠㅠ\n아래 모집하기 버튼을 통해 피드백 크루를 모아보세요!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        //fontFamily: ,
                      ),
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
    minimumSize: Size(266.0,43.0),
    primary: Color(0xffF0A8AB),
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      //fontFamily: ,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
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
