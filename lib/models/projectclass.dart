class ProjectBaby {
  int projectId;
  String ownerId;
  String title;
  String createdAt;
  String status;
  List<ChapterList> chapterList;
  List<CrewList> crewList;

  ProjectBaby(
      {this.projectId,
      this.ownerId,
      this.title,
      this.createdAt,
      this.status,
      this.chapterList,
      this.crewList});

  ProjectBaby.fromJson(Map<String, dynamic> json) {
    projectId = json['projectId'];
    ownerId = json['ownerId'];
    title = json['title'];
    createdAt = json['createdAt'];
    status = json['status'];
    if (json['chapterList'] != null) {
      chapterList = new List<ChapterList>();
      json['chapterList'].forEach((v) {
        chapterList.add(new ChapterList.fromJson(v));
      });
    }
    if (json['crewList'] != null) {
      crewList = new List<CrewList>();
      json['crewList'].forEach((v) {
        crewList.add(new CrewList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectId'] = this.projectId;
    data['ownerId'] = this.ownerId;
    data['title'] = this.title;
    data['createdAt'] = this.createdAt;
    data['status'] = this.status;
    if (this.chapterList != null) {
      data['chapterList'] = this.chapterList.map((v) => v.toJson()).toList();
    }
    if (this.crewList != null) {
      data['crewList'] = this.crewList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChapterList {
  int chapterId;
  Null content;
  String createAt;
  String status;
  String title;

  ChapterList(
      {this.chapterId, this.content, this.createAt, this.status, this.title});

  ChapterList.fromJson(Map<String, dynamic> json) {
    chapterId = json['chapterId'];
    content = json['content'];
    createAt = json['createAt'];
    status = json['status'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapterId'] = this.chapterId;
    data['content'] = this.content;
    data['createAt'] = this.createAt;
    data['status'] = this.status;
    data['title'] = this.title;
    return data;
  }
}

class CrewList {
  String id;
  Null name;
  String genderType;
  String birth;
  Null locationType;
  String careerType;
  Null introduction;
  Null profileImage;

  CrewList(
      {this.id,
      this.name,
      this.genderType,
      this.birth,
      this.locationType,
      this.careerType,
      this.introduction,
      this.profileImage});

  CrewList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    genderType = json['genderType'];
    birth = json['birth'];
    locationType = json['locationType'];
    careerType = json['careerType'];
    introduction = json['introduction'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['genderType'] = this.genderType;
    data['birth'] = this.birth;
    data['locationType'] = this.locationType;
    data['careerType'] = this.careerType;
    data['introduction'] = this.introduction;
    data['profileImage'] = this.profileImage;
    return data;
  }
}
