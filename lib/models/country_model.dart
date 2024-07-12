// ignore_for_file: prefer_collection_literals, unnecessary_new

class Country {
  int? id;
  String? countryName;
  String? alpha2Code;
  String? countryCode;

  Country({this.id, this.countryName, this.alpha2Code, this.countryCode});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryName = json['country_name'];
    alpha2Code = json['alpha_2_code'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['country_name'] = countryName;
    data['alpha_2_code'] = alpha2Code;
    data['country_code'] = countryCode;
    return data;
  }
}
