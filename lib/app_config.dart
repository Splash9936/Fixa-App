
enum Endpoints { prod, staging }

class AppValues {
  String? appTitle;
  String? baseUrl;
  // AppColors? appColors;
  String? logoIcon;
  String? loginIcon;
  String? lottie;
  bool? isConfirmed;

  AppValues(
      {required this.appTitle,
      // required this.appColors,
      required this.loginIcon,
      required this.logoIcon,
      required this.baseUrl,
      required this.lottie,
      required this.isConfirmed});

  AppValues.fromJson(Map<String, dynamic> json) {
    appTitle = json['appTitle'];
    baseUrl = json['baseUrl'];
    // appColors = json['appColors'] != null ?AppColors.fromJson(json['appColors']) :null;
    logoIcon = json['logoIcon'];
    loginIcon = json['loginIcon'];
    lottie = json['lottie'];
    isConfirmed = json['isConfirmed'];
  }

    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
   data['appTitle'] =  appTitle;
    data['baseUrl'] = baseUrl;
    // if(appColors !=null){
    //   data['appColors'] = appColors!.toJson();
    // }
    data['logoIcon'] = logoIcon;
    data['loginIcon'] = loginIcon;
    data['lottie'] = lottie;
    data['isConfirmed'] = isConfirmed;
  
    return data;
  }
}

class AppConfig {
  AppValues? appValues;

  static AppConfig? _instance;

  factory AppConfig({AppValues? appValues}) {
    _instance ??= AppConfig._initialize(appValues);
    return _instance!;
  }
  AppConfig._initialize(this.appValues);
  static AppConfig get instance => _instance!;

  void updateAppValues(AppValues newValues) {
    _instance!.appValues = newValues;
  }
}
