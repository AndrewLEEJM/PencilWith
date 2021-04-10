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
          Row(children: <Widget>[
            Text('성별'),
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
          ], mainAxisAlignment: MainAxisAlignment.center),
          Row(children: <Widget>[
            Text('생년월일'),
            SizedBox(
              width: 40,
            ),
            DropdownButton(
                value: this.selectedYear,
                items: ['1990', '1991'].map((e) {
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
                items: [
                  '1',
                  '2',
                  '3',
                  '4',
                  '5',
                  '6',
                  '7',
                  '8',
                  '9',
                  '10',
                  '11',
                  '12'
                ].map((e) {
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
                items: [
                  '1',
                  '2',
                  '3',
                  '4',
                  '5',
                  '6',
                  '7',
                  '8',
                  '9',
                  '10',
                  '11',
                  '12',
                  '13',
                  '14',
                  '15',
                  '16',
                  '17',
                  '18',
                  '19',
                  '20',
                  '21',
                  '22',
                  '23',
                  '24',
                  '25',
                  '26',
                  '27',
                  '28',
                  '29',
                  '30',
                  '31'
                ].map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    this.selectedDay = val;
                  });
                }),
            Text('일')
          ], mainAxisAlignment: MainAxisAlignment.center),
          Row(children: <Widget>[
            Text('지역'),
            SizedBox(
              width: 40,
            ),
            DropdownButton(
                value: this.selectedLocation,
                items: ['서울', '대전'].map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    this.selectedLocation = val;
                  });
                }),
          ], mainAxisAlignment: MainAxisAlignment.center),
          Row(children: <Widget>[
            Text('작가역량'),
            SizedBox(
              width: 20,
            ),
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
          ], mainAxisAlignment: MainAxisAlignment.center),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "자기소개",
            ),
          ),
          Container(
            margin: const EdgeInsets.all(12),
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
            height: 50,
          ),
          joinBtn,
        ],
      ),
    );
  }
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

Widget joinBtn = GestureDetector(
  onTap: () {
    Get.off(MainPage());
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
);
