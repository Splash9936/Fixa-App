class District {
  int? districtId;
  String? districtName;

  District({this.districtId, this.districtName});

  District.fromJson(Map<String, dynamic> json) {
    districtId = json['id'];
    districtName = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = districtId;
    data['nsmae'] = districtName;

    return data;
  }
}
