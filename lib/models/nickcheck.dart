class NickCheck {
  Header header;
  bool body;

  NickCheck({this.header, this.body});

  NickCheck.fromJson(Map<String, dynamic> json) {
    header =
        json['header'] != null ? new Header.fromJson(json['header']) : null;
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    data['body'] = this.body;
    return data;
  }
}

class Header {
  int code;
  String reason;
  String detail;

  Header({this.code, this.reason, this.detail});

  Header.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    reason = json['reason'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['reason'] = this.reason;
    data['detail'] = this.detail;
    return data;
  }
}
