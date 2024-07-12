// ignore_for_file: unnecessary_new

class Project {
  int? projectId;
  String? projectName;
  String? projectProfileUrl;
  String? projectDescritpion;
  int? companyId;
  String? companyName;
  List<Services>? services;

  Project(
      {this.projectId,
      this.projectName,
      this.projectProfileUrl,
      this.projectDescritpion,
      this.companyName,
      this.companyId,
      this.services});

  Project.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    projectName = json['project_name'];
    projectProfileUrl = json['project_profile_url'];
    projectDescritpion = json['project_descritpion'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['project_id'] = projectId;
    data['project_name'] = projectName;
    data['project_profile_url'] = projectProfileUrl;
    data['project_descritpion'] = projectDescritpion;
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  String? name;
  String? maximumRate;

  Services({
    this.id,
    this.name,
    this.maximumRate
  });

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    maximumRate = json['maximum_rate'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['maximum_rate'] = maximumRate;
    return data;
  }
}
