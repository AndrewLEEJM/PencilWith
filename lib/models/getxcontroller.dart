import 'dart:convert';

import 'package:get/get.dart';
import 'package:pencilwith/DBHelper/dbhelper.dart';
import 'package:pencilwith/models/savenotes.dart';
import 'package:zefyr/zefyr.dart';

// double pixelRatio = MediaQuery.of(context).devicePixelRatio;
// double px = 1 / pixelRatio;

DBHelper dbHelper = new DBHelper();

class Controller extends GetxController {
  var selectedIndex = 0.obs;
  var width = 0.0.obs;
  var novelList = [].obs;
  var zefyrController1 = Rx<ZefyrController>();

  //var zefyrControllerGetx = null.obs;

  void saveInCtl() {
    SaveNotes _newNote;
    final content = jsonEncode(this.zefyrController1.value.document);
    _newNote = SaveNotes(content);
    if (_newNote.id != null) {
      //write update logic here
    } else {
      dbHelper.insertNote(_newNote);
      print('save complete');
    }
  }
}
