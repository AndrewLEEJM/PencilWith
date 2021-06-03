class ChapterObject {
  String id;
  String idx;
  String title;
  String content;
  String date;

  ChapterObject({this.id, this.idx, this.title, this.content, this.date});

  ChapterObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idx = json['idx'];
    title = json['title'];
    content = json['content'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idx'] = this.idx;
    data['title'] = this.title;
    data['content'] = this.content;
    data['date'] = this.date;
    return data;
  }
}
