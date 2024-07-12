// // ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, unnecessary_string_interpolations

// import 'package:fixa/fixa_main_routes.dart';
// import 'package:intl/intl.dart';

// class HomePayroll extends GetWidget<HomePayrollController> {
//   final Project project;
//   final bool statusNavigator;
//   HomePayroll({Key? key, required this.project, required this.statusNavigator})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: whiteColor,
//       body: GetBuilder<HomePayrollController>(
//           init: HomePayrollController(),
//           initState: (_) =>
//               controller.getData(project: project, timeNow: DateTime.now()),
//           builder: (cons) {
//             return Stack(
//               children: [
//                 _displayEmptyAttendance(),
//                 Container(
//                   height: SizeConfig.heightMultiplier * 46,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       color: blueDark,
//                       borderRadius: BorderRadius.only(
//                         bottomRight: Radius.circular(24),
//                         bottomLeft: Radius.circular(24),
//                       )),
//                 ),
//                 SafeArea(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: SizeConfig.widthMultiplier * 4),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: SizeConfig.heightMultiplier * 4,
//                         ),
//                         appBarAttendance(text: "Payroll list"),
//                         SizedBox(
//                           height: SizeConfig.heightMultiplier * 2,
//                         ),
//                         SizedBox(
//                           height: SizeConfig.heightMultiplier * 2,
//                         ),
//                         GestureDetector(
//                             onTap: () =>
//                                 _showBottomSheetPayrollPeriod(context: context),
//                             child: _appShiftDate()),
//                         SizedBox(
//                           height: SizeConfig.heightMultiplier * 1.2,
//                         ),
//                         _attendanceInfo(),
//                         SizedBox(
//                           height: SizeConfig.heightMultiplier * 2,
//                         ),
//                         Obx(() => controller.allServices.isEmpty
//                             ? Container()
//                             : _tabs()),
//                         // _tabs(),
//                         SizedBox(
//                           height: SizeConfig.heightMultiplier * 1.8,
//                         ),
//                         _workersList(contextt: context),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }),
//     );
//   }

//   _displayEmptyAttendance() {
//     return Obx(
//       () => controller.payrollWorkers.isEmpty
//           ? Positioned(
//               left: SizeConfig.widthMultiplier * 4,
//               right: SizeConfig.widthMultiplier * 4,
//               bottom: SizeConfig.heightMultiplier * 12,
//               child: Container(
//                 width: double.infinity,
//                 height: SizeConfig.heightMultiplier * 32,
//                 decoration:
//                     BoxDecoration(color: textFormColor, shape: BoxShape.circle),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SvgPicture.asset(
//                       Images.workerHelmetIcon,
//                       height: SizeConfig.heightMultiplier * 12,
//                       color: blueDark,
//                     ),
//                     SizedBox(height: SizeConfig.heightMultiplier * 2),
//                     Text(
//                       "No workers found",
//                       textAlign: TextAlign.center,
//                       style: TextStyling.formBgGreyTextStyle,
//                     )
//                   ],
//                 ),
//               ))
//           : Container(),
//     );
//   }

