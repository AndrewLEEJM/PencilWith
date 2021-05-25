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
    var _subPageHeight = 0.0;

    final viewInsets = EdgeInsets.fromWindowPadding(
        WidgetsBinding.instance.window.viewInsets,
        WidgetsBinding.instance.window.devicePixelRatio);

    print(viewInsets.bottom);

    if (Platform.isIOS) {
      _subPageHeight = MediaQuery.of(context).size.height * 0.76;
    } else {
      _subPageHeight = MediaQuery.of(context).size.height * 0.74;
    }
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          TextField(
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
          Divider(),
          Container(
              height: _keyboardState
                  ? _subPageHeight -
                      MediaQuery.of(context).viewInsets.bottom -
                      260
                  : _subPageHeight,
              child: Content()),
        ],
      ),
    );
  }
}
