class NoteObject {
  String id;
  String div;
  String title;
  String content;
  String date;
  String done;

  NoteObject(
      {this.id, this.div, this.title, this.content, this.date, this.done});

  NoteObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    div = json['div'];
    title = json['title'];
    content = json['content'];
    date = json['date'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['div'] = this.div;
    data['title'] = this.title;
    data['content'] = this.content;
    data['date'] = this.date;
    data['done'] = this.done;
    return data;
  }
}