//   _showBottomSheetWorkerInfo({
//     required BuildContext context,
//     required PayrollWorkers payrollWorker,
//   }) {
//     return showModalBottomSheet(
//         isScrollControlled: true,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
//         context: context,
//         builder: (context) {
//           return Obx(() => Container(
//                 padding:
//                     EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SizedBox(
//                       height: SizeConfig.heightMultiplier * 0.8,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: SizeConfig.widthMultiplier * 27),
//                       child: Container(
//                         height: 2,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             color: textFormBorderColor,
//                             borderRadius: BorderRadius.circular(8)),
//                       ),
//                     ),
//                     SizedBox(
//                       height: SizeConfig.heightMultiplier * 1.5,
//                     ),
//                     Center(
//                       child: Text(
//                           "${payrollWorker.firstName} ${payrollWorker.lastName} Payroll Summary",
//                           style: TextStyling.formGreyTextStyle),
//                     ),
//                     SizedBox(
//                       height: SizeConfig.heightMultiplier * 3,
//                     ),
//                     // Container(
//                     //   // decoration: BoxDecoration(
//                     //   //   border: Border(
//                     //   //       right: BorderSide(color: textFormBorderColor)
//                     //   //       ),
//                     //   // ),
//                     //   child:
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: SizeConfig.widthMultiplier * 3),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               color: textFormColor,
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: SizeConfig.widthMultiplier * 2,
//                                   vertical: 2),
//                               child: Text(
//                                 "${payrollWorker.serviceName}",
//                                 style: TextStyling.formBlueTextStyle,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: SizeConfig.heightMultiplier * 1.3,
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "${payrollWorker.dayShifts} days",
//                                 style: TextStyling.normalBoldTextStyle,
//                               ),
//                               SizedBox(width: SizeConfig.widthMultiplier * 4),
//                               Text(
//                                 "${currencyFormat(price: double.parse((payrollWorker.dayShifts! * payrollWorker.dailyRate!).toString()))} Rwf",
//                                 style: TextStyling.normalBoldTextStyle,
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: SizeConfig.heightMultiplier * 0.6,
//                           ),
//                           Text(
//                               "${currencyFormat(price: double.parse(payrollWorker.dailyRate.toString()))} Rwf",
//                               style: TextStyling.formGreyTextStyle),
//                           SizedBox(
//                             height: SizeConfig.heightMultiplier * 0.2,
//                           ),
//                           Divider(
//                             thickness: 1.2,
//                             color: textFormBorderColor,
//                           ),
//                           SizedBox(
//                             height: SizeConfig.heightMultiplier * 0.2,
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "${payrollWorker.nightShifts} nights",
//                                 style: TextStyling.normalBoldTextStyle,
//                               ),
//                               SizedBox(width: SizeConfig.widthMultiplier * 4),
//                               Text(
//                                 "${currencyFormat(price: double.parse((payrollWorker.nightShifts! * payrollWorker.dailyRate!).toString()))} Rwf",
//                                 style: TextStyling.normalBoldTextStyle,
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: SizeConfig.heightMultiplier * 0.6,
//                           ),
//                           Text(
//                               "${currencyFormat(price: double.parse(payrollWorker.dailyRate.toString()))} Rwf",
//                               style: TextStyling.formGreyTextStyle),
//                         ],
//                       ),
//                     ),
//                     // ),
//                     // payrollTable.extra!.isEmpty
//                     //     ? Container()
//                     //     : SizedBox(
//                     //         height: SizeConfig.heightMultiplier * 12,
//                     //         child: ListView.builder(
//                     //             shrinkWrap: true,
//                     //             scrollDirection: Axis.horizontal,
//                     //             itemCount: payrollTable.extra!.length,
//                     //             itemBuilder: (context, item) {
//                     //               return Container(
//                     //                 // height: SizeConfig.widthMultiplier * 12,
//                     //                 decoration: BoxDecoration(
//                     //                   border: Border(
//                     //                       right: BorderSide(
//                     //                           color: textFormBorderColor)),
//                     //                 ),
//                     //                 child: Padding(
//                     //                   padding: EdgeInsets.symmetric(
//                     //                       horizontal:
//                     //                           SizeConfig.widthMultiplier * 3),
//                     //                   child: Column(
//                     //                     crossAxisAlignment:
//                     //                         CrossAxisAlignment.start,
//                     //                     children: [
//                     //                       Container(
//                     //                         decoration: BoxDecoration(
//                     //                           color: textFormColor,
//                     //                           borderRadius:
//                     //                               BorderRadius.circular(6),
//                     //                         ),
//                     //                         child: Padding(
//                     //                           padding: EdgeInsets.symmetric(
//                     //                               horizontal:
//                     //                                   SizeConfig.widthMultiplier *
//                     //                                       2,
//                     //                               vertical: 2),
//                     //                           child: Text(
//                     //                             "${payrollTable.extra![item].serviceName}",
//                     //                             style:
//                     //                                 TextStyling.formBlueTextStyle,
//                     //                           ),
//                     //                         ),
//                     //                       ),
//                     //                       SizedBox(
//                     //                         height:
//                     //                             SizeConfig.heightMultiplier * 1.3,
//                     //                       ),
//                     //                       Row(
//                     //                         crossAxisAlignment:
//                     //                             CrossAxisAlignment.center,
//                     //                         children: [
//                     //                           Text(
//                     //                             "${payrollTable.extra![item].daysWorked} days",
//                     //                             style:
//                     //                                 TextStyling.normalBoldTextStyle,
//                     //                           ),
//                     //                           SizedBox(
//                     //                               width:
//                     //                                   SizeConfig.widthMultiplier *
//                     //                                       4),
//                     //                           Text(
//                     //                             "${currencyFormat(price: double.parse(payrollTable.totalEarnings.toString()))} Rwf",
//                     //                             style:
//                     //                                 TextStyling.normalBoldTextStyle,
//                     //                           ),
//                     //                         ],
//                     //                       ),
//                     //                       SizedBox(
//                     //                         height:
//                     //                             SizeConfig.heightMultiplier * 0.6,
//                     //                       ),
//                     //                       Text(
//                     //                           "${currencyFormat(price: double.parse(payrollTable.extra![item].dailyRate.toString()))} Rwf",
//                     //                           style: TextStyling.formGreyTextStyle),
//                     //                       SizedBox(
//                     //                         height:
//                     //                             SizeConfig.heightMultiplier * 0.2,
//                     //                       ),
//                     //                       Divider(
//                     //                         thickness: 1.2,
//                     //                         color: textFormBorderColor,
//                     //                       ),
//                     //                       // SizedBox(
//                     //                       //   height: SizeConfig.heightMultiplier * 1.2,
//                     //                       // ),
//                     //                     ],
//                     //                   ),
//                     //                 ),
//                     //               );
//                     //             }),
//                     //       ),

