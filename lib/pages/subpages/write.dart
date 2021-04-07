import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class WritePage extends StatefulWidget {
  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  ZefyrController _zefyrController;
  FocusNode _focusNode;

  @override
  void initState() {
    final document = _loadDocument();
    _zefyrController = ZefyrController(document);
    _focusNode = FocusNode();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _zefyrController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  NotusDocument _loadDocument() {
    final Delta _delta = Delta()..insert("옛날 예날에 어느 마을에 요괴의 냄새를 맡을수 있는...\n");
    return NotusDocument.fromDelta(_delta);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ZefyrScaffold(
      child: ZefyrEditor(
        padding: EdgeInsets.all(8),
        controller: _zefyrController,
        focusNode: _focusNode,
      ),
    ));
  }
}
