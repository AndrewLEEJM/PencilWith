import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class recruitment extends StatefulWidget {
  @override
  _recruitmentState createState() => _recruitmentState();
}

class _recruitmentState extends State<recruitment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            maxLength: 40,
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
                      maxLength: 3,
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
                      maxLength: 15,
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
                      maxLength: 10,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                TextField(
                  maxLength: 300,
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
