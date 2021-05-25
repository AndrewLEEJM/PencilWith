class SaveNotes {
  int _id;
  String _chapterTitle;
  String _content;

  //SaveNotes(this._chapterTitle, this._content);
  SaveNotes(this._content);

  SaveNotes.withId(this._id, this._chapterTitle, this._content);

  SaveNotes.fromObject(dynamic o) {
    this._id = o['id'];
    this._chapterTitle = o['chapterTitle'];
    this._content = o['content'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['chapterTitle'] = this._chapterTitle;
    map['content'] = this._content;
    if (_id != null) {
      map['id'] = this._id;
    }
    return map;
  }

  // ignore: unnecessary_getters_setters
  int get id => _id;
  // ignore: unnecessary_getters_setters
  String get content => _content;
  // ignore: unnecessary_getters_setters
  String get chapterTitle => _chapterTitle;

  // ignore: unnecessary_getters_setters
  set content(String value) {
    _content = value;
  }

// ignore: unnecessary_getters_setters
  set chapterTitle(String value) {
    _chapterTitle = value;
  }

// ignore: unnecessary_getters_setters
  set id(int value) {
    _id = value;
  }
}
