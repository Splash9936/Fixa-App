// import 'package:fixa/constants/colors.dart';
// import 'package:fixa/constants/images.dart';
// import 'package:fixa/constants/sizeConfig.dart';
// import 'package:fixa/constants/text_styling.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class DefaultButton extends StatelessWidget {
//   final String? text;
//   final GestureTapCallback? press;
//   const DefaultButton({
//     Key? key,
//     this.text,
//     this.press,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: press,
//       child: SizedBox(
//         width: double.infinity,
//         height: SizeConfig.heightMultiplier * 6,
//         child: ElevatedButton(
//           style: ButtonStyle(
//               shape: MaterialStateProperty.all(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               backgroundColor: MaterialStateProperty.all<Color>(primaryColor)),
//           onPressed: press,
//           child: Text(
//             text!,
//             style: TextStyling.simpleWhiteTextStyle,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DefaultButtonR extends StatelessWidget {
//   final String? text;
//   final GestureTapCallback? press;

//   const DefaultButtonR({
//     Key? key,
//     this.text,
//     this.press,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: press,
//       child: SizedBox(
//         width: double.infinity,
//         height: SizeConfig.heightMultiplier * 6,
//         child: ElevatedButton(
//           style: ButtonStyle(
//               shape: MaterialStateProperty.all(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               backgroundColor: MaterialStateProperty.all<Color>(redColor)),
//           onPressed: press,
//           child: Text(
//             text!,
//             style: TextStyling.simpleWhiteTextStyle,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DefaultButtonW extends StatelessWidget {
//   final String? text;
//   final GestureTapCallback? press;
//   DefaultButtonW({
//     Key? key,
//     this.text,
//     this.press,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (_networkController.state is NetworkMobileConnected ||
//           _networkController.state is NetworkWifiConnected) {
//         return GestureDetector(
//           onTap: press,
//           child: SizedBox(
//             width: double.infinity,
//             height: SizeConfig.heightMultiplier * 6,
//             child: ElevatedButton(
//               style: ButtonStyle(
//                   shape: MaterialStateProperty.all(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(primaryColor)),
//               onPressed: press,
//               child: Text(
//                 text!,
//                 style: TextStyling.simpleWhiteTextStyle,
//               ),
//             ),
//           ),
//         );
//       }
//       if (_networkController.state is NetworkNotConnected) {
//         return GestureDetector(
//           child: SizedBox(
//             width: double.infinity,
//             height: SizeConfig.heightMultiplier * 6,
//             child: ElevatedButton(
//               style: ButtonStyle(
//                   shape: MaterialStateProperty.all(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(whiteColor)),
//               onPressed: press,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "No network, Please check your Network",
//                     style: TextStyling.simplTextStyle,
//                   ),
//                   SizedBox(width: SizeConfig.widthMultiplier * 3),
//                   Image.asset(
//                     Images.noInternetImg,
//                     height: SizeConfig.heightMultiplier * 1.5,
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       }
//       return GestureDetector(
//         child: SizedBox(
//           width: double.infinity,
//           height: SizeConfig.heightMultiplier * 6,
//           child: ElevatedButton(
//             style: ButtonStyle(
//                 shape: MaterialStateProperty.all(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 backgroundColor: MaterialStateProperty.all<Color>(whiteColor)),
//             onPressed: press,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "No network, Please check your Network",
//                   style: TextStyling.simplTextStyle,
//                 ),
//                 SizedBox(width: SizeConfig.widthMultiplier * 3),
//                 Image.asset(
//                   Images.noInternetImg,
//                   height: SizeConfig.heightMultiplier * 1.5,
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
