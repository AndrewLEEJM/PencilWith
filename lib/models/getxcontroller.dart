import 'dart:convert';

import 'package:get/get.dart';
import 'package:pencilwith/models/chapterobject.dart';
import 'package:pencilwith/models/noteobject.dart';
import 'package:pencilwith/models/postitmodel.dart';
import 'package:pencilwith/models/projectclass.dart';

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

  RxList allNoteList = [].obs;

  void splitList() {
    getXPostModelList([]);
    getXTodoModelList([
      NoteObject(
          id: 'plus',
          div: 'TODO',
          title: 'plus',
          content: 'plus',
          date: '19991212',
          done: 'false'),
    ]);
    allNoteList.forEach((element) {
      if (element.div == 'POST') {
        getXPostModelList.add(element);
      } else {
        getXTodoModelList.removeLast();
        getXTodoModelList.add(element);
        getXTodoModelList.add(
          NoteObject(
              id: 'plus',
              div: 'TODO',
              title: 'plus',
              content: 'plus',
              date: '19991212',
              done: 'false'),
        );
      }
    });
    makingGridList2();
    update();
  }

  void noteListClear() {
    if (allNoteList != null) {
      allNoteList.clear();
    }
  }

  void insertAllNoteList(NoteObject no) {
    allNoteList.add(no);
    update();
  }

  //포스트잇 모양
  RxList getXPostModelList = [].obs;
  var modifiedPostItList = [].obs;

  //투두리스트 모양
  RxList getXTodoModelList = [].obs;

  void pageIndexMove(int index) {
    selectedIndex.value = index;
    update();
  }

  List<ChapterObject> chapterRealList = [];

  void chapterListClear() {
    if (chapterRealList != null) {
      this.chapterRealList = [];
    }
  }

  // void equalChapterList(List<ChapterObject> param) {
  //   this.chapterRealList = param;
  //   update();
  // }

  void insertAllChapterList(ChapterObject co) {
    chapterRealList.add(co);

    chapterRealList.forEach((element) {
      print(element.title);
    });

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
        (((Get.find<Controller>().getXPostModelList.length ?? 0) + 1) /
                maxGridCount)
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
