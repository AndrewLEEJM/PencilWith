import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pencilwith/DBHelper/dbhelper.dart';
import 'package:pencilwith/models/getxcontroller.dart';
import 'package:pencilwith/models/savenotes.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

DBHelper dbHelper = new DBHelper();

// ignore: must_be_immutable
class WritePage extends StatefulWidget {
  List<SaveNotes> aList;

  WritePage(this.aList);

  @override
  _WritePageState createState() => _WritePageState(aList);
}

class _WritePageState extends State<WritePage>
    with AutomaticKeepAliveClientMixin {
  ///get사용해보기
  Controller getc = Get.put(Controller());

  List<SaveNotes> aList;

  _WritePageState(this.aList);

  var _zMode = ZefyrMode.edit;

  ///ZefyrController _zefyrController;
  FocusNode _focusNode = FocusNode();
  StreamSubscription<NotusChange> _sub;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  SaveNotes _newNote;

  Delta _tmpDelta;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    final document = _loadDocument();
    getc.zefyrController1(ZefyrController(document));
    //getc.zefyrControllerGetx.value = ZefyrController(document);

    ///_zefyrController = ZefyrController(document);
    ///_sub = _zefyrController.document.changes.listen((change) {
    _sub = getc.zefyrController1.value.document.changes.listen((change) {
      _tmpDelta = change.change;
      print('${change.source}: !${change.change}!');
    });
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    ///_zefyrController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  NotusDocument _loadDocument() {
    if (aList.length == 0) {
      final Delta _delta = Delta()..insert("데이터를 입력하세요....\n");
      return NotusDocument.fromDelta(_delta);
    } else {
      //return NotusDocument.fromJson(jsonDecode(_newNote.content));
      return NotusDocument.fromJson(jsonDecode(aList[0].content));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (aList.length != 0) {
      print('데이터 수:${aList.length}');
    } else {
      print('notes is null');
    }

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     setState(() {
      //       // NotusDocument.fromDelta(_tmpDelta);
      //     });
      //     _save();
      //   },
      // ),
      body: Container(
        child: ZefyrScaffold(
          key: _scaffoldKey,
          child: ZefyrEditor(
            padding: EdgeInsets.all(8),
            controller: getc.zefyrController1.value, //_zefyrController,
            focusNode: _focusNode,
            mode: _zMode,
            autofocus: false,
          ),
        ),
      ),
    );
  }

  void _save() {
    ///final content = jsonEncode(_zefyrController.document);
    final content = jsonEncode(getc.zefyrController1.value.document);
    //debugPrint('save debug: ${content.toString()}');
    _newNote = SaveNotes(content);
    //_newNote = SaveNotes('');
    //_newNote.content = content;
    if (_newNote.id != null) {
      //write update logic here
    } else {
      dbHelper.insertNote(_newNote);
      print('save complete');
    }
  }
}