//                     SizedBox(
//                       height: SizeConfig.heightMultiplier * 0.6,
//                     ),
//                     Divider(
//                       thickness: 1.2,
//                       color: textFormBorderColor,
//                     ),
//                     SizedBox(
//                       height: SizeConfig.heightMultiplier * 1.5,
//                     ),
//                     controller.isLoadingDeduction.value
//                         ? Text(
//                             "Deduction --- rwf",
//                             style: TextStyling.formOrangeTextStyle,
//                           )
//                         : Text(
//                             "Deduction ${currencyFormat(price: double.parse(controller.totalDeductions.toString()))} rwf",
//                             style: TextStyling.formOrangeTextStyle,
//                           ),
//                     SizedBox(
//                       height: SizeConfig.heightMultiplier * 0.6,
//                     ),
//                     Divider(
//                       thickness: 1.2,
//                       color: textFormBorderColor,
//                     ),
//                     SizedBox(
//                       height: SizeConfig.heightMultiplier * 1.5,
//                     ),
//                     Text(
//                       "Total Take Home ${currencyFormat(price: double.parse(payrollWorker.totalAmount.toString()))} rwf",
//                       style: TextStyling.normalBoldTextStyle,
//                     ),
//                     SizedBox(
//                       height: SizeConfig.heightMultiplier * 0.6,
//                     ),
//                     Divider(
//                       thickness: 1.2,
//                       color: textFormBorderColor,
//                     ),
//                     SizedBox(
//                       height: SizeConfig.heightMultiplier * 1.5,
//                     ),
//                     GestureDetector(
//                       behavior: HitTestBehavior.opaque,
//                       onTap: () =>
//                           Get.toNamed(RouteLinks.homeWorkerPayroll, arguments: {
//                         "worker_name":
//                             "${payrollWorker.firstName} ${payrollWorker.lastName}",
//                         "project_id": project.projectId,
//                         "worker_id": payrollWorker.workerId
//                       }),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("More Details",
//                               style: TextStyling.formGreyTextStyle),
//                           SvgPicture.asset(
//                             Images.arrorwRight,
//                             color: blackColor,
//                             height: SizeConfig.heightMultiplier * 1.3,
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: SizeConfig.heightMultiplier * 1.5,
//                     ),
//                   ],
//                 ),
//               ));
//         });
//   }

