// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace, unused_element

import 'package:fixa/fixa_main_routes.dart';

class HomeRecordAttendance extends GetWidget<HomeRecordAttendanceController> {
  final Project project;
  final DateTime time;
  final int shiftId;
  final Services selectedService;
  final List<WorkerAttendance> workesAttendance;
  HomeRecordAttendance(
      {Key? key,
      required this.project,
      required this.shiftId,
      required this.time,
      required this.workesAttendance,
      required this.selectedService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: lightgreyBlueGreyColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 0.2,
          vertical: SizeConfig.heightMultiplier * 1.2,
        ),
        child: isKeyboard
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                
                      FloatingActionButton(
                          heroTag: null,
                          backgroundColor: orangeLightColor,
                          onPressed: () {
                              Get.toNamed(
                              RouteLinks.homeRegisterWorker,
                              arguments: {
                                "project": project,
                                "selectedService": selectedService
                              });
                           
                          },
                          child: Center(
                            child: SvgPicture.asset(
                              Images.plusIcon,
                              height: SizeConfig.heightMultiplier * 1.5,
                              width: SizeConfig.widthMultiplier * 4,
                              color: whiteColor,
                            ),
                          ),
                        ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.2),
                  Obx(() => FloatingActionButton(
                        heroTag: null,
                        backgroundColor: blueColorText,
                        onPressed: () =>
                            controller.selectedAssignedWorkers.isEmpty
                                ? warningMessage(message: "No worker selected")
                                : _showSendModal(context: context),
                        child: controller.isSubmit.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: whiteColor,
                                ),
                              )
                            : Center(
                                child: SvgPicture.asset(
                                  Images.selectIcon,
                                  height: SizeConfig.heightMultiplier * 1.5,
                                  width: SizeConfig.widthMultiplier * 4,
                                  color: whiteColor,
                                ),
                              ),
                      ))
                ],
              ),
      ),
      body: GetBuilder<HomeRecordAttendanceController>(
          init: HomeRecordAttendanceController(),
          initState: (_) => controller.getAssignedWorkers(
              projectId: project.projectId!,
              serviceId: selectedService.id!,
              project: project,
              workersAttendances: workesAttendance),
          builder: (cons) {
            return SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.heightMultiplier * 3),
                  _appBar(context: context),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  Text(
                    "Select Workers to be added on the ${project.projectName} Project",
                    textAlign: TextAlign.center,
                    style: TextStyling.formBgGreyTextStyle,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24),
                      ),
                    ),
                    child: Obx(
                      () => controller.isLoading.value
                          ? lottieLoading(sizeConfigHeight: 16)
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: SizeConfig.heightMultiplier * 2,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.widthMultiplier * 5.5),
                                  child: Text.rich(
                                    TextSpan(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                      controller.selectedAssignedWorkers.length >1 ?TextSpan(
                                          text:
                                              "${controller.selectedAssignedWorkers.length.toString()} Workers ",
                                          style: TextStyling.blueTextStyle,
                                        ) :  
                                        TextSpan(
                                          text:
                                              "${controller.selectedAssignedWorkers.length.toString()} Worker ",
                                          style: TextStyling.blueTextStyle,
                                        ),
                                        TextSpan(
                                          text: "Selected",
                                          style:
                                              TextStyling.formBgGreyTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.heightMultiplier * 1.2,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          controller.assignedWorkers.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  SizeConfig.widthMultiplier *
                                                      5.5,
                                              vertical:
                                                  SizeConfig.heightMultiplier *
                                                      1.2),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    SizeConfig.widthMultiplier *
                                                        1,
                                                vertical: SizeConfig
                                                        .heightMultiplier *
                                                    1.2),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            lightBlueGreyColor)),
                                                color: whiteColor),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: SizeConfig
                                                                .heightMultiplier *
                                                            7,
                                                        width: SizeConfig
                                                                .widthMultiplier *
                                                            16,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                textFormColor,
                                                            shape: BoxShape
                                                                .circle),
                                                        child: Center(
                                                          child: Text(
                                                            "${controller.assignedWorkers[index].firstName![0].toString().toUpperCase()}${controller.assignedWorkers[index].lastName![0].toString().toUpperCase()}",
                                                            style: TextStyling
                                                                .formBlueTextStyle,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: SizeConfig
                                                                .widthMultiplier *
                                                            3,
                                                      ),
                                                      Expanded(
                                                        flex: 7,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "${nameCapitalised(controller.assignedWorkers[index].firstName)} ${nameCapitalised(controller.assignedWorkers[index].lastName)}",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyling
                                                                  .normalBoldTextStyle,
                                                            ),
                                                            SizedBox(
                                                              height: SizeConfig
                                                                      .heightMultiplier *
                                                                  0.6,
                                                            ),
                                                            Text(
                                                                "${controller.assignedWorkers[index].nidNumber}",
                                                                style: TextStyling
                                                                    .formGreyTextStyle),
                                                            SizedBox(
                                                              height: SizeConfig
                                                                      .heightMultiplier *
                                                                  0.6,
                                                            ),
                                                             Text(
                                                              getLitsts(items:controller.assignedWorkers[index].rates!).last != 'null' ? 
                                                                "${getLitsts(items:controller.assignedWorkers[index].rates!).last}  Rwf": "0 Rwf",
                                                                style: TextStyling
                                                                    .formGreyTextStyle),
                                                            SizedBox(
                                                              height: SizeConfig
                                                                      .heightMultiplier *
                                                                  0.6,
                                                            ),
                                                            SizedBox(
                                                              height: SizeConfig
                                                                      .heightMultiplier *
                                                                  3,
                                                              child: ListView(
                                                                shrinkWrap:
                                                                    true,
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                2.0),
                                                                    child: Text(
                                                                        "${controller.assignedWorkers[index].phoneNumber}",
                                                                        style: TextStyling
                                                                            .formGreyTextStyle),
                                                                  ),
                                                                  SizedBox(
                                                                    width: SizeConfig
                                                                            .widthMultiplier *
                                                                        1.5,
                                                                  ),
                                                                  SvgPicture
                                                                      .asset(
                                                                    Images
                                                                        .isVerifiedIcon,
                                                                    height:
                                                                        SizeConfig.heightMultiplier *
                                                                            1.8,
                                                                    color:
                                                                        greenColor,
                                                                  ),
                                                                  SizedBox(
                                                                    width: SizeConfig
                                                                            .widthMultiplier *
                                                                        1.5,
                                                                  ),
                                                                  ListView.builder(
                                                                      shrinkWrap: true,
                                                                      scrollDirection: Axis.horizontal,
                                                                      itemCount: getServiceRates(services: controller.assignedWorkers[index].services!, servicesList: project.services!).length,
                                                                      itemBuilder: (context, idex) {
                                                                        var service = getServiceRates(
                                                                            services:
                                                                                controller.assignedWorkers[index].services!,
                                                                            servicesList: project.services!)[idex];
                                                                        return Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 1.5),
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(color: textFormColor, borderRadius: BorderRadius.circular(4)),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 1.5, vertical: SizeConfig.heightMultiplier * 0.3),
                                                                              child: Text(
                                                                                service["service_name"],
                                                                                style: TextStyling.blueSmallTextStyle,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      _selectContainer(
                                                          workerAssign: controller
                                                                  .assignedWorkers[
                                                              index]),
                                                      // controller
                                                      //         .selectedAssignedWorkers
                                                      //         .contains(controller
                                                      //                 .assignedWorkers[
                                                      //             index])
                                                      //     ?
                                                      //     GestureDetector(
                                                      //         onTap: () async => await controller.addWorker(
                                                      //             serviceId:
                                                      //                 selectedService
                                                      //                     .id!,
                                                      //             toAdd: controller
                                                      //                     .assignedWorkers[
                                                      //                 index]),
                                                      //         child: Container(
                                                      //           height: SizeConfig
                                                      //                   .heightMultiplier *
                                                      //               4,
                                                      //           width: SizeConfig
                                                      //                   .widthMultiplier *
                                                      //               9,
                                                      //           decoration: BoxDecoration(
                                                      //               color: getCircledColor(
                                                      //                   selectedAssignedWorkers:
                                                      //                       controller
                                                      //                           .selectedAssignedWorkers,
                                                      //                   workerAssign:
                                                      //                       controller.assignedWorkers[
                                                      //                           index],
                                                      //                   workersSelectedAttendance:
                                                      //                       controller
                                                      //                           .selectedAssignedWorkersAttedance),
                                                      //               shape: BoxShape
                                                      //                   .circle),
                                                      //           child: Center(
                                                      //             child:
                                                      //                 SvgPicture
                                                      //                     .asset(
                                                      //               Images
                                                      //                   .selectIcon,
                                                      //               height:
                                                      //                   SizeConfig.heightMultiplier *
                                                      //                       0.7,
                                                      //               width: SizeConfig
                                                      //                       .widthMultiplier *
                                                      //                   4,
                                                      //               color:
                                                      //                   whiteColor,
                                                      //             ),
                                                      //           ),
                                                      //         ),
                                                      //       )
                                                      //     : GestureDetector(
                                                      //         onTap: () async => await controller.addWorker(
                                                      //             serviceId:
                                                      //                 selectedService
                                                      //                     .id!,
                                                      //             toAdd: controller
                                                      //                     .assignedWorkers[
                                                      //                 index]),
                                                      //         child: Container(
                                                      //           height: SizeConfig
                                                      //                   .heightMultiplier *
                                                      //               4,
                                                      //           width: SizeConfig
                                                      //                   .widthMultiplier *
                                                      //               9,
                                                      //           decoration: BoxDecoration(
                                                      //               color:
                                                      //                   whiteColor,
                                                      //               border: Border.all(
                                                      //                   color:
                                                      //                       blueDark),
                                                      //               shape: BoxShape
                                                      //                   .circle),
                                                      //         ),
                                                      //       )
                                                    ],
                                                  ),
                                                ),
                                                // Divider(
                                                //   thickness: 0.5,
                                                //   color: lightBlueGreyColor,
                                                // ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                    ),
                  )),
                ],
              ),
            ));
          }),
    );
  }

  Widget _selectContainer({required AssignedWorkers workerAssign}) {
    var widgetSelected = GestureDetector(
      onTap: () async => await controller.addWorker(
          projectId: project.projectId!,
          serviceId: selectedService.id!,
          toAdd: workerAssign),
      child: Container(
        height: SizeConfig.heightMultiplier * 4,
        width: SizeConfig.widthMultiplier * 9,
        decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(color: blueDark),
            shape: BoxShape.circle),
      ),
    );
    // return Obx(
    //   () {
    // worker is present in the attendance
    if (workerAssign.assignedWorkerId != null &&
        checkAttendanceWorkerPresence(
            assignedWorkerId: workerAssign.assignedWorkerId!,
            attendanceWorkers: controller.selectedAssignedWorkersAttedance)) {
      widgetSelected = GestureDetector(
        child: Container(
          height: SizeConfig.heightMultiplier * 4,
          width: SizeConfig.widthMultiplier * 9,
          decoration: BoxDecoration(color: greenColor, shape: BoxShape.circle),
          child: Center(
            child: SvgPicture.asset(
              Images.selectIcon,
              height: SizeConfig.heightMultiplier * 0.7,
              width: SizeConfig.widthMultiplier * 4,
              color: whiteColor,
            ),
          ),
        ),
      );
    }
    // worker is selected
    else if (checkSelectedWorkerPresence(
        assignedWorker: workerAssign,
        selectedWorker: controller.selectedAssignedWorkers)) {
      widgetSelected = GestureDetector(
        onTap: () async => await controller.addWorker(
            projectId: project.projectId!,
            serviceId: selectedService.id!,
            toAdd: workerAssign),
        child: Container(
          height: SizeConfig.heightMultiplier * 4,
          width: SizeConfig.widthMultiplier * 9,
          decoration: BoxDecoration(color: blueDark, shape: BoxShape.circle),
          child: Center(
            child: SvgPicture.asset(
              Images.selectIcon,
              height: SizeConfig.heightMultiplier * 0.7,
              width: SizeConfig.widthMultiplier * 4,
              color: whiteColor,
            ),
          ),
        ),
      );
    }
    // worker is not selected
    // else {
    //   GestureDetector(
    //     onTap: () async => await controller.addWorker(
    //         serviceId: selectedService.id!, toAdd: workerAssign),
    //     child: Container(
    //       height: SizeConfig.heightMultiplier * 4,
    //       width: SizeConfig.widthMultiplier * 9,
    //       decoration: BoxDecoration(
    //           color: whiteColor,
    //           border: Border.all(color: blueDark),
    //           shape: BoxShape.circle),
    //     ),
    //   );
    // }
    // return GestureDetector(
    //   onTap: () async => await controller.addWorker(
    //       serviceId: selectedService.id!, toAdd: workerAssign),
    //   child: Container(
    //     height: SizeConfig.heightMultiplier * 4,
    //     width: SizeConfig.widthMultiplier * 9,
    //     decoration: BoxDecoration(
    //         color: whiteColor,
    //         border: Border.all(color: blueDark),
    //         shape: BoxShape.circle),
    //   ),
    // );
    // },
    // );
    return widgetSelected;
  }

  _viewTabs(
      {required String logo,
      required String logo2,
      required String name,
      required Color color,
      required bool isRed}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          logo.isEmpty
              ? Container()
              : SvgPicture.asset(
                  logo,
                  color: color,
                  height: SizeConfig.heightMultiplier * 2,
                ),
          SizedBox(
            width: SizeConfig.widthMultiplier * 3,
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            style: !isRed
                ? TextStyling.normalBoldGreenTextStyle
                : TextStyling.normalBoldRedTextStyle,
          ),
          Spacer(),
          logo2.isEmpty
              ? Container()
              : SvgPicture.asset(
                  logo2,
                  color: color,
                  height: SizeConfig.heightMultiplier * 2,
                ),
        ],
      ),
    );
  }

  _showSendModal({required BuildContext context}) {
    return showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier * 0.8,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 27),
                  child: Container(
                    height: 2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: textFormBorderColor,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                Center(
                  child: Text.rich(
                    TextSpan(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        TextSpan(
                          text: "Date: ",
                          style: TextStyling.formBgGreyTextStyle,
                        ),
                        TextSpan(
                          text:
                              "${controller.dateTme.value.day} | ${controller.dateTme.value.month} | ${controller.dateTme.value.year}",
                          style: TextStyling.blueTextStyle,
                        ),
                        TextSpan(
                          text: "   Shift: ",
                          style: TextStyling.formBgGreyTextStyle,
                        ),
                        TextSpan(
                          text: "${controller.shiftName}",
                          style: TextStyling.blueTextStyle,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.2,
                ),
                Center(
                  child: Text.rich(
                    TextSpan(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        TextSpan(
                          text: "Are you sure you would like to add ",
                          style: TextStyling.formBgGreyTextStyle,
                        ),
                        controller.selectedAssignedWorkers.length > 1
                            ? TextSpan(
                                text:
                                    "${controller.selectedAssignedWorkers.length.toString()} workers ",
                                style: TextStyling.blueTextStyle,
                              )
                            : TextSpan(
                                text:
                                    "${controller.selectedAssignedWorkers.length.toString()} worker ",
                                style: TextStyling.blueTextStyle,
                              ),
                        TextSpan(
                          text: "to attendance?",
                          style: TextStyling.formBgGreyTextStyle,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      controller.makeAttendance(
                          project: project,
                          time: time,
                          shiftId: shiftId,
                          selectedServiceId: selectedService.id!);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: _viewTabs(
                        logo: Images.selectIcon,
                        name: "Yes",
                        logo2: "",
                        color: greenColorText,
                        isRed: false)),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
                Divider(
                  thickness: 1.5,
                  color: textFormBorderColor,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 4),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Get.back(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Images.viewPayrollIcon,
                          color: appBarColorText,
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 3,
                        ),
                        Text(
                          "Select more ",
                          textAlign: TextAlign.center,
                          style: TextStyling.normalBoldTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
                Divider(
                  thickness: 1.5,
                  color: textFormBorderColor,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      await controller.removeAllWorkersSelected(
                          projectId: project.projectId!,
                          serviceId: selectedService.id!);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: _viewTabs(
                        logo: Images.timesIcon,
                        name: "No",
                        logo2: "",
                        color: redDark,
                        isRed: true)),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
                Divider(
                  thickness: 1.5,
                  color: textFormBorderColor,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
              ],
            ),
          );
        });
  }

  _showMessageModal({required BuildContext context}) {
    return showModalBottomSheet(
        isDismissible: false,
        // isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Container(
            height: SizeConfig.heightMultiplier * 48,
            // padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Send Message",
                        style: TextStyling.normalBoldTextStyle,
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: SvgPicture.asset(
                          Images.timesIcon,
                          color: appBarColorText,
                          height: SizeConfig.heightMultiplier * 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.3,
                ),
                Divider(
                  thickness: 1.5,
                  color: textFormBorderColor,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 4),
                  child: Text(
                      "Send Message to ${controller.selectedAssignedWorkers.length} workers",
                      style: TextStyling.formGreyTextStyle),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 4),
                  child: Text(
                    "Message",
                    style: TextStyling.normalBoldTextStyle,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.4,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 4),
                  child: Container(
                    // height: SizeConfig.heightMultiplier * 6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        border: Border.all(color: greyLightColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        // controller: textController,
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 5,
                        autocorrect: false,
                        // validator: (value) {
                        //   return controller.emailValidator(value!);
                        // },
                        decoration: InputDecoration(
                          hintText: "Enter text here",
                          border: InputBorder.none,
                          fillColor: whiteColor,
                          filled: true,
                          hintStyle: TextStyling.formTextStyle,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                Divider(
                  thickness: 1.5,
                  color: textFormBorderColor,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.3,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(right: SizeConfig.widthMultiplier * 3),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: SizeConfig.heightMultiplier * 5,
                        width: SizeConfig.widthMultiplier * 15,
                        decoration: BoxDecoration(
                            color: blueColorText,
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Text(
                            "Send",
                            style: TextStyling.nameWhiteProfileTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
              ],
            ),
          );
        });
  }

  _showBottomSheet({required BuildContext context}) {
    return showModalBottomSheet(
        // isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Obx(
            () => Container(
              height: SizeConfig.heightMultiplier * 20,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize:MainAxisSize.min,
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 0.8,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 27),
                    child: Container(
                      height: 2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: textFormBorderColor,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Center(
                    child: Text(
                        "Bulk Action to the ${controller.selectedAssignedWorkers.length} selected workers",
                        style: TextStyling.formGreyTextStyle),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  GestureDetector(
                    onTap: () => _showMessageModal(context: context),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          Images.smsIcon,
                          color: blackColor,
                          // height: SizeConfig.heightMultiplier * 2,
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 3,
                        ),
                        Text(
                          "Send message",
                          style: TextStyling.normalBoldTextStyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                  Divider(
                    thickness: 0.5,
                    color: textFormBorderColor,
                  ),
                ],
              ),
            ),
          );
        });
  }

  _appBar({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 4,
          vertical: SizeConfig.heightMultiplier * 1.5),
      child: Container(
        height: SizeConfig.heightMultiplier * 6,
        width: double.infinity,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12, right: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Get.back(),
                child: SvgPicture.asset(
                  Images.leftArrowIcon,
                  color: appBarColorText,
                  width: SizeConfig.widthMultiplier * 6,
                ),
              ),
              SizedBox(width: SizeConfig.widthMultiplier * 3),
              Expanded(
                child: TextFormField(
                  // controller: textController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      controller.searchWorkers(
                          data: value.toLowerCase(), isEmpty: true);
                    } else {
                      controller.searchWorkers(
                          data: value.toLowerCase(), isEmpty: false);
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Search by name, phone or ID",
                    border: InputBorder.none,
                    hintStyle: TextStyling.formTextStyle,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(width: SizeConfig.widthMultiplier * 3),
              SvgPicture.asset(
                Images.searchIcon,
                color: appBarColorText,
                width: SizeConfig.widthMultiplier * 4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
