import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pencilwith/DBHelper/dbhelper.dart';
import 'package:pencilwith/models/getxcontroller.dart';
import 'package:pencilwith/models/savenotes.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

DBHelper dbHelper = new DBHelper();

class WritePage extends StatefulWidget {
  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage>
    with AutomaticKeepAliveClientMixin {
  var _zMode = ZefyrMode.edit;

  //Controller cc = Get.find();
  var c1 = Get.put(Controller());

  ZefyrController _zefyrController;
  FocusNode _focusNode = FocusNode();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //temporary
  SaveNotes _newNote = new SaveNotes("");

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    final document = _loadDocument();
    _zefyrController = ZefyrController(document);
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _zefyrController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  NotusDocument _loadDocument() {
    print('load doc');
    if (c1.novelList.value[3] == null) {
      print('1');
      final Delta _delta = Delta()..insert("데이터를 입력하세요....\n");
      return NotusDocument.fromDelta(_delta);
    } else {
      print('2');
      print('near');
      return NotusDocument.fromJson(jsonDecode(c1.novelList.value[3].content));
    }
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    if (c1.novelList.value[3] != null) {
      //print(_notes.content.toString());
    } else {
      print('notes is null');
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _save();
        },
      ),
      body: Container(
        child: ZefyrScaffold(
          key: _scaffoldKey,
          child: ZefyrEditor(
            padding: EdgeInsets.all(8),
            controller: _zefyrController,
            focusNode: _focusNode,
            mode: _zMode,
            autofocus: false,
          ),
        ),
      ),
    );
  }

  void _save() {
    final content = jsonEncode(_zefyrController.document);
    debugPrint('save debug: ${content.toString()}');
    _newNote.content = content;
    if (_newNote.id != null) {
      //write update logic here
      print('null is no');
    } else {
      dbHelper.insertNote(_newNote);
    }
  }
}
