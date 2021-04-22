class SaveNotes {
  int _id;
  String _content;

  SaveNotes(this._content);

  SaveNotes.withId(this._id, this._content);

  SaveNotes.fromObject(dynamic o) {
    this._id = o['id'];
    this._content = o['content'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['content'] = this._content;
    if (_id != null) {
      map['id'] = this._id;
    }
    return map;
  }

  // ignore: unnecessary_getters_setters
  String get content => _content;

  // ignore: unnecessary_getters_setters
  set content(String value) {
    _content = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}
