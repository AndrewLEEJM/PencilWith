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

//경력 필터
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
  bool testing =true;
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
            if(testing == false)...{noOne()}
            else...{rectInfo()},
          ],
        ),
    );
  }
}

//공고가 없을 경우 출력
class noOne extends StatelessWidget {
  const noOne({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    recruitment();
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
      width: 325,
      height: 152,
      margin: EdgeInsets.only(top: 25),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Color(0xffE3E3E3),
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(20, 15, 0, 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black
                    ),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text('icon'),
              ),
              Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(14, 12, 0, 0),
                      child: Text('제목',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),)),
                  Container(
                    margin: EdgeInsets.fromLTRB(14, 0, 0, 0),
                      child: Text('닉네임',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xffA1A1A1),
                      ),)),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 11.56, 15, 0),
                child: TextButton(
                  onPressed: () {

                  },
                  child: Text('신고',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Colors.black,
                  ),),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(22, 4, 0, 0),
                child: Icon(
                  Icons.person_outline,
                  color: Color(0xff717171),
                  size: 17,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(4, 4, 60, 0),
                child: Text('모집인원',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff717171),
                      ),
                ),
              ),
              Text('00명',
                style: TextStyle(
                fontSize: 12,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(22, 4, 0, 0),
                child: Icon(
                  Icons.access_time,
                  color: Color(0xff717171),
                  size: 17,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(4, 4, 60, 0),
                child: Text('집필기간',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff717171),
                  ),),
              ),
              Text('~~~~',
                style: TextStyle(
                  fontSize: 12,
                ),),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(22, 4, 0, 0),
                child: Icon(
                  Icons.import_contacts,
                  color: Color(0xff717171),
                  size: 17,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(4, 4, 60, 0),
                child: Text('장       르',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff717171),
                  ),),
              ),
              Text('0000',
                style: TextStyle(
                  fontSize: 12,
                ),),
            ],
          ),
        ],
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
          TextField(
            decoration: InputDecoration(
              hintText: '제목',
              hintStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            width: 327,
            height: 94,
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Color(0xffE3E3E3),
                ),
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(11, 14.5, 0, 0),
                      child: Icon(
                        Icons.person_outline,
                        color: Color(0xff717171),
                        size: 17,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(4, 8, 60, 0),
                      child: Text('모집인원',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff717171),
                        ),
                      ),
                    ),
                    TextField(
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text('명'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(22, 4, 0, 0),
                      child: Icon(
                        Icons.access_time,
                        color: Color(0xff717171),
                        size: 17,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(4, 4, 60, 0),
                      child: Text('집필기간',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff717171),
                        ),),
                    ),
                    TextField(
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(22, 4, 0, 0),
                      child: Icon(
                        Icons.import_contacts,
                        color: Color(0xff717171),
                        size: 17,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(4, 4, 60, 0),
                      child: Text('장       르',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff717171),
                        ),),
                    ),
                    TextField(
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: '간단한 줄거리와 소개 등을 작성하고 모집글을 작성해보세요!',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
