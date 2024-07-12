// // ignore_for_file: prefer_const_constructors

// import 'package:fixa/fixa_main_routes.dart';

// class HomeWorkerProfile extends GetWidget<WorkerProfileController> {
//   const HomeWorkerProfile({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // app bar
//             _appBar(),
//             //worker profile
//             SizedBox(
//               height: SizeConfig.heightMultiplier * 1.5,
//             ),
//             _workerInfo(),
//             SizedBox(
//               height: SizeConfig.heightMultiplier * 2,
//             ),
//             _workerActions(),
//             SizedBox(
//               height: SizeConfig.heightMultiplier * 1.5,
//             ),
//             _workerActionsSupplements(),
//             _tabs(
//                 tabTexts: controller.tabs,
//                 tabController: controller.tabController!),
//             Expanded(
//               child:
//                   TabBarView(controller: controller.tabController, children: [
//                 _workerDetailsInfo(),
//                 _workHistoryInfo(),
//               ]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _workHistoryInfo() {
//     return Container(
//         color: lightgreyBlueGreyColor,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 3,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: SizeConfig.widthMultiplier * 4),
//                 child: Container(
//                   height: SizeConfig.heightMultiplier * 6,
//                   width: SizeConfig.widthMultiplier * 40,
//                   decoration: BoxDecoration(
//                     color: greyColor,
//                     border: Border.all(color: lightBlueGreyColor),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: SizeConfig.widthMultiplier * 1.3),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         SvgPicture.asset(Images.filterIcon,
//                             height: SizeConfig.heightMultiplier * 2,
//                             color: blackColorText),
//                         Text("Filter", style: TextStyling.buttonTextStyle),
//                         SvgPicture.asset(Images.arrowDownIcon,
//                             height: SizeConfig.heightMultiplier * 1.2,
//                             color: blackColorText),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 2,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: SizeConfig.widthMultiplier * 4),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _workhistorydetailsbox(
//                         text1: "Day / Night Shifts",
//                         text2: "100 / 21",
//                         isDeductions: false),
//                     _workhistorydetailsbox(
//                         text1: "Total Project", text2: "4", isDeductions: false)
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 1.5,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: SizeConfig.widthMultiplier * 4),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _workhistorydetailsbox(
//                         text1: "Deductions",
//                         text2: "10 000 RWF",
//                         isDeductions: true),
//                     _workhistorydetailsbox(
//                         text1: "Total Earnings",
//                         text2: "5 000 000 Rwf",
//                         isDeductions: false)
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 2,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: SizeConfig.widthMultiplier * 2),
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       color: whiteColor,
//                       borderRadius: BorderRadius.circular(8)),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: SizeConfig.widthMultiplier * 4,
//                         vertical: SizeConfig.heightMultiplier * 2),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: SizeConfig.heightMultiplier * 2,
//                         ),
//                         Text("Total: 121",
//                             style: TextStyling.nameProfileTextStyle),
//                         SizedBox(
//                           height: SizeConfig.heightMultiplier * 2,
//                         ),
//                         Divider(
//                           thickness: 0.6,
//                           color: appBarColorText,
//                         ),
//                         SizedBox(
//                           height: SizeConfig.heightMultiplier * 0.5,
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             _infoAttendance(
//                                 text1: "14/04/2020", text2: "Mason"),
//                             _infoAttendance(text1: "Night", text2: "Rwf 6000"),
//                             _infoAttendance(text1: "INYANGE", text2: "Welcome")
//                           ],
//                         ),
//                         SizedBox(
//                           height: SizeConfig.heightMultiplier * 2,
//                         ),
//                         Divider(
//                           thickness: 0.6,
//                           color: appBarColorText,
//                         ),
//                         SizedBox(
//                           height: SizeConfig.heightMultiplier * 0.5,
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             _infoAttendance(
//                                 text1: "14/04/2020", text2: "Mason"),
//                             _infoAttendance(text1: "Night", text2: "Rwf 6 000"),
//                             _infoAttendance(text1: "INYANGE", text2: "Welcome")
//                           ],
//                         ),
//                         SizedBox(
//                           height: SizeConfig.heightMultiplier * 2,
//                         ),
//                         Divider(
//                           thickness: 0.6,
//                           color: appBarColorText,
//                         ),
//                         SizedBox(
//                           height: SizeConfig.heightMultiplier * 0.5,
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             _infoAttendance(text1: "1/04/2022", text2: "Mason"),
//                             _infoAttendance(text1: "Night", text2: "Rwf 8 000"),
//                             _infoAttendance(text1: "INYANGE", text2: "Welcome")
//                           ],
//                         ),
//                         SizedBox(
//                           height: SizeConfig.heightMultiplier * 2,
//                         ),
//                         Divider(
//                           thickness: 0.6,
//                           color: appBarColorText,
//                         ),
//                         SizedBox(
//                           height: SizeConfig.heightMultiplier * 0.5,
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             _infoAttendance(
//                                 text1: "14/04/2022", text2: "Steel Fixer"),
//                             _infoAttendance(text1: "Day", text2: "Rwf 10 000"),
//                             _infoAttendance(text1: "INYANGE", text2: "Welcome")
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }

//   _workhistorydetailsbox(
//       {required String text1,
//       required String text2,
//       required bool isDeductions}) {
//     return Container(
//       height: SizeConfig.heightMultiplier * 6,
//       width: SizeConfig.widthMultiplier * 45,
//       decoration: BoxDecoration(
//         color: blackGreyColorText,
//         border: Border.all(color: lightBlueGreyColor),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding:
//             EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 1.3),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text(text1.toUpperCase(), style: TextStyling.buttonMediumTextStyle),
//             Text(text2,
//                 style: isDeductions
//                     ? TextStyling.redTextStyle
//                     : TextStyling.blueTextStyle),
//           ],
//         ),
//       ),
//     );
//   }

//   _workerDetailsInfo() {
//     return Container(
//       color: lightgreyBlueGreyColor,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Padding(
//           padding:
//               EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 8),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 3,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Personal Details",
//                     style: TextStyling.bigTextStyle,
//                   ),
//                   SizedBox(
//                     width: SizeConfig.widthMultiplier * 4,
//                   ),
//                   SvgPicture.asset(
//                     Images.penIcon,
//                     height: SizeConfig.heightMultiplier * 2,
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 2,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _infoDetails(text1: "First Name", text2: "Agnes"),
//                   _infoDetails(text1: "Last Name", text2: "Mukamana"),
//                 ],
//               ),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 2,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _infoDetails(text1: "Gender", text2: "Female"),
//                   _infoDetails(text1: "Date of Birth", text2: "01/01/1990"),
//                 ],
//               ),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 2,
//               ),
//               _infoDetails(text1: "ID Number", text2: "119998008571578"),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 4,
//               ),
//               Text(
//                 "Contact Details",
//                 style: TextStyling.bigTextStyle,
//               ),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 3,
//               ),
//               _infoDetails(text1: "Address", text2: "Kicukiro, Kigali"),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 2,
//               ),
//               _infoDetails(text1: "Phone number", text2: "0785715789"),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 2,
//               ),
//               _infoDetails(text1: "Email", text2: "mukamana@gmail.com"),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 4,
//               ),
//               Divider(
//                 thickness: 0.8,
//                 color: appBarColorText,
//               ),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 4,
//               ),
//               Text(
//                 "Qualifications & Certificates",
//                 style: TextStyling.bigTextStyle,
//               ),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 3,
//               ),
//               _certificatesDetails(
//                   certifcateName: "Technical Course On Wastewater Treatment",
//                   certifcateDetails: "Certificate of Wastewater Treatment",
//                   certifcateStart: "2007",
//                   certifcateEnd: "2010"),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 1.5,
//               ),
//               _certificatesDetails(
//                   certifcateName: "Technical Course On Wastewater Treatment",
//                   certifcateDetails: "Certificate of Wastewater Treatment",
//                   certifcateStart: "2007",
//                   certifcateEnd: "2010"),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 3,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _certificatesDetails(
//       {required String certifcateName,
//       required String certifcateDetails,
//       required String certifcateStart,
//       required String certifcateEnd}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           certifcateName,
//           style: TextStyling.nameProfileGreyTextStyle,
//         ),
//         SizedBox(
//           height: SizeConfig.heightMultiplier * 1.2,
//         ),
//         Text(
//           certifcateDetails,
//           style: TextStyling.normalTextStyle,
//         ),
//         SizedBox(
//           height: SizeConfig.heightMultiplier * 1.2,
//         ),
//         Text(
//           "$certifcateStart - $certifcateEnd",
//           style: TextStyling.greyTextStyle,
//         ),
//       ],
//     );
//   }

//   _infoDetails({required String text1, required String text2}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           text1,
//           style: TextStyling.greyTextStyle,
//         ),
//         SizedBox(
//           height: SizeConfig.heightMultiplier * 1.2,
//         ),
//         Text(
//           text2,
//           style: TextStyling.nameProfileGreyTextStyle,
//         ),
//       ],
//     );
//   }

//   _infoAttendance({required String text1, required String text2}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           text1,
//           style: TextStyling.nameProfileGreyTextStyle,
//         ),
//         SizedBox(
//           height: SizeConfig.heightMultiplier * 1.2,
//         ),
//         Text(
//           text2,
//           style: TextStyling.greyTextStyle,
//         ),
//       ],
//     );
//   }

//   _tabs(
//       {required List<String> tabTexts, required TabController tabController}) {
//     return DecoratedBox(
//       decoration: BoxDecoration(
//           border: Border(bottom: BorderSide(color: lightBlueGreyColor))),
//       child: TabBar(
//           controller: tabController,
//           indicatorColor: blueColorText,
//           indicatorWeight: 2.5,
//           indicatorSize: TabBarIndicatorSize.label,
//           unselectedLabelStyle: TextStyling.tabUnSelectedTextStyle,
//           tabs: List<Widget>.generate(
//               tabTexts.length,
//               (index) => Tab(
//                     child: Text(tabTexts[index].toUpperCase(),
//                         style: TextStyling.tabSelectedTextStyle),
//                   ))),
//     );
//   }

//   _workerActionsSupplements() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 3),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           buttonSupplements(
//               iconName: Images.dollarIcon,
//               text: "Add Deductions",
//               status: false),
//           buttonSupplements(
//               iconName: Images.banIcon, text: "Deactivate", status: true)
//         ],
//       ),
//     );
//   }

//   _workerActions() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 3),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           button(iconName: Images.mailIcon, text: "Send\nMessage"),
//           button(
//               iconName: Images.workerHelmetIcon, text: "Assign To \nProject"),
//           button(iconName: Images.starrIcon, text: "Assess \n Worker"),
//         ],
//       ),
//     );
//   }

//   buttonSupplements(
//       {required String iconName, required String text, required bool status}) {
//     return Container(
//       height: SizeConfig.heightMultiplier * 4,
//       width: SizeConfig.widthMultiplier * 40,
//       decoration: BoxDecoration(
//         color: whiteColor,
//         border: Border.all(color: lightBlueGreyColor),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding:
//             EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 1.3),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             SvgPicture.asset(iconName,
//                 height: SizeConfig.heightMultiplier * 2,
//                 color: status ? redColor : blackColorText),
//             Text(text,
//                 style: status
//                     ? TextStyling.redTextStyle
//                     : TextStyling.buttonTextStyle)
//           ],
//         ),
//       ),
//     );
//   }

//   button({required String iconName, required String text}) {
//     return Container(
//       height: SizeConfig.heightMultiplier * 6,
//       width: SizeConfig.widthMultiplier * 30,
//       decoration: BoxDecoration(
//         color: whiteColor,
//         border: Border.all(color: lightBlueGreyColor),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding:
//             EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 1.3),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             SvgPicture.asset(iconName,
//                 height: SizeConfig.heightMultiplier * 2, color: blackColorText),
//             Text(text, style: TextStyling.buttonTextStyle)
//           ],
//         ),
//       ),
//     );
//   }

//   _appBar() {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: SizeConfig.widthMultiplier * 8,
//           vertical: SizeConfig.heightMultiplier * 3),
//       child: Text("profile".toUpperCase(), style: TextStyling.appBarTextStyle),
//     );
//   }

//   _workerInfo() {
//     return Padding(
//       padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           CircleAvatar(
//             maxRadius: SizeConfig.widthMultiplier * 12,
//             minRadius: SizeConfig.widthMultiplier * 12,
//             backgroundColor: redColor,
//             backgroundImage: AssetImage(Images.workerImg),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Mukamana Agnes",
//                     style: TextStyling.nameProfileTextStyle,
//                   ),
//                   SizedBox(
//                     width: SizeConfig.widthMultiplier * 2,
//                   ),
//                   Container(
//                     height: 20,
//                     width: 20,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: blueColorText,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: SvgPicture.asset(
//                         Images.selectIcon,
//                         height: 12,
//                         width: 12,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: SizeConfig.widthMultiplier * 2,
//                   ),
//                   Container(
//                     height: SizeConfig.heightMultiplier * 2.5,
//                     width: SizeConfig.widthMultiplier * 14,
//                     decoration: BoxDecoration(
//                       color: greyGreenColorText,
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: SizeConfig.widthMultiplier * 1.5),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             height: 10,
//                             width: 10,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: greenColorText,
//                             ),
//                           ),
//                           Text(
//                             "Active",
//                             style: TextStyling.smallTextStyle,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 1.5,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   serviceBox(text: "mason", active: false),
//                   SizedBox(width: SizeConfig.widthMultiplier * 4),
//                   serviceBox(text: "Steel fixer", active: true),
//                 ],
//               ),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 1.5,
//               ),
//               Container(
//                 height: SizeConfig.heightMultiplier * 3,
//                 width: SizeConfig.widthMultiplier * 55,
//                 decoration: BoxDecoration(
//                     color: lightGreyColor,
//                     borderRadius: BorderRadius.circular(8)),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12.0),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Container(
//                       //   color: whiteColor,
//                       //   width: 2,
//                       //   height: SizeConfig.heightMultiplier * 3,
//                       // ),
//                       // Container(
//                       //   color: whiteColor,
//                       //   width: 2,
//                       //   height: SizeConfig.heightMultiplier * 3,
//                       // ),
//                       // Container(
//                       //   color: whiteColor,
//                       //   width: 2,
//                       //   height: SizeConfig.heightMultiplier * 3,
//                       // ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 2,
//               ),
//               Text("Date Onboarded: 14/04/2020",
//                   style: TextStyling.normalTextStyle),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 1.2,
//               ),
//               Text("Last Attendance: 14/04/2020",
//                   style: TextStyling.normalTextStyle),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 1.2,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text("Phone: 0780000000", style: TextStyling.normalTextStyle),
//                   SizedBox(
//                     width: SizeConfig.widthMultiplier * 2,
//                   ),
//                   Container(
//                     height: 20,
//                     width: 20,
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: whiteColor,
//                         border: Border.all(
//                           color: blueColorText,
//                         )),
//                     child: Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: SvgPicture.asset(
//                         Images.selectIcon,
//                         color: blueColorText,
//                         height: 12,
//                         width: 12,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 1.2,
//               ),
//               Text("ID Number: 11990434354332020",
//                   style: TextStyling.normalTextStyle),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   serviceBox({required String text, required bool active}) {
//     return Container(
//       height: SizeConfig.heightMultiplier * 4,
//       width: SizeConfig.widthMultiplier * 20,
//       decoration: BoxDecoration(
//           color: lightGreyColor, borderRadius: BorderRadius.circular(8)),
//       child: Center(
//         child: Text(
//           text,
//           style: TextStyling.serviceTextStyle,
//         ),
//       ),
//     );
//   }
// }
