class SigninObject {
  Header header;
  Body body;

  SigninObject({this.header, this.body});

  SigninObject.fromJson(Map<String, dynamic> json) {
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

class Body {
  String accessToken;
  String userAgreement;
  String jwtToken;
  String userId;
  bool registered;

  Body(
      {this.accessToken,
      this.userAgreement,
      this.jwtToken,
      this.userId,
      this.registered});

  Body.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    userAgreement = json['userAgreement'];
    jwtToken = json['jwtToken'];
    userId = json['userId'];
    registered = json['registered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['userAgreement'] = this.userAgreement;
    data['jwtToken'] = this.jwtToken;
    data['userId'] = this.userId;
    data['registered'] = this.registered;
    return data;
  }
}
