class AppEnv {
  int? id;
  String? url;
  String? companyName;
  

  AppEnv(
      {this.id,
      this.url,
      this.companyName});

  AppEnv.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    url = json['url'] ?? 0;
    companyName = json['company_name'] ?? 0;
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['company_name'] = companyName;
    return data;
  }
}