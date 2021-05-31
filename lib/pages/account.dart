import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pencilwith/pages/mainpage.dart';
import 'package:http/http.dart' as http;
import 'package:pencilwith/values/commonfunction.dart';
import 'dart:convert';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String selectedGender = 'MAN';
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
                  value: 'MALE',
                  groupValue: this.selectedGender,
                  onChanged: (val) {
                    setState(() {
                      this.selectedGender = val;
                    });
                  }),
              Text(
                "남자",
              ),
              Radio(
                  value: 'FEMALE',
                  groupValue: this.selectedGender,
                  onChanged: (val) {
                    setState(() {
                      this.selectedGender = val;
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Title(title: '작가역량'),
              Radio(
                  visualDensity: VisualDensity(horizontal: -1.5),
                  value: 'NEWBIE',
                  groupValue: this.selectedExperience,
                  onChanged: (val) {
                    setState(() {
                      this.selectedExperience = val;
                    });
                  }),
              Text(
                "입문",
              ),
              Container(
                child: Radio(
                    visualDensity: VisualDensity(horizontal: -1.5),
                    value: '5년이하',
                    groupValue: this.selectedExperience,
                    onChanged: (val) {
                      setState(() {
                        this.selectedExperience = val;
                      });
                    }),
              ),
              Text(
                "5년이하",
              ),
              Radio(
                  visualDensity: VisualDensity(horizontal: -1.5),
                  value: '5년이상',
                  groupValue: this.selectedExperience,
                  onChanged: (val) {
                    setState(() {
                      this.selectedExperience = val;
                    });
                  }),
              Text(
                "5년이상",
              ),
              Spacer()
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
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              if (this.selectedYear != null &&
                  this.selectedExperience != null &&
                  this.selectedDay != null &&
                  this.selectedLocation != null &&
                  this.selectedMonth != null) {
                _registerUser({
                  'birth':
                      '${this.selectedYear}-${this.selectedMonth}-${this.selectedDay}',
                  'careerType': this.selectedExperience,
                  'genderType': this.selectedGender,
                  'introduction': '',
                  'locationType': this.selectedLocation,
                  'username': 'pencil'
                });
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

Future<void> _registerUser(body) async {
  print(jwtToken);
  var url = 'https://pencil-with.com/api/auth/sign-up';
  var data = json.encode({
    'accessToken': 'Bearer $jwtToken'.toString(),
    'birth': '1999-02-08',
    'careerType': 'NEWBIE',
    'genderType': 'MEAL',
    'introduction': '',
    'id': 'pencil',
    'password': '1234',
    'locationType': 'SEOUL',
    'username': 'pencil'
  });
  try {
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $jwtToken'
        },
        body: data);

    if (response.statusCode == 200) {
      _moveNextPage();
    } else {
      print('이건 서버문제야 확실해');
    }
  } catch (e) {
    print(e);
  }
}

void _moveNextPage() {
  Get.off(() => MainPage());
}
