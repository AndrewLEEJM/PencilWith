class UserProfile {
  String id;
  String name;
  String genderType;
  String birth;
  String locationType;
  String careerType;
  String introduction;
  String profileImage;

  UserProfile(
      {this.id,
      this.name,
      this.genderType,
      this.birth,
      this.locationType,
      this.careerType,
      this.introduction,
      this.profileImage});

  UserProfile.fromJson(Map<String, dynamic> json) {
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
