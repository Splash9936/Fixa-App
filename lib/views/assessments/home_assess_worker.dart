// // ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

// import 'package:fixa/fixa_main_routes.dart';

// class HomeAssessWorker extends GetWidget<HomeAssessWorkerController> {
//   final String workerFullName;
//   final Project project;
//   final int assessmentLevel;
//   final int workerId;
//   final int assignWorkerId;
//   HomeAssessWorker(
//       {Key? key,
//       required this.workerFullName,
//       required this.project,
//       required this.assessmentLevel,
//       required this.assignWorkerId,
//       required this.workerId})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: whiteColor,
//       body: GetBuilder(
//           init: HomeAssessWorkerController(),
//           initState: (_) =>
//               controller.getAssessments(assessmentLevel: assessmentLevel),
//           builder: (cons) {
//             return SafeArea(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: SizeConfig.heightMultiplier * 3,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: SizeConfig.widthMultiplier * 8),
//                     child: appBar(text: "Assessment Level $assessmentLevel"),
//                   ),
//                   SizedBox(
//                     height: SizeConfig.heightMultiplier * 3,
//                   ),
//                   Center(
//                     child: Text("Rate $workerFullName",
//                         textAlign: TextAlign.center,
//                         style: TextStyling.normalTextStyle),
//                   ),
//                   SizedBox(
//                     height: SizeConfig.heightMultiplier * 1.5,
//                   ),
//                   Obx(
//                     () => controller.isLoading.value
//                         ? Center(
//                             child: CircularProgressIndicator(
//                               color: blueDark,
//                             ),
//                           )
//                         : Expanded(
//                             child: ListView.builder(
//                                 itemCount:
//                                     controller.assessments[0].metrics!.length,
//                                 itemBuilder: (context, index) {
//                                   return Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal:
//                                             SizeConfig.widthMultiplier * 6),
//                                     child: Card(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(8.0),
//                                       ),
//                                       elevation: 2,
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           color: whiteColor,
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                         child: Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal:
//                                                   SizeConfig.widthMultiplier *
//                                                       6,
//                                               vertical:
//                                                   SizeConfig.heightMultiplier *
//                                                       1.5),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 "${controller.assessments[0].metrics![index].assessmentMetrics![0].metricName}",
//                                                 style: TextStyling
//                                                     .nameProfileTextStyle,
//                                               ),
//                                               SizedBox(
//                                                 height: SizeConfig
//                                                         .heightMultiplier *
//                                                     1.3,
//                                               ),
//                                               Divider(
//                                                 thickness: 1.5,
//                                                 color: textFormBorderColor,
//                                               ),
//                                               SizedBox(
//                                                 height: SizeConfig
//                                                         .heightMultiplier *
//                                                     1.3,
//                                               ),
//                                               ListView.builder(
//                                                 shrinkWrap: true,
//                                                 physics:
//                                                     NeverScrollableScrollPhysics(),
//                                                 itemCount: controller
//                                                     .assessments[0]
//                                                     .metrics![index]
//                                                     .questions!
//                                                     .length,
//                                                 itemBuilder: (context, idex) {
//                                                   var question = controller
//                                                       .assessments[0]
//                                                       .metrics![index]
//                                                       .questions![idex];
//                                                   return Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Row(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .center,
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           Expanded(
//                                                             child: Text(
//                                                                 "${controller.assessments[0].metrics![index].questions![idex].questionDescription!.question} ? ",
//                                                                 style: TextStyling
//                                                                     .formBgGreyTextStyle),
//                                                           ),
//                                                           Column(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               _ratingContainer(
//                                                                   index,
//                                                                   question),
//                                                               SizedBox(
//                                                                   height: SizeConfig
//                                                                           .heightMultiplier *
//                                                                       0.6),
//                                                               _ratingBar(index,
//                                                                   question),
//                                                             ],
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       SizedBox(
//                                                         height: SizeConfig
//                                                                 .heightMultiplier *
//                                                             1.3,
//                                                       ),
//                                                       controller
//                                                                   .assessments[
//                                                                       0]
//                                                                   .metrics![
//                                                                       index]
//                                                                   .questions!
//                                                                   .length ==
//                                                               idex + 1
//                                                           ? Container()
//                                                           : Divider(
//                                                               thickness: 1.5,
//                                                               color:
//                                                                   textFormBorderColor,
//                                                             ),
//                                                       SizedBox(
//                                                         height: SizeConfig
//                                                                 .heightMultiplier *
//                                                             1.3,
//                                                       ),
//                                                     ],
//                                                   );
//                                                 },
//                                               ),
//                                               SizedBox(
//                                                 height: SizeConfig
//                                                         .heightMultiplier *
//                                                     1.3,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 })),
//                   ),
//                   SizedBox(
//                     height: SizeConfig.heightMultiplier * 2,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: SizeConfig.widthMultiplier * 6),
//                     child: controller.isSubmiting.value
//                         ? Center(
//                             child: CircularProgressIndicator(
//                             color: blueDark,
//                           ))
//                         : DefaultButton(
//                             text: "Submit",
//                             press: () async {
//                               await controller.submit(
//                                   assignWorkerId: assignWorkerId,
//                                   context: context,
//                                   workerId: workerId,
//                                   projectId: project.projectId!,
//                                   levelAssessment: assessmentLevel);
//                               Navigator.pop(context);
//                               Navigator.pop(context);
//                             }),
//                   ),
//                   SizedBox(
//                     height: SizeConfig.heightMultiplier * 2,
//                   ),
//                 ],
//               ),
//             );
//           }),
//     );
//   }

//   _ratingContainer(int index, Questions question) {
//     return Obx(
//       () => Container(
//         decoration: BoxDecoration(
//             color: orangeLight, borderRadius: BorderRadius.circular(4)),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             "Ranking: ${getRankType(rankings: controller.rankings, metricId: controller.assessments[0].metrics![index].id!, questionId: question.questionDescription!.id!)}",
//             style: TextStyling.buttonWhiteTextStyle,
//           ),
//         ),
//       ),
//     );
//   }

//   _ratingBar(int index, Questions question) {
//     return Obx(
//       () => RatingBar(
//         // ignoreGestures: true,

//         initialRating: double.parse(getRankTypeIndex(
//                 rankings: controller.rankings,
//                 metricId: controller.assessments[0].metrics![index].id!,
//                 questionId: question.questionDescription!.id!)
//             .toString()),
//         direction: Axis.horizontal,
//         allowHalfRating: true,
//         itemCount: 3,
//         ratingWidget: RatingWidget(
//             full: Icon(
//               Icons.star,
//               color: orangeLightColor,
//             ),
//             half: Icon(
//               Icons.star,
//               color: greyBlackColorText,
//             ),
//             empty: Icon(
//               Icons.star,
//               color: greyBlackColorText,
//             )),
//         itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//         onRatingUpdate: (rating) {
//           if (rating == 1.0) {
//             controller.setAnswer(
//                 metricId: controller.assessments[0].metrics![index].id!,
//                 questionId: question.questionDescription!.id!,
//                 rankTypeId:
//                     controller.assessments[0].ratings![0].assessmentRating!.id!,
//                 rankTypeName: controller
//                     .assessments[0].ratings![0].assessmentRating!.rankType!);
//           } else if (rating == 2.0) {
//             controller.setAnswer(
//                 metricId: controller.assessments[0].metrics![index].id!,
//                 questionId: question.questionDescription!.id!,
//                 rankTypeId:
//                     controller.assessments[0].ratings![1].assessmentRating!.id!,
//                 rankTypeName: controller
//                     .assessments[0].ratings![1].assessmentRating!.rankType!);
//           } else if (rating == 3.0) {
//             controller.setAnswer(
//                 metricId: controller.assessments[0].metrics![index].id!,
//                 questionId: question.questionDescription!.id!,
//                 rankTypeId:
//                     controller.assessments[0].ratings![2].assessmentRating!.id!,
//                 rankTypeName: controller
//                     .assessments[0].ratings![2].assessmentRating!.rankType!);
//           } else {
//             controller.setAnswer(
//                 metricId: controller.assessments[0].metrics![index].id!,
//                 questionId: question.questionDescription!.id!,
//                 rankTypeId:
//                     controller.assessments[0].ratings![0].assessmentRating!.id!,
//                 rankTypeName: controller
//                     .assessments[0].ratings![0].assessmentRating!.rankType!);
//           }
//         },
//       ),
//     );
//   }
// }