//   _showBottomSheetPayrollPeriod({required BuildContext context}) {
//     return showModalBottomSheet(
//         isScrollControlled: true,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
//         context: context,
//         builder: (context) {
//           return Obx(
//             () => Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     height: SizeConfig.heightMultiplier * 0.8,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: SizeConfig.widthMultiplier * 27),
//                     child: Container(
//                       height: 2,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           color: textFormBorderColor,
//                           borderRadius: BorderRadius.circular(8)),
//                     ),
//                   ),
//                   SizedBox(
//                     height: SizeConfig.heightMultiplier * 3,
//                   ),
//                   Center(
//                     child: Text("Select Date",
//                         style: TextStyling.formGreyTextStyle),
//                   ),
//                   SizedBox(
//                     height: SizeConfig.heightMultiplier * 3,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           if (controller.selectedCurrentPayrollIndex.value >
//                               0) {
//                             controller.getNextPayroll(
//                                 currentPayrollIndex: controller
//                                         .selectedCurrentPayrollIndex.value -
//                                     1);
//                           }
//                         },
//                         child: Container(
//                           child: Row(
//                             children: [
//                               SvgPicture.asset(
//                                 Images.backIcon,
//                                 color: textFormBorderColor,
//                                 height: SizeConfig.heightMultiplier * 2,
//                               ),
//                               SizedBox(
//                                 width: SizeConfig.widthMultiplier * 0.1,
//                               ),
//                               SvgPicture.asset(
//                                 Images.backIcon,
//                                 color: textFormBorderColor,
//                                 height: SizeConfig.heightMultiplier * 2,
//                               ),
//                               SizedBox(
//                                 width: SizeConfig.widthMultiplier * 3,
//                               ),
//                               SvgPicture.asset(
//                                 Images.backIcon,
//                                 color: textFormBorderColor,
//                                 height: SizeConfig.heightMultiplier * 2,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Text(
//                         "${DateFormat.LLLL().format(DateTime.parse(controller.payrollFrames[controller.selectedCurrentPayrollIndex.value].date!))} - ${DateTime.parse(controller.payrollFrames[controller.selectedCurrentPayrollIndex.value].date!).year}",
//                         style: TextStyling.normalBoldTextStyle,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           if (controller.selectedCurrentPayrollIndex.value <
//                               11) {
//                             controller.getNextPayroll(
//                                 currentPayrollIndex: controller
//                                         .selectedCurrentPayrollIndex.value +
//                                     1);
//                           }
//                         },
//                         child: Container(
//                           child: Row(
//                             children: [
//                               SvgPicture.asset(
//                                 Images.arrorwRight,
//                                 color: textFormBorderColor,
//                                 height: SizeConfig.heightMultiplier * 2,
//                               ),
//                               SizedBox(
//                                 width: SizeConfig.widthMultiplier * 3,
//                               ),
//                               SvgPicture.asset(
//                                 Images.arrorwRight,
//                                 color: textFormBorderColor,
//                                 height: SizeConfig.heightMultiplier * 2,
//                               ),
//                               SizedBox(
//                                 width: SizeConfig.widthMultiplier * 0.1,
//                               ),
//                               SvgPicture.asset(
//                                 Images.arrorwRight,
//                                 color: textFormBorderColor,
//                                 height: SizeConfig.heightMultiplier * 2,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: SizeConfig.heightMultiplier * 1.3,
//                   ),
//                   Divider(
//                     thickness: 0.5,
//                     color: textFormBorderColor,
//                   ),
//                   SizedBox(
//                     height: SizeConfig.heightMultiplier * 1.3,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       controller.setPayrollTimeFrame(
//                           timeFrame: controller
//                               .payrollFrames[
//                                   controller.selectedCurrentPayrollIndex.value]
//                               .payrollFrames![0],
//                           projectId: project.projectId!);
//                       Navigator.pop(context);
//                     },
//                     child: Center(
//                       child: Text(
//                         '${getDate(date: controller.payrollFrames[controller.selectedCurrentPayrollIndex.value].payrollFrames![0].dateStart)} - ${getDate(date: controller.payrollFrames[controller.selectedCurrentPayrollIndex.value].payrollFrames![0].dateEnd)}',
//                         // '${controller.dataPayrolls[controller.selectedCurrentPayrollIndex.value]["payrolls"][0]["start-date"].toString().replaceAll('-', ' | ')} - ${controller.dataPayrolls[controller.selectedCurrentPayrollIndex.value]["payrolls"][0]["end-date"].toString().replaceAll('-', ' | ')}',
//                         style: TextStyling.formBlueTextStyle,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: SizeConfig.heightMultiplier * 1.3,
//                   ),
//                   Divider(
//                     thickness: 0.5,
//                     color: textFormBorderColor,
//                   ),
//                   SizedBox(
//                     height: SizeConfig.heightMultiplier * 1.3,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       controller.setPayrollTimeFrame(
//                           timeFrame: controller
//                               .payrollFrames[
//                                   controller.selectedCurrentPayrollIndex.value]
//                               .payrollFrames![1],
//                           projectId: project.projectId!);
//                       Navigator.pop(context);
//                     },
//                     child: Center(
//                       child: Text(
//                         '${getDate(date: controller.payrollFrames[controller.selectedCurrentPayrollIndex.value].payrollFrames![1].dateStart)} - ${getDate(date: controller.payrollFrames[controller.selectedCurrentPayrollIndex.value].payrollFrames![1].dateEnd)}',

