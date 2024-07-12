import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

const Color primaryColor = Color(0xff08b7bb);
Color whiteColor = HexColor("#FFFFFF");
const kSecondaryColor = Color(0xFF979797);
const Color whiteGreyColor = Color(0xfff5f6fa);
const Color blackColor = Colors.black;
Color bluewhite = HexColor("#f4f6f9");
Color appBarColorText = HexColor("#414A52");
Color blackLightColorText = HexColor("#1C2123");
Color blackColorText = HexColor("#24282C");
Color blackGreyDarkColorText = HexColor("#505E64");
Color blackGreyColorText = HexColor("#F7F9FA");
Color greyBlackColorText = HexColor("#798C9A");
Color blueColorText = HexColor("#00A1DE");
Color blueDark = HexColor("#0291C8");
Color redDark = HexColor("#F5222D");
Color redlightDark = HexColor("#FFD8BF");
Color blueLightDark = HexColor("#015777");
Color bluelight = HexColor("#67D5FF");
Color yeollowLight = HexColor("#FFF1B8");
Color orangeLight = HexColor("#FA8C16");
Color orangeLightDark = HexColor("#FFA940");
Color orangeGreyLight = HexColor("#FA541C");
Color greyGreenColorText = HexColor("#E8FAFA");
Color greenColorText = HexColor("#0DA35B");
Color lightGreyColor = HexColor("#D6DCDC");
Color greyColor = HexColor("#E4EEF3");
Color greyLightColor = HexColor("#D9D9D9");
Color orangeLightColor = HexColor("#FAAD14");
Color greenColor = HexColor("#52C41A");
Color textFormColor = HexColor("#DFF3FB");
Color textFormBorderColor = HexColor("#CCDBE1");
Color lightBlueGreyColor = HexColor("#A8BEC5");
Color lightgreyBlueGreyColor = HexColor("#F2FAFD");
// const Color greenColor = Colors.green;
const Color blackGreyColor = Color(0xff9a99a2);
const Color yellowColor = Color(0xffffcc0c);
const Color almostYellowColor = Color(0xffF7DFB9);
const Color redColor = Colors.red;

// import 'package:flutter/material.dart';

// import '../app_config.dart';

// class HexColor extends Color {
//   static int _getColorFromHex(String hexColor) {
//     hexColor = hexColor.toUpperCase().replaceAll("#", "");
//     if (hexColor.length == 6) {
//       hexColor = "FF" + hexColor;
//     }
//     return int.parse(hexColor, radix: 16);
//   }

//   HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
// }


// Color primaryColor = HexColor(AppConfig.instance.appValues!.appColors!.primaryColor!);
// Color whiteColor = Colors.white;
// // Color kSecondaryColor = HexColor(AppConfig.instance.appValues!.appColors!.kSecondaryColor);
// //  Color whiteGreyColor = HexColor(AppConfig.instance.appValues!.appColors!.whiteColor!);

//  Color blackColor = HexColor(AppConfig.instance.appValues!.appColors!.blackColor!);
// // Color bluewhite = HexColor(AppConfig.instance.appValues!.appColors!.bluewhite!);
// Color appBarColorText = HexColor(AppConfig.instance.appValues!.appColors!.appBarColorText!);
// Color blackLightColorText = HexColor(AppConfig.instance.appValues!.appColors!.blackLightColorText!);
// Color blackColorText = HexColor(AppConfig.instance.appValues!.appColors!.blackColorText!);
// Color blackGreyDarkColorText = HexColor(AppConfig.instance.appValues!.appColors!.blackGreyDarkColorText!);
// Color blackGreyColorText = HexColor(AppConfig.instance.appValues!.appColors!.blackGreyColorText!);
// Color greyBlackColorText = HexColor(AppConfig.instance.appValues!.appColors!.greyBlackColorText!);
// Color blueColorText = HexColor(AppConfig.instance.appValues!.appColors!.blueColorText!);
// Color blueDark = HexColor(AppConfig.instance.appValues!.appColors!.blueDark!);
// Color redDark = HexColor(AppConfig.instance.appValues!.appColors!.redDark!);
// Color redlightDark = HexColor(AppConfig.instance.appValues!.appColors!.redlightDark!);
// Color blueLightDark = HexColor(AppConfig.instance.appValues!.appColors!.blueLightDark!);
// Color bluelight = HexColor(AppConfig.instance.appValues!.appColors!.bluelight!);
// Color yeollowLight = HexColor(AppConfig.instance.appValues!.appColors!.yeollowLight!);
// Color orangeLight = HexColor(AppConfig.instance.appValues!.appColors!.orangeLight!);
// // Color orangeLightDark = HexColor(AppConfig.instance.appValues!.appColors!.orangeLightDark!);
// Color orangeGreyLight = HexColor(AppConfig.instance.appValues!.appColors!.orangeGreyLight!);
// Color greyGreenColorText = HexColor(AppConfig.instance.appValues!.appColors!.greyGreenColorText!);
// Color greenColorText = HexColor(AppConfig.instance.appValues!.appColors!.greenColorText!);
// Color lightGreyColor = HexColor(AppConfig.instance.appValues!.appColors!.lightGreyColor!);
// Color greyColor = HexColor(AppConfig.instance.appValues!.appColors!.greyColor!);
// Color greyLightColor = HexColor(AppConfig.instance.appValues!.appColors!.greyLightColor!);
// Color orangeLightColor = HexColor(AppConfig.instance.appValues!.appColors!.orangeLightColor!);
// Color greenColor = HexColor(AppConfig.instance.appValues!.appColors!.greenColor!);
// Color textFormColor = HexColor(AppConfig.instance.appValues!.appColors!.textFormColor!);
// Color textFormBorderColor = HexColor(AppConfig.instance.appValues!.appColors!.textFormBorderColor!);
// Color lightBlueGreyColor = HexColor(AppConfig.instance.appValues!.appColors!.lightBlueGreyColor!);
// Color lightgreyBlueGreyColor = HexColor(AppConfig.instance.appValues!.appColors!.lightgreyBlueGreyColor!);
// // const Color greenColor = Colors.green;
// // const Color blackGreyColor = Color(0xff9a99a2);
// // const Color yellowColor = Color(0xffffcc0c);
// // const Color almostYellowColor = Color(0xffF7DFB9);
//  Color redColor = HexColor(AppConfig.instance.appValues!.appColors!.redColor!);


