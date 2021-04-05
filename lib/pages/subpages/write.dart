import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pencilwith/models/writemodel.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class WritePage extends StatefulWidget {
  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final ZefyrController _controller = ZefyrController(NotusDocument.fromDelta(
      Delta.fromJson(json.decode(basicContent) as List)));
  final FocusNode _focusNode = FocusNode();
  bool _editing = true;
  StreamSubscription<NotusChange> _sub;

  @override
  void initState() {
    super.initState();
    _sub = _controller.document.changes.listen((change) {
      print('${change.source}: ${change.change}');
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // FocusScopeNode currentFocus = FocusScope.of(context);
    // currentFocus.unfocus();
    // FocusScope.of(context).unfocus();

    print('write dispose');
    //FocusScope.of(context).requestFocus(FocusNode());
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZefyrScaffold(
      child: ZefyrEditor(
          controller: _controller, focusNode: _focusNode, mode: ZefyrMode.edit
          //mode: _editing ? ZefyrMode.edit : ZefyrMode.select,
//        imageDelegate: CustomImageDelegate(),
//          keyboardAppearance: _darkTheme ? Brightness.dark : Brightness.light,
          ),
    );
  }
}
