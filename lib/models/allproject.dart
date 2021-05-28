class AllProject {
  List<OwnerProjects> ownerProjects;
  List<CrewProjects> crewProjects;

  AllProject({this.ownerProjects, this.crewProjects});

  AllProject.fromJson(Map<String, dynamic> json) {
    if (json['ownerProjects'] != null) {
      ownerProjects = new List<OwnerProjects>();
      json['ownerProjects'].forEach((v) {
        ownerProjects.add(new OwnerProjects.fromJson(v));
      });
    }
    if (json['crewProjects'] != null) {
      crewProjects = new List<CrewProjects>();
      json['crewProjects'].forEach((v) {
        crewProjects.add(new CrewProjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ownerProjects != null) {
      data['ownerProjects'] =
          this.ownerProjects.map((v) => v.toJson()).toList();
    }
    if (this.crewProjects != null) {
      data['crewProjects'] = this.crewProjects.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OwnerProjects {
  int projectId;
  String title;

  OwnerProjects({this.projectId, this.title});

  OwnerProjects.fromJson(Map<String, dynamic> json) {
    projectId = json['projectId'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectId'] = this.projectId;
    data['title'] = this.title;
    return data;
  }
}

class CrewProjects {
  int projectId;
  String title;

  CrewProjects({this.projectId, this.title});

  CrewProjects.fromJson(Map<String, dynamic> json) {
    projectId = json['projectId'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectId'] = this.projectId;
    data['title'] = this.title;
    return data;
  }
}
