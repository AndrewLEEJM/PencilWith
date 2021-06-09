import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pencilwith/pages/subpages/suboptionpages/content.dart';
import 'package:pencilwith/values/commonfunction.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class NewWritePage extends StatefulWidget {
  @override
  _NewWritePageState createState() => _NewWritePageState();
}

class _NewWritePageState extends State<NewWritePage> {
  var _subPageHeight = 450.0;

  @override
  void initState() {
    KeyboardVisibilityNotification().addNewListener(onShow: () {
      setState(() {
        _subPageHeight = MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.bottom -
            50 - //상단
            20 - //?
            65 - //하단
            MediaQuery.of(context).padding.top -
            52 -
            255;
      });
    }, onHide: () {
      setState(() {
        _subPageHeight = MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.bottom -
            50 - //상단
            20 - //?
            65 - //하단
            MediaQuery.of(context).padding.top -
            52; //추가 챕터제목칸과 device
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        height: _subPageHeight,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 35,
              child: TextField(
                maxLength: null,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                controller: newWriteTitleController,
                decoration: InputDecoration.collapsed(
                  hintText: "챕터제목",
                  hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.4),
                      fontWeight: FontWeight.normal),
                  border: InputBorder.none,
                ),
              ),
            ),
            // Text(
            //   'The keyboard is: ${_keyboardState ? 'VISIBLE' : 'NOT VISIBLE'}',
            // ),
            // }),
            Container(
              child: Divider(),
              height: 15,
            ),
            Expanded(
              child: Content(),
            ),
          ],
        ),
      ),
    );
  }
}
