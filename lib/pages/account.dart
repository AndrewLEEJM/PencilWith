import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pencilwith/models/signupobject.dart';
import 'package:pencilwith/pages/mainpage.dart';
import 'package:http/http.dart' as http;
import 'package:pencilwith/values/commonfunction.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String selectedGender;
  String selectedYear;
  String selectedMonth;
  String selectedDay;
  String selectedLocation;
  String selectedExperience;

  TextEditingController _textEditingController = new TextEditingController();
  TextEditingController _textNickNameController = new TextEditingController();

  DateFormat signinDateFormat = DateFormat('yyyy.MM.dd');

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
          Container(
              child: Padding(
            padding: EdgeInsets.only(left: 32, top: 60, right: 32, bottom: 40),
            child: Text(
              '작가 활동에 사용될 정보를 입력해주세요.',
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              ),
            ),
          )),
          Row(children: <Widget>[
            Title(title: '닉네임'),
            Container(
              width: 250,
              child: TextField(
                controller: _textNickNameController,
              ),
            ),
          ]),
          SizedBox(
            height: 10,
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
          SizedBox(
            height: 10,
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
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Title(title: '지역'),
              DropdownButton(
                  value: this.selectedLocation,
                  items: [
                    '서울',
                    '인천',
                    '경기북부',
                    '경기남부',
                    '강원도',
                    '대전',
                    '세종',
                    '충청북도',
                    '충청남도',
                    '광주',
                    '전라북도',
                    '전라남도',
                    '대구',
                    '울산광역시',
                    '경상북도',
                    '경상남도',
                    '부산',
                    '제주도'
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
          SizedBox(
            height: 10,
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
                    value: 'INTERMEDIATE',
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
                  value: 'SENIOR',
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
            padding: EdgeInsets.only(left: 32, top: 20),
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
              controller: _textEditingController,
              keyboardType: TextInputType.multiline,
              maxLines: 7,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              if (this._textNickNameController.text != '' &&
                  this.selectedYear != null &&
                  this.selectedExperience != null &&
                  this.selectedDay != null &&
                  this.selectedLocation != null &&
                  this.selectedMonth != null) {
                callSignUp();

                print('selectedYear:$selectedYear');
                print('selectedMonth:$selectedMonth');
                print('selectedDay:$selectedDay');
                print('selectedExperience:$selectedExperience');
                print('selectedLocation:$selectedLocation');

                // Get.off(MainPage());
              } else {
                Get.snackbar('Note', 'Please fill the information',
                    snackPosition: SnackPosition.BOTTOM);
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
          ),
        ],
      ),
    );
  }

  Future<void> callSignUp() async {
    var url = 'https://pencil-with.com/api/auth/sign-up';

    final _body = {
      'accessToken': myAccessToken,
      'birth': signinDateFormat.format(DateTime(int.parse(selectedYear),
          int.parse(selectedMonth), int.parse(selectedDay))),
      'careerType': selectedExperience,
      'genderType': selectedGender,
      'introduction': _textEditingController.text,
      'locationType': selectedLocation,
      'username': _textNickNameController.text
    };

    var response = await http.post(url,
        headers: {
          'Content-type': 'application/json ; charset=utf-8',
          'Accept': 'application/json ; charset=utf-8',
        },
        body: jsonEncode(_body));

    print(jsonDecode(response.body).toString());

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse.toString());

      SignupObject signupObject =
          SignupObject.fromJson(json.decode(response.body));

      print(signupObject.body.registered);
      print(signupObject.body.jwtToken);

      if (signupObject.body.registered) {
        jwtToken = signupObject.body.jwtToken;
        Get.off(() => MainPage());
      } else {
        throw Exception('You cannot join us!!');
      }
    } else {
      throw Exception('${response.statusCode}');
    }
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
  var url = 'https://pencil-with.com/api/auth/sign-up';
  print(body);
  try {
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          // 'Authorization': 'Bearer $jwtToken'
        },
        body: json.encode(body));

    if (response.statusCode == 200) {
      _moveNextPage();
    } else {
      print('이건 서버문제야 확실해');
      Get.off(() => MainPage());
    }
  } catch (e) {
    print(e);
  }
}

void _moveNextPage() {
  Get.off(() => MainPage());
}
