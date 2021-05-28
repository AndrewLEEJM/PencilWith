import 'dart:io';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:pencilwith/pages/subpages/suboptionpages/content.dart';

class NewWritePage extends StatefulWidget {
  @override
  _NewWritePageState createState() => _NewWritePageState();
}

class _NewWritePageState extends State<NewWritePage> {
  FocusNode _focusSample = FocusNode();

  KeyboardVisibilityNotification _keyboardVisibility =
      new KeyboardVisibilityNotification();
  int _keyboardVisibilitySubscriberId;
  bool _keyboardState;

  @override
  void initState() {
    super.initState();
    _keyboardState = _keyboardVisibility.isKeyboardVisible;
    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardState = visible;
        });
      },
    );
  }

  @override
  void dispose() {
    _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _subPageHeight = _keyboardState
        ? MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.bottom -
            50 - //상단
            20 - //?
            65 - //하단
            MediaQuery.of(context).padding.top -
            52 -
            255
        : MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.bottom -
            50 - //상단
            20 - //?
            65 - //하단
            MediaQuery.of(context).padding.top -
            52; //추가 챕터제목칸과 divice라인포함

    final viewInsets = EdgeInsets.fromWindowPadding(
        WidgetsBinding.instance.window.viewInsets,
        WidgetsBinding.instance.window.devicePixelRatio);

    //Platform.isIOS

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        height: _subPageHeight,
        child: Column(
          children: [
            Container(
              height: 35,
              child: TextField(
                maxLength: null,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.07,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                decoration: InputDecoration.collapsed(
                  hintText: "챕터제목",
                  hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.4),
                      fontWeight: FontWeight.normal),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              child: Divider(),
              height: 15,
            ),
            Expanded(child: Content()),
          ],
        ),
      ),
    );
  }
}
