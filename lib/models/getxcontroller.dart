import 'dart:convert';

import 'package:get/get.dart';
import 'package:pencilwith/DBHelper/dbhelper.dart';
import 'package:pencilwith/models/postitmodel.dart';
import 'package:pencilwith/models/savenotes.dart';
import 'package:pencilwith/models/todolistmodel.dart';

DBHelper dbHelper = new DBHelper();

class Controller extends GetxController {
  var selectedIndex = 0.obs;
  var novelList = [].obs;

  var textIndex = 0.obs;
  var maxTextCount = 0.obs;

  //var selectProject = "Project".obs;

  var selectProjectInfo = ProjectInfo('0', 'Project', 'My').obs;

  RxInt aa = 0.obs;

  void changeClass(ProjectInfo aProject) {
    this.selectProjectInfo(aProject);
    update();
  }

  RxList<PostModel> getXPostModelList = [
    PostModel(id: 1, date: '210511', title: 'title1', content: 'content1'),
    PostModel(id: 2, date: '210511', title: 'title2', content: 'content2'),
    PostModel(id: 2, date: '210511', title: 'title2', content: 'content2'),
    PostModel(id: 2, date: '210511', title: 'title2', content: 'content2'),
    PostModel(id: 2, date: '210511', title: 'title2', content: 'content2'),
    PostModel(id: 2, date: '210511', title: 'title2', content: 'content2'),
    PostModel(id: 2, date: '210511', title: 'title2', content: 'content2'),
    PostModel(id: 2, date: '210511', title: 'title2', content: 'content2'),
    PostModel(id: 2, date: '210511', title: 'title2', content: 'content2'),
    PostModel(id: 2, date: '210511', title: 'title2', content: 'content2'),
  ].obs;

  RxList<TodoModel> getXTodoModelList = [
    TodoModel(
        id: 1,
        date: '210511',
        title: 'title2',
        content: 'content1',
        isDone: true),
    TodoModel(
        id: 1,
        date: '210511',
        title: 'title1',
        content: 'content1',
        isDone: false),
    TodoModel(
        id: 1,
        date: '210511',
        title: 'title3',
        content: 'content1',
        isDone: false),
    TodoModel(
        id: 1,
        date: '210511',
        title: 'title4',
        content: 'content1',
        isDone: true),
  ].obs;

  var modifiedPostItList = [].obs;
  //  var selectedPageIndex = 0.obs;
  //var zefyrControllerGetx = null.obs;

  void increase() {
    aa++;
  }

  void insertPostModel(PostModel model) {
    getXPostModelList.add(model);
    makingGridList2();
  }

  void insertTodoModel(TodoModel model) {
    getXTodoModelList.add(model);
  }

  void pageIndexMove(int index) {
    selectedIndex.value = index;
    update();
  }

  void saveInCtl() {
    // SaveNotes _newNote;
    // final content = jsonEncode(this.zefyrController1.value.document);
    // _newNote = SaveNotes(content);
    // if (_newNote.id != null) {
    //   //write update logic here
    // } else {
    //   dbHelper.insertNote(_newNote);
    //   print('save complete');
    // }
  }

  List makingGridList2() {
    final int maxGridCount = 9;
    //List result = [];

    modifiedPostItList([]);

    int pageCount =
        (Get.find<Controller>().getXPostModelList.length / maxGridCount).ceil();

    print(pageCount);

    int index = 0;
    int restrictCount = 0;

    for (int i = 0; i < pageCount; i++) {
      //page 별로 리스트 만듬
      List tmpList = []; //해당 페이지 내 리스트
      if (Get.find<Controller>().getXPostModelList.length - index + 1 <
          maxGridCount) {
        restrictCount =
            (Get.find<Controller>().getXPostModelList.length - index);
      } else {
        restrictCount = maxGridCount;
      }
      for (int j = 0; j < restrictCount; j++) {
        tmpList.add(Get.find<Controller>().getXPostModelList[index]);
        index++;
      }
      modifiedPostItList.add(tmpList);
    }
    //return modifiedPostItList;
  }
}

class ProjectInfo {
  String _projectId;
  String _title;
  String _group;

  ProjectInfo(this._projectId, this._title, this._group);

  String get group => _group;

  set group(String value) {
    _group = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get projectId => _projectId;

  set projectId(String value) {
    _projectId = value;
  }
}