//                         // '${controller.dataPayrolls[controller.selectedCurrentPayrollIndex.value]["payrolls"][1]["start-date"].toString().replaceAll('-', ' | ')} - ${controller.dataPayrolls[controller.selectedCurrentPayrollIndex.value]["payrolls"][1]["end-date"].toString().replaceAll('-', ' | ')}',
//                         style: TextStyling.formBlueTextStyle,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: SizeConfig.heightMultiplier * 1.3,
//                   ),
//                   Divider(
//                     thickness: 0.5,
//                     color: textFormBorderColor,
//                   ),
//                   SizedBox(
//                     height: SizeConfig.heightMultiplier * 1.3,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       controller.getData(
//                           project: project, timeNow: DateTime.now());
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       height: SizeConfig.heightMultiplier * 6,
//                       decoration: BoxDecoration(
//                         color: textFormColor,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Center(
//                           child: Text(
//                         "Jump to current payroll",
//                         style: TextStyling.buttonTextStyle,
//                       )),
//                     ),
//                   ),
//                   SizedBox(
//                     height: SizeConfig.heightMultiplier * 1.3,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   _workersList({required BuildContext contextt}) {
//     return Obx(
//       () => controller.isLoading.value
//           ? Expanded(
//               child: Container(
//                 // height: SizeConfig.heightMultiplier * 40,
//                 decoration: BoxDecoration(
//                   color: whiteColor,
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(24),
//                     topLeft: Radius.circular(24),
//                   ),
//                 ),
//                 child: lottieLoading(sizeConfigHeight: 16),
//               ),
//             )
//           : controller.payrollWorkers.isEmpty
//               ? Container()
//               : Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: whiteColor,
//                       borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(24),
//                         topLeft: Radius.circular(24),
//                       ),
//                     ),
//                     child: ListView.builder(
//                         shrinkWrap: true,
//                         physics: ScrollPhysics(),
//                         scrollDirection: Axis.vertical,
//                         itemCount: controller.payrollWorkers.length,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: SizeConfig.widthMultiplier * 5.5,
//                                 vertical: SizeConfig.heightMultiplier * 1.2),
//                             child: GestureDetector(
//                               behavior: HitTestBehavior.opaque,
//                               onTap: () {
//                                 controller.getDeductionWorkerRange(
//                                     timeFrame: controller.dataPayroll.value,
//                                     workerId: controller
//                                         .payrollWorkers[index].workerId!);
//                                 _showBottomSheetWorkerInfo(
//                                     context: contextt,
//                                     payrollWorker:
//                                         controller.payrollWorkers[index]);
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.only(
//                                     bottom: SizeConfig.heightMultiplier * 0.5),
//                                 decoration: BoxDecoration(
//                                   color: whiteColor,
//                                   border: Border(
//                                       bottom: BorderSide(
//                                           color: textFormBorderColor)),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding:
//                                           const EdgeInsets.only(right: 8.0),
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Container(
//                                             height:
//                                                 SizeConfig.heightMultiplier * 7,
//                                             width:
//                                                 SizeConfig.widthMultiplier * 16,
//                                             decoration: BoxDecoration(
//                                                 color: textFormColor,
//                                                 shape: BoxShape.circle),
//                                             child: Center(
//                                               child: Text(
//                                                 splitName(
//                                                     "${controller.payrollWorkers[index].firstName} ${controller.payrollWorkers[index].lastName}"),
//                                                 style: TextStyling
//                                                     .formBlueTextStyle,
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width:
//                                                 SizeConfig.widthMultiplier * 3,
//                                           ),
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               SizedBox(
//                                                 height: SizeConfig
//                                                         .heightMultiplier *
//                                                     3,
//                                                 width:
//                                                     SizeConfig.widthMultiplier *
//                                                         55,
//                                                 child: ListView(
//                                                   shrinkWrap: true,
//                                                   scrollDirection:
//                                                       Axis.horizontal,
//                                                   children: [
//                                                     Text(
//                                                       "${controller.payrollWorkers[index].firstName} ${controller.payrollWorkers[index].lastName}",
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: TextStyling
//                                                           .normalBoldTextStyle,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               // Text.rich(
//                                               //   TextSpan(
//                                               //     // ignore: prefer_const_literals_to_create_immutables
//                                               //     children: [
//                                               //       TextSpan(
//                                               //         text:
//                                               //             "${controller.payrollWorkers[index].firstName} ${controller.payrollWorkers[index].lastName}",
//                                               //         style: TextStyling
//                                               //             .normalBoldTextStyle,
//                                               //       ),
//                                               //       // TextSpan(
//                                               //       //   text:
//                                               //       //       "${controller.data[index]["last_name"]}",
//                                               //       //   style:
//                                               //       //       TextStyling.normalBoldTextStyle,
//                                               //       // ),
//                                               //     ],
//                                               //   ),
//                                               // ),
//                                               SizedBox(
//                                                 height: SizeConfig
//                                                         .heightMultiplier *
//                                                     0.6,
//                                               ),
//                                               SizedBox(
//                                                 height: SizeConfig
//                                                         .heightMultiplier *
//                                                     3,
//                                                 width:
//                                                     SizeConfig.widthMultiplier *
//                                                         55,
//                                                 // width: double.infinity,
//                                                 child: ListView(
//                                                   shrinkWrap: true,
//                                                   scrollDirection:
//                                                       Axis.horizontal,
//                                                   children: [
//                                                     Text(
//                                                         "${controller.payrollWorkers[index].serviceName} ,",
//                                                         style: TextStyling
//                                                             .formGreyTextStyle),
//                                                     //                             Row(
//                                                     // crossAxisAlignment:
//                                                     //     CrossAxisAlignment
//                                                     //         .center,
//                                                     // children: [
//                                                     //
//                                                     // ...controller
//                                                     //         .workerTablePayroll[
//                                                     //             index]
//                                                     //         .extra!
//                                                     //         .isEmpty
//                                                     //     ? []
//                                                     //     : controller
//                                                     //         .workerTablePayroll[
//                                                     //             index]
//                                                     //         .extra!
//                                                     //         .map((extr) => Text(
//                                                     //             "${extr.serviceName} ,",
//                                                     //             style: TextStyling
//                                                     //                 .formGreyTextStyle)),
//                                                     SizedBox(
//                                                       width: SizeConfig
//                                                               .widthMultiplier *
//                                                           1.5,
//                                                     ),
//                                                     Text(
//                                                         "${controller.payrollWorkers[index].dayShifts} Days, ${controller.payrollWorkers[index].nightShifts} Nights, ",
//                                                         style: TextStyling
//                                                             .buttonMediumTextStyle),
//                                                     // ...controller
//                                                     //         .workerTablePayroll[
//                                                     //             index]
//                                                     //         .workedDays!
//                                                     //         .isEmpty
//                                                     //     ? []
//                                                     //     : controller
//                                                     //         .workerTablePayroll[
//                                                     //             index]
//                                                     //         .workedDays!
//                                                     //         .map((dayWorked) => Text(
//                                                     //             "${dayWorked.count} ${dayWorked.shift}, ",
//                                                     //             style: TextStyling
//                                                     //                 .buttonMediumTextStyle)),
//                                                     SizedBox(
//                                                       width: SizeConfig
//                                                               .widthMultiplier *
//                                                           1.5,
//                                                     ),
//                                                     Text(
//                                                         "${currencyFormat(price: double.parse(controller.payrollWorkers[index].totalAmount.toString()))} Rwf",
//                                                         style: TextStyling
//                                                             .buttonMediumTextStyle),
//                                                     SizedBox(
//                                                       width: SizeConfig
//                                                               .widthMultiplier *
//                                                           1.5,
//                                                     ),
//                                                     //   ],
//                                                     // ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Spacer(),
//                                           SvgPicture.asset(
//                                             Images.moreIcon,
//                                             height:
//                                                 SizeConfig.heightMultiplier *
//                                                     1.6,
//                                             color: lightBlueGreyColor,
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                   ),
//                 ),
//     );
//   }

//   _tabs() {
//     return SizedBox(
//       height: SizeConfig.heightMultiplier * 6,
//       child: ListView.builder(
//           shrinkWrap: true,
//           scrollDirection: Axis.horizontal,
//           itemCount: controller.allServices.length,
//           itemBuilder: (context, index) {
//             return Obx(
//               () => GestureDetector(
//                 onTap: () => controller.changeService(
//                     service: controller.allServices[index],
//                     id: controller.allServices[index].id!,
//                     serviceName: controller.allServices[index].name!),
//                 child: Container(
//                   margin: EdgeInsets.symmetric(
//                       horizontal: SizeConfig.widthMultiplier * 2),
//                   padding: EdgeInsets.symmetric(
//                       horizontal: SizeConfig.widthMultiplier * 4,
//                       vertical: SizeConfig.heightMultiplier * 0.5),
//                   decoration: BoxDecoration(
//                       color: controller.allServices[index].id! ==
//                               controller.selectedService.value
//                           ? whiteColor
//                           : blueDark,
//                       border: Border.all(color: bluelight),
//                       borderRadius: BorderRadius.circular(8)),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("${controller.allServices[index].name!}",
//                           style: controller.allServices[index].id! ==
//                                   controller.selectedService.value
//                               ? TextStyling.blueTextStyle
//                               : TextStyling.buttonMediumWhiteTextStyle),
//                       SizedBox(
//                         width: SizeConfig.widthMultiplier * 2,
//                       ),
//                       controller.allPayrollWorkers.isEmpty
//                           ? Container()
//                           : getPayrollHistoryPerService(
//                                       payrollWorkers:
//                                           controller.allPayrollWorkers,
//                                       service: controller.allServices[index]) ==
//                                   "0"
//                               ? Container()
//                               : Container(
//                                   decoration: BoxDecoration(
//                                     color: controller.allServices[index].id! ==
//                                             controller.selectedService.value
//                                         ? blueDark
//                                         : bluelight,
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal:
//                                             SizeConfig.widthMultiplier * 2,
//                                         vertical: 2),
//                                     child: Text(
//                                       getPayrollHistoryPerService(
//                                           payrollWorkers:
//                                               controller.allPayrollWorkers,
//                                           service:
//                                               controller.allServices[index]),
//                                       style: TextStyling
//                                           .buttonMediumWhiteTextStyle,
//                                     ),
//                                   ),
//                                 ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//     );
//   }

//   _attendanceInfo() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         // approval
//         // Padding(
//         //   padding: const EdgeInsets.all(8.0),
//         //   child: Text(
//         //     "Current Payroll",
//         //     style: TextStyling.buttonMediumWhiteBoldTextStyle,
//         //   ),
//         // ),
//         Obx(() => Text.rich(
//               TextSpan(
//                 // ignore: prefer_const_literals_to_create_immutables
//                 children: [
//                   TextSpan(
//                     text: "Total workers: ",
//                     style: TextStyling.buttonMediumWhiteTextStyle,
//                   ),
//                   TextSpan(
//                     text: controller.allPayrollWorkers.isEmpty
//                         ? "-"
//                         : "${controller.allPayrollWorkers.length}",
//                     style: TextStyling.buttonMediumWhiteBoldTextStyle,
//                   ),
//                 ],
//               ),
//             )),
//         Obx(() => Text.rich(
//               TextSpan(
//                 // ignore: prefer_const_literals_to_create_immutables
//                 children: [
//                   TextSpan(
//                     text: "Total Earnings: ",
//                     style: TextStyling.buttonMediumWhiteTextStyle,
//                   ),
//                   TextSpan(
//                     text: controller.allPayrollWorkers.isEmpty
//                         ? "-"
//                         : getTotalEarnings(
//                             allPayrollWorkers: controller.allPayrollWorkers),
//                     style: TextStyling.buttonMediumWhiteBoldTextStyle,
//                   ),
//                 ],
//               ),
//             )),
//       ],
//     );
//   }

//   _appShiftDate() {
//     return Obx(
//       () => Container(
//         height: SizeConfig.heightMultiplier * 8,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: whiteColor,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding:
//               EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Payroll period", style: TextStyling.formGreyTextStyle),
//                   SizedBox(height: SizeConfig.heightMultiplier * 0.6),
//                   Text(
//                     '${getDate(date: controller.dataPayroll.value.dateStart)} - ${getDate(date: controller.dataPayroll.value.dateEnd)}',

//                     // : '${controller.dataPayroll["start-date"].toString().replaceAll('-', ' | ')} - ${controller.dataPayroll["end-date"].toString().replaceAll('-', ' | ')}',
//                     style: TextStyling.formBlueTextStyle,
//                   )
//                 ],
//               ),
//               SvgPicture.asset(
//                 Images.arrowDownIcon,
//                 color: blueDark,
//                 height: SizeConfig.heightMultiplier * 1.5,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   appBarAttendance({required String text}) {
//     return Obx(
//       () => controller.isSearching.value
//           ? Container(
//               height: SizeConfig.heightMultiplier * 6,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: whiteColor,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () => controller.setIsSearching(
//                           status: controller.isSearching.value),
//                       child: SvgPicture.asset(
//                         Images.timesIcon,
//                         color: appBarColorText,
//                         width: SizeConfig.widthMultiplier * 4,
//                       ),
//                     ),
//                     SizedBox(width: SizeConfig.widthMultiplier * 3),
//                     Expanded(
//                       child: TextFormField(
//                         // controller: textController,
//                         keyboardType: TextInputType.text,
//                         autocorrect: false,
//                         onChanged: (value) {
//                           if (value.isEmpty) {
//                             controller.searchWorkers(
//                                 data: value.toLowerCase(), isEmpty: true);
//                           } else {
//                             controller.searchWorkers(
//                                 data: value.toLowerCase(), isEmpty: false);
//                           }
//                         },
//                         decoration: InputDecoration(
//                           hintText: "Search by name,phone or ID",
//                           border: InputBorder.none,
//                           hintStyle: TextStyling.formTextStyle,
//                           disabledBorder: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           : Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     if (!statusNavigator) {
//                       Get.back();
//                       controller.allPayrollWorkers.value = [];
//                       controller.payrollWorkers.value = [];
//                     }
//                   },
//                   child: SvgPicture.asset(
//                     Images.leftArrowIcon,
//                     color: statusNavigator ? blueDark : whiteColor,
//                     width: SizeConfig.widthMultiplier * 4,
//                   ),
//                 ),
//                 Text(text, style: TextStyling.nameWhiteProfileTextStyle),
//                 GestureDetector(
//                   onTap: () => controller.setIsSearching(
//                       status: controller.isSearching.value),
//                   child: SvgPicture.asset(
//                     Images.searchIcon,
//                     color: whiteColor,
//                     width: SizeConfig.widthMultiplier * 4,
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }

// }
