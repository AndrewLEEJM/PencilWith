class Newbie {
  Header header;
  Body body;

  Newbie({this.header, this.body});

  Newbie.fromJson(Map<String, dynamic> json) {
    header =
        json['header'] != null ? new Header.fromJson(json['header']) : null;
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    if (this.body != null) {
      data['body'] = this.body.toJson();
    }
    return data;
  }
}

class Header {
  int code;
  String reason;
  Null detail;

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

class Body {
  String accessToken;
  String userId;
  String jwtToken;
  bool registered;

  Body({this.accessToken, this.userId, this.jwtToken, this.registered});

  Body.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    userId = json['userId'];
    jwtToken = json['jwtToken'];
    registered = json['registered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['userId'] = this.userId;
    data['jwtToken'] = this.jwtToken;
    data['registered'] = this.registered;
    return data;
  }
}
