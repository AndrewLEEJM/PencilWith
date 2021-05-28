import 'dart:convert';

import 'package:get/get.dart';
import 'package:pencilwith/DBHelper/dbhelper.dart';
import 'package:pencilwith/models/postitmodel.dart';
import 'package:pencilwith/models/projectclass.dart';
//import 'package:pencilwith/models/savenotes.dart';
import 'package:pencilwith/models/todolistmodel.dart';

DBHelper dbHelper = new DBHelper();

class Controller extends GetxController {
  //tab page index
  var selectedIndex = 0.obs;

  //글쓰기 인데스 포인터 값
  var textIndex = 0.obs;
  var maxTextCount = 0.obs;

  //var selectProject = "Project".obs;

  //var selectProjectInfo = ProjectInfo('0', 'Project', 'My').obs;

  //신규프로젝트 리스트를 들고있고

  //var projectBaby = ProjectBaby().obs;
  var currentProject = ProjectBaby().obs;

  void changeProject(ProjectBaby selectProject) {
    this.currentProject(selectProject);
    update();
  }

  //포스트잇 모양
  RxList<PostModel> getXPostModelList = [
    PostModel(
        id: '1',
        date: '210511',
        title: 'titl12312321321312312321sadfasfasfsfsadse1',
        content: 'content1'),
    PostModel(id: '1', date: '210511', title: 'title1', content: 'content1'),
    PostModel(id: '1', date: '210511', title: 'title1', content: 'content1'),
    PostModel(id: '1', date: '210511', title: 'title1', content: 'content1'),
  ].obs;

  var modifiedPostItList = [].obs;

  //todo리스트 모양
  RxList<TodoModel> getXTodoModelList = [
    TodoModel(
        id: '1',
        date: '210511',
        title: 'title2',
        content: 'content1',
        isDone: 'true'),
    TodoModel(
        id: 'plus',
        date: '210511',
        title: 'title2',
        content: 'content1',
        isDone: 'true'),
  ].obs;

  void insertPostModel(PostModel model) {
    getXPostModelList.add(model);
    makingGridList2();
  }

  void insertTodoModel(TodoModel model) {
    getXTodoModelList.removeLast();
    getXTodoModelList.add(model);
    getXTodoModelList.add(
      TodoModel(
          id: 'plus',
          date: '210511',
          title: 'title2',
          content: 'content1',
          isDone: 'true'),
    );
    //getXTodoModelList.sort((a., b) => a.compareTo(b));
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

    modifiedPostItList([]);

    int pageCount =
        //   (Get.find<Controller>().getXPostModelList.length / maxGridCount).ceil();
        ((Get.find<Controller>().getXPostModelList.length + 1) / maxGridCount)
            .ceil();

    int index = 0;
    int restrictCount = 0;

    for (int i = 0; i < pageCount; i++) {
      //page 별로 리스트 만듬
      List<dynamic> tmpList = []; //해당 페이지 당 포스트 리스트
      if (Get.find<Controller>().getXPostModelList.length + 1 - index <
          maxGridCount) {
        restrictCount =
            (Get.find<Controller>().getXPostModelList.length + 1 - index);
      } else {
        restrictCount = maxGridCount;
      }
      for (int j = 0; j < restrictCount; j++) {
        if (index == getXPostModelList.length) {
          tmpList.add(
            PostModel(
                id: 'plus', date: '210511', title: '추가하기', content: 'content1'),
          );
        } else {
          tmpList.add(Get.find<Controller>().getXPostModelList[index]);
          index++;
        }
      }
      modifiedPostItList.add(tmpList);
    }
    //return modifiedPostItList;
  }
}