// final Map<String, dynamic> fixaColors = {
//   "primaryColor": "#f4f6f9",
//   "whiteColor": "#FFFFFF",
//   "blackColor": "#000000",
//   "appBarColorText": "#414A52",
//   "blackLightColorText": "#1C2123",
//   "blackColorText": "#24282C",
//   "blackGreyDarkColorText": "#505E64",
//   "blackGreyColorText": "#F7F9FA",
//   "greyBlackColorText": "#798C9A",
//   "blueColorText": "#00A1DE",
//   "blueDark": "#0291C8",
//   "redDark": "#F5222D",
//   "redlightDark": "#FFD8BF",
//   "blueLightDark": "#015777",
//   "bluelight": "#67D5FF",
//   "yeollowLight": "#FFF1B8",
//   "orangeLight": "#FA8C16",
//   "orangeGreyLight": "#FA541C",
//   "greyGreenColorText": "#E8FAFA",
//   "greenColorText": "#0DA35B",
//   "lightGreyColor": "#D6DCDC",
//   "greyColor": "#E4EEF3",
//   "greyLightColor": "#D9D9D9",
//   "orangeLightColor": "#FAAD14",
//   "greenColor": "#52C41A",
//   "textFormColor": "#DFF3FB",
//   "textFormBorderColor": "#CCDBE1",
//   "lightBlueGreyColor": "#A8BEC5",
//   "lightgreyBlueGreyColor": "#F2FAFD",
//   "redColor": "#F5222D",
// };


// final Map<String, dynamic> rclColors = {
//   "primaryColor": "#f4f6f9",
//   "whiteColor": "#FFFFFF",
//   "blackColor": "#000000",
//   "appBarColorText": "#414A52",
//   "blackLightColorText": "#1C2123",
//   "blackColorText": "#24282C",
//   "blackGreyDarkColorText": "#505E64",
//   "blackGreyColorText": "#F7F9FA",
//   "greyBlackColorText": "#798C9A",
//   "blueColorText": "#fed53c",
//   "blueDark": "#fed53c",
//   "redDark": "#F5222D",
//   "redlightDark": "#FFD8BF",
//   "blueLightDark": "#015777",
//   "bluelight": "#FFFFFF",
//   "yeollowLight": "#FFF1B8",
//   "orangeLight": "#FA8C16",
//   "orangeGreyLight": "#FA541C",
//   "greyGreenColorText": "#E8FAFA",
//   "greenColorText": "#0DA35B",
//   "lightGreyColor": "#D6DCDC",
//   "greyColor": "#E4EEF3",
//   "greyLightColor": "#D9D9D9",
//   "orangeLightColor": "#FAAD14",
//   "greenColor": "#52C41A",
//   "textFormColor": "#fffee0",
//   "textFormBorderColor": "#CCDBE1",
//   "lightBlueGreyColor": "#A8BEC5",
//   "lightgreyBlueGreyColor": "#F2FAFD",
//   "redColor": "#F5222D",
// };



// final Map<String, dynamic> shelterColors = {
//   "primaryColor": "#f4f6f9",
//   "whiteColor": "#FFFFFF",
//   "blackColor": "#000000",
//   "appBarColorText": "#414A52",
//   "blackLightColorText": "#1C2123",
//   "blackColorText": "#24282C",
//   "blackGreyDarkColorText": "#505E64",
//   "blackGreyColorText": "#F7F9FA",
//   "greyBlackColorText": "#798C9A",
//   "blueColorText": "#1E1E1E",
//   "blueDark": "#2E2E2E",
//   "redDark": "#F5222D",
//   "redlightDark": "#FFD8BF",
//   "blueLightDark": "#015777",
//   "bluelight": "#FFFFFF",
//   "yeollowLight": "#FFF1B8",
//   "orangeLight": "#FA8C16",
//   "orangeGreyLight": "#FA541C",
//   "greyGreenColorText": "#E8FAFA",
//   "greenColorText": "#0DA35B",
//   "lightGreyColor": "#D6DCDC",
//   "greyColor": "#E4EEF3",
//   "greyLightColor": "#D9D9D9",
//   "orangeLightColor": "#FAAD14",
//   "greenColor": "#52C41A",
//   "textFormColor": "#e5e5e5",
//   "textFormBorderColor": "#CCDBE1",
//   "lightBlueGreyColor": "#A8BEC5",
//   "lightgreyBlueGreyColor": "#F2FAFD",
//   "redColor": "#F5222D",
// };