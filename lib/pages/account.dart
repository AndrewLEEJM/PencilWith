import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pencilwith/models/nickcheck.dart';
import 'package:pencilwith/models/signupobject.dart';
import 'package:pencilwith/pages/mainpage.dart';
import 'package:http/http.dart' as http;
import 'package:pencilwith/values/bottom_value.dart';
import 'package:pencilwith/values/commonfunction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String radioValue = 'MALE';
  String selectedYear;
  String selectedMonth;
  String selectedDay;
  String selectedLocation;
  String selectedExperience;
  //SharedPreferences prefs;
  bool nickCheck;

  TextEditingController _textEditingController = new TextEditingController();
  TextEditingController _textNickNameController = new TextEditingController();

  DateFormat signinDateFormat = DateFormat('yyyy-MM-dd');
  final GlobalKey<FormState> _formKey = new GlobalKey();

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
            padding: EdgeInsets.only(left: 30, right: 10),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            nickCheck = null;
                            if (value.length > 10) {
                              _formKey.currentState.validate();
                            }
                          });
                        },
                        controller: _textNickNameController,
                        decoration: InputDecoration(
                          hintText: '닉네임',
                        ),
                        validator: (_) {
                          if (nickCheck ?? false) {
                            return '이미 등록된 닉네임 입니다.';
                          }
                          if (_textNickNameController.text.length > 10) {
                            return '10자리 내로 만들어주세요.';
                          }

                          return null;
                        },
                      ),
                    ),
                    Visibility(
                      child: Container(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          '해당 닉네임을 사용하실수 있습니다.',
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                      ),
                      visible: nickCheck == null ? false : !nickCheck,
                    )
                  ],
                )),
                SizedBox(
                  width: 10,
                ),
                RaisedButton(
                  color: bottomNavigatorColor,
                  onPressed: checkNickName,
                  child: Text(
                    '중복확인',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  elevation: 0,
                )
              ],
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
                  value: 'FEMALE',
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
                    '서울',
                    '인천',
                    '부산',
                    '대구',
                    '광주',
                    '대전',
                    '울산',
                    '경기남부',
                    '강원도',
                    '충청남도',
                    '충청북도',
                    '전라남도',
                    '전라북도',
                    '경상남도',
                    '경상북도',
                    '세종'
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
              controller: _textEditingController,
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
                  this.nickCheck == false &&
                  this.selectedMonth != null) {
                callSignUp();
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
          )
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
      'genderType': radioValue,
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

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      SignupObject signupObject =
          SignupObject.fromJson(json.decode(response.body));

      if (signupObject.body.registered) {
        //prefs = await SharedPreferences.getInstance();

        prefs.setString('JwtToken', signupObject.body.jwtToken.toString());

        if (buttonDiv == 'google') {
          prefs.setString('Div', 'google');
        } else {
          prefs.setString('Div', 'kakao');
        }

        prefs.setString('UserID', signupObject.body.userId);
        print('가입이후 이동');
        Get.off(() => MainPage());
      } else {
        throw Exception('You cannot join us!!');
      }
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  Future<void> checkNickName() async {
    if (_textNickNameController.text.length > 10) {
      _formKey.currentState.validate();
    } else {
      var url =
          'https://pencil-with.com/api/auth/duplication/${_textNickNameController.text}';

      var response = await http.get(
        url,
        headers: {
          'Content-type': 'application/json ; charset=utf-8',
          'Accept': 'application/json ; charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        NickCheck nc = NickCheck.fromJson(jsonResponse);

        setState(() {
          nickCheck = nc.body;
        });

        print(nickCheck);

        _formKey.currentState.validate();
      }
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
