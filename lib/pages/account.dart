import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pencilwith/pages/mainpage.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String radioValue = 'MAN';
  String selectedYear;
  String selectedMonth;
  String selectedDay;
  String selectedLocation;
  String selectedExperience;
  var years = [];
  var months = [];
  var days = [];

  @override
  initState() {
    // 부모의 initState호출
    super.initState();
    // 이 클래스애 리스너 추가
    DateTime now = new DateTime.now();
    for (var i = 1950; i <= now.year; i++) {
      this.years.add(i.toString());
    }
    for (var i = 1; i <= 31; i++) {
      this.days.add(i.toString());
      if (i < 13) {
        this.months.add(i.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        shape: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          //borderRadius: BorderRadius.zero,
        ),
        elevation: 0,
        title: Text(
          'PROFILE',
          style: GoogleFonts.getFont('Roboto',
              fontSize: 18,
              color: Colors.black,
              fontStyle: FontStyle.italic,
              letterSpacing: 3),
        ),
      ),
      body: ListView(
        children: [
          imageSection,
          Container(
            padding: EdgeInsets.only(left: 100, right: 100),
            child: TextField(
              decoration: InputDecoration(
                labelText: '닉네임',
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Title(title: '성별'),
              SizedBox(
                width: 20,
              ),
              Radio(
                  value: 'MAN',
                  groupValue: this.radioValue,
                  onChanged: (val) {
                    setState(() {
                      this.radioValue = val;
                    });
                  }),
              Text(
                "남자",
              ),
              Radio(
                  value: 'WOMEN',
                  groupValue: this.radioValue,
                  onChanged: (val) {
                    setState(() {
                      this.radioValue = val;
                    });
                  }),
              Text(
                "여자",
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Title(title: '생년월일'),
              DropdownButton(
                  value: this.selectedYear,
                  items: this.years.map((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      this.selectedYear = val;
                    });
                  }),
              Text('년'),
              SizedBox(
                width: 20,
              ),
              DropdownButton(
                  value: this.selectedMonth,
                  items: this.months.map((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      this.selectedMonth = val;
                    });
                  }),
              Text('월'),
              SizedBox(
                width: 20,
              ),
              DropdownButton(
                  value: this.selectedDay,
                  items: this.days.map((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      this.selectedDay = val;
                    });
                  }),
              Text('일')
            ],
          ),
          Row(
            children: <Widget>[
              Title(title: '지역'),
              DropdownButton(
                  value: this.selectedLocation,
                  items: [
                    '서울특별시',
                    '경기도',
                    '인천광역시',
                    '강원도',
                    '대전광역시',
                    '세종특별자치시',
                    '충청북도',
                    '충청남도',
                    '광주광역시',
                    '전라북도',
                    '전라남도' '대구광역시',
                    '울산광역시',
                    '경상북도',
                    '경상남도',
                    '부산광역시',
                    '제주특별자치도'
                  ].map((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      this.selectedLocation = val;
                    });
                  }),
            ],
          ),
          Row(
            children: <Widget>[
              Title(title: '작가역량'),
              Radio(
                  value: '입문',
                  groupValue: this.selectedExperience,
                  onChanged: (val) {
                    setState(() {
                      this.selectedExperience = val;
                    });
                  }),
              Text(
                "입문",
              ),
              Radio(
                  value: '2~5 년차',
                  groupValue: this.selectedExperience,
                  onChanged: (val) {
                    setState(() {
                      this.selectedExperience = val;
                    });
                  }),
              Text(
                "2~5 년차",
              ),
              Radio(
                  value: '5년차 이상',
                  groupValue: this.selectedExperience,
                  onChanged: (val) {
                    setState(() {
                      this.selectedExperience = val;
                    });
                  }),
              Text(
                "5년차 이상",
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 32),
            child: Text(
              "자기소개",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
            ),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              if (this.selectedYear != null &&
                  this.selectedExperience != null &&
                  this.selectedDay != null &&
                  this.selectedLocation != null &&
                  this.selectedMonth != null) {
                Get.off(MainPage());
              } else {
                print('no enough value');
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 60,
              child: Center(
                child: Text(
                  '가입하기',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textScaleFactor: 1.5,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget Title({String title}) {
  return Container(
    margin: const EdgeInsets.only(left: 32),
    width: 80,
    child: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    ),
  );
}

Widget imageSection = Container(
  padding: const EdgeInsets.all(12),
  child: Center(
    child: CircleAvatar(
      radius: 70.0,
      backgroundImage: AssetImage('images/cat.jpg'),
    ),
  ),
);
