

class AppColors {
  String?  primaryColor;
  String?  whiteColor;
  String?  blackColor ;
  String?  appBarColorText ;
  String?  blackLightColorText ;
  String?  blackColorText ;
  String?  blackGreyDarkColorText ;
  String?  blackGreyColorText ;
  String?  greyBlackColorText ;
  String?  blueColorText ;
  String?  blueDark ;
  String?  redDark ;
  String?  redlightDark ;
  String?  blueLightDark ;
  String?  bluelight ;
  String?  yeollowLight ;
  String?  orangeLight ;
  String?  orangeGreyLight ;
  String?  greyGreenColorText ;
  String?  greenColorText ;
  String?  lightGreyColor ;
  String?  greyColor ;
  String?  greyLightColor ;
  String?  orangeLightColor ;
  String?  greenColor ;
  String?  textFormColor ;
  String?  textFormBorderColor ;
  String?  lightBlueGreyColor ;
  String?  lightgreyBlueGreyColor ;
  String?  redColor ;
  AppColors({
      this.primaryColor,
    this.whiteColor,
    this.blackColor ,
    this.appBarColorText ,
    this.blackLightColorText ,
    this.blackColorText ,
    this.blackGreyDarkColorText ,
    this.blackGreyColorText ,
    this.greyBlackColorText ,
    this.blueColorText ,
    this.blueDark ,
    this.redDark ,
    this.redlightDark ,
    this.blueLightDark ,
    this.bluelight ,
    this.yeollowLight ,
    this.orangeLight ,
    this.orangeGreyLight ,
    this.greyGreenColorText ,
    this.greenColorText ,
    this.lightGreyColor ,
    this.greyColor ,
    this.greyLightColor ,
    this.orangeLightColor ,
    this.greenColor ,
    this.textFormColor ,
    this.textFormBorderColor ,
    this.lightBlueGreyColor ,
    this.lightgreyBlueGreyColor ,
    this.redColor ,
  });

   AppColors.fromJson(Map<String, dynamic> json) {
    primaryColor = json['primaryColor'];
    whiteColor = json['whiteColor'];
    blackColor  = json['blackColor'];
    appBarColorText  = json['appBarColorText'];
    blackLightColorText  = json['blackLightColorText'];
    blackColorText  = json['blackColorText'];
    blackGreyDarkColorText  = json['blackGreyDarkColorText'];
    blackGreyColorText  = json['blackGreyColorText'];
    greyBlackColorText  = json['greyBlackColorText'];
    blueColorText  = json['blueColorText'];
    blueDark  = json['blueDark'];
    redDark  = json['redDark'];
    redlightDark  = json['redlightDark'];
    blueLightDark  = json['blueLightDark'];
    bluelight  = json['bluelight'];
    yeollowLight  = json['yeollowLight'];
    orangeLight  = json['orangeLight'];
    orangeGreyLight  = json['orangeGreyLight'];
    greyGreenColorText  = json['greyGreenColorText'];
    greenColorText  = json['greenColorText'];
    lightGreyColor  = json['lightGreyColor'];
    greyColor  = json['greyColor'];
    greyLightColor  = json['greyLightColor'];
    orangeLightColor  = json['orangeLightColor'];
    greenColor  = json['greenColor'];
    textFormColor  = json['textFormColor'];
    textFormBorderColor  = json['textFormBorderColor'];
    lightBlueGreyColor  = json['lightBlueGreyColor'];
    lightgreyBlueGreyColor  = json['lightgreyBlueGreyColor'];
    redColor  = json['redColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['primaryColo']= primaryColor;
    data['whiteColo']= whiteColor;
    data['blackColor']= blackColor;
    data['appBarColorText']= appBarColorText;
    data['blackLightColorText']= blackLightColorText;
    data['blackColorText']= blackColorText;
    data['blackGreyDarkColorText']= blackGreyDarkColorText;
    data['blackGreyColorText']= blackGreyColorText;
    data['greyBlackColorText']= greyBlackColorText;
    data['blueColorText']= blueColorText;
    data['blueDark']= blueDark;
    data['redDark']= redDark;
    data['redlightDark']= redlightDark;
    data['blueLightDark']= blueLightDark;
    data['bluelight']= bluelight;
    data['yeollowLight']= yeollowLight;
    data['orangeLight']= orangeLight;
    data['orangeGreyLight']= orangeGreyLight;
    data['greyGreenColorText']= greyGreenColorText;
    data['greenColorText']= greenColorText;
    data['lightGreyColor']= lightGreyColor;
    data['greyColor']= greyColor;
    data['greyLightColor']= greyLightColor;
    data['orangeLightColor']= orangeLightColor;
    data['greenColor']= greenColor;
    data['textFormColor']= textFormColor;
    data['textFormBorderColor']= textFormBorderColor;
    data['lightBlueGreyColor']= lightBlueGreyColor;
    data['lightgreyBlueGreyColor']= lightgreyBlueGreyColor;
    data['redColor']= redColor;
    return data;
  }
}