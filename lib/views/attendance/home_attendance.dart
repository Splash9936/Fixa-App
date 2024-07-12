// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace, unnecessary_string_interpolations, unused_element, avoid_unnecessary_containers

import 'package:fixa/fixa_main_routes.dart';
// import 'body_home_attendance/home_attendance_select_project.dart';

class HomeAttendance extends GetWidget<HomeAttendanceController> {
  final Project project;
  final bool statusNavigator;
  HomeAttendance(
      {Key? key, required this.project, required this.statusNavigator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return selectProjectHomeAttendance();
    return Scaffold(
      backgroundColor: whiteColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: blueColorText,
        // onPressed: () {
        //                         Get.toNamed(RouteLinks.homeRecordAttendance,
        //                             arguments: {
        //                               "project": project,
        //                               "service": Services(id: 0,name: 'All',maximumRate: '0'),
        //                               "time":
        //                                   controller.mainController.dateTme.value,
        //                               "shiftId":
        //                                   controller.mainController.shift.value
        //                                       ? 2
        //                                       : 1,
        //                               "workers": getWorkersAttendances(
        //                                   attendances: controller
        //                                       .mainController.allAttendances,
        //                                   isShift:
        //                                       controller.mainController.shift.value
        //                                   )
        //                             });
        // },
        onPressed: () => _showModelSheetServices(
            services: controller.allServices,
            context: context),
        child: Center(
          child: SvgPicture.asset(
            Images.plusIcon,
            color: whiteColor,
            height: SizeConfig.heightMultiplier * 1.8,
          ),
        ),
      ),
      body: GetBuilder<HomeAttendanceController>(
          init: HomeAttendanceController(),
          initState: (_) =>
              controller.getData(time: DateTime.now(), project: project),
          builder: (controllerBuilder) {
            return Stack(
              children: [
                _displayEmptyAttendance(),
                Container(
                  height: SizeConfig.heightMultiplier * 46,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: blueDark,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                      )),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: SizeConfig.heightMultiplier * 3),
                        appBarAttendance(
                            text: "${fullNameCapitalised(project.projectName)}", context: context),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 0.6,
                        ),
                        _searchAppBar(context: context),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 1.2,
                        ),
                        _appShiftDate(context: context),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 1.2,
                        ),
                        _attendanceInfo(),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        _tabs(),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 1.8,
                        ),
                        _attendanceListView(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  _displayEmptyAttendance() {
    return Obx(
      () => controller.mainController.attendances.isNotEmpty
          ? Container()
          : Positioned(
              left: SizeConfig.widthMultiplier * 4,
              right: SizeConfig.widthMultiplier * 4,
              bottom: SizeConfig.heightMultiplier * 12,
              child: Container(
                width: double.infinity,
                height: SizeConfig.heightMultiplier * 32,
                decoration:
                    BoxDecoration(color: textFormColor, shape: BoxShape.circle),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Images.workerHelmetIcon,
                      height: SizeConfig.heightMultiplier * 12,
                      color: blueDark,
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    Text(
                      "No workers found",
                      textAlign: TextAlign.center,
                      style: TextStyling.formBgGreyTextStyle,
                    )
                  ],
                ),
              )),
    );
  }

  _attendanceListView() {
    return Obx(
      () => controller.mainController.isAttendanceLoading.value
          ? Expanded(
              child: Container(
                // height: SizeConfig.heightMultiplier * 40,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24),
                  ),
                ),
                child: lottieLoading(sizeConfigHeight: 16),
              ),
            )
          : controller.mainController.attendances.isEmpty
              ? Container()
              : Expanded(
                  child: Container(
                    // height: SizeConfig.heightMultiplier * 40,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24),
                      ),
                    ),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: controller.mainController.attendances.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 5.5,
                                vertical: SizeConfig.heightMultiplier * 1.2),
                            child: Obx(
                              () => Container(
                                decoration: BoxDecoration(
                                  color: controller.selectedWorkerData.contains(
                                          controller.mainController
                                              .attendances[index])
                                      ? textFormColor
                                      : whiteColor,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: textFormBorderColor)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, bottom: 12),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          controller.selectedWorkerData
                                                  .contains(controller
                                                      .mainController
                                                      .attendances[index])
                                              ? GestureDetector(
                                                  onTap: () =>
                                                      controller.addWorker(
                                                          toAdd: controller
                                                                  .mainController
                                                                  .attendances[
                                                              index]),
                                                  child: Container(
                                                    height: SizeConfig
                                                            .heightMultiplier *
                                                        7,
                                                    width: SizeConfig
                                                            .widthMultiplier *
                                                        16,
                                                    decoration: BoxDecoration(
                                                        color: blueDark,
                                                        shape: BoxShape.circle),
                                                    child: Center(
                                                      child: SvgPicture.asset(
                                                        Images.selectIcon,
                                                        height: SizeConfig
                                                                .heightMultiplier *
                                                            1.5,
                                                        width: SizeConfig
                                                                .widthMultiplier *
                                                            4,
                                                        color: whiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () =>
                                                      controller.addWorker(
                                                          toAdd: controller
                                                                  .mainController
                                                                  .attendances[
                                                              index]),
                                                  child: Container(
                                                    height: SizeConfig
                                                            .heightMultiplier *
                                                        7,
                                                    width: SizeConfig
                                                            .widthMultiplier *
                                                        16,
                                                    decoration: BoxDecoration(
                                                        color: textFormColor,
                                                        shape: BoxShape.circle),
                                                    child: Center(
                                                      child: Text(
                                                        "${controller.mainController.attendances[index].firstname![0].toString().toUpperCase()}${controller.mainController.attendances[index].lastname![0].toString().toUpperCase()}",
                                                        style: TextStyling
                                                            .formBlueTextStyle,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          SizedBox(
                                            width:
                                                SizeConfig.widthMultiplier * 3,
                                          ),
                                          Expanded(
                                            child: Stack(children: [
                                              Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  // mainAxisAlignment: ,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: SizeConfig
                                                                  .widthMultiplier *
                                                              44,
                                                          child: Text(
                                                            "${nameCapitalised(controller.mainController.attendances[index].firstname!)} ${controller.mainController.attendances[index].lastname!}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            // softWrap: false,
                                                            style: TextStyling
                                                                .normalBoldTextStyle,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeConfig
                                                                  .heightMultiplier *
                                                              0.6,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                "${controller.mainController.attendances[index].phone!}",
                                                                style: TextStyling
                                                                    .formGreyTextStyle),
                                                            SizedBox(
                                                              width: SizeConfig
                                                                      .widthMultiplier *
                                                                  1.5,
                                                            ),
                                                            !controller
                                                                    .mainController
                                                                    .attendances[
                                                                        index]
                                                                    .isVerified!
                                                                ? SvgPicture
                                                                    .asset(
                                                                    Images
                                                                        .isVerifiedIcon,
                                                                    height:
                                                                        SizeConfig.heightMultiplier *
                                                                            1.8,
                                                                    color:
                                                                        greenColor,
                                                                  )
                                                                : Container(),
                                                           
                                                            
                                                          ],
                                                        ),
                                                         SizedBox(
                                                          height: SizeConfig
                                                                  .heightMultiplier *
                                                              0.6,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                              _ratingBar(
                                                                meanScore: controller
                                                                        .mainController
                                                                        .attendances[
                                                                            index]
                                                                        .meanScore ??
                                                                    0),
                                                                    SizedBox(
                                                              width: SizeConfig
                                                                      .widthMultiplier *
                                                                  1.5,
                                                            ),
                                                            getAttendanceStatusShift(
                                                                status: controller
                                                                        .mainController
                                                                        .attendances[
                                                                            index]
                                                                        .shiftStatus ??
                                                                    ''),
                                                          ],
                                                        ),
                                                      
                                                        SizedBox(
                                                          height: SizeConfig
                                                                  .heightMultiplier *
                                                              0.6,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                                "${controller.mainController.attendances[index].idNumber!}",
                                                                style: TextStyling
                                                                    .formGreyTextStyle),
                                                                 SizedBox(width: SizeConfig.widthMultiplier*4),
                                                            Text('${controller.mainController.attendances[index].workerRate} Rwf', style: TextStyling
                                                                    .formGreyTextStyle),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    controller
                                                            .selectedWorkerData
                                                            .contains(controller
                                                                .mainController
                                                                .attendances[index])
                                                        ? Container()
                                                        : SvgPicture.asset(
                                                            Images.moreIcon,
                                                            height: SizeConfig
                                                                    .heightMultiplier *
                                                                1.6,
                                                            color:
                                                                lightBlueGreyColor,
                                                          )
                                                  ]),
                                              Positioned.fill(
                                                child: GestureDetector(
                                                  onTap: () => _showModelSheet(
                                                      workerAttendance:
                                                          controller
                                                                  .mainController
                                                                  .attendances[
                                                              index],
                                                      serviceId: controller
                                                          .mainController
                                                          .attendances[index]
                                                          .serviceId!,
                                                      assignedWorkerId:
                                                          controller
                                                              .mainController
                                                              .attendances[
                                                                  index]
                                                              .assignedWorkerId!,
                                                      name:
                                                          "${controller.mainController.attendances[index].firstname!} ${controller.mainController.attendances[index].lastname!}",
                                                      context: context),
                                                  child: Container(
                                                    // height: double.infinity,
                                                    // width: double.infinity,
                                                    color: Colors.transparent,
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ),
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
                            ),
                          );
                        }),
                  ),
                ),
    );
  }

  _showModelTableCalendar({required BuildContext context}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 4,
                vertical: SizeConfig.heightMultiplier * 1.2),
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
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
                Center(
                  child: Text("Select a date",
                      style: TextStyling.formGreyTextStyle),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 4,
                ),
                Obx(
                  () => TableCalendar(
                    firstDay: controller.firstDay.value,
                    lastDay: controller.lastDay.value,
                    focusedDay: controller.mainController.dateTme.value,
                    calendarFormat: controller.formatClendar.value,
                    selectedDayPredicate: (day) {
                      return isSameDay(
                          controller.mainController.dateTme.value, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      controller.changeDate(
                          time: selectedDay, projectId: project.projectId!);
                      Navigator.pop(context);
                    },
                    onFormatChanged: (format) =>
                        controller.formatClendar.value = format,
                    onPageChanged: (focusedDay) {},
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.3,
                ),
                GestureDetector(
                  onTap: () {
                    controller.changeDate(
                        time: DateTime.now(), projectId: project.projectId!);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: SizeConfig.heightMultiplier * 6,
                    decoration: BoxDecoration(
                      color: textFormColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: Text(
                      "Jump to Today",
                      // "Jump to Today, ${controller.dateTme.value.day} | ${controller.dateTme.value.month} | ${controller.dateTme.value.year}",
                      style: TextStyling.buttonTextStyle,
                    )),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.3,
                ),
              ],
            ),
          );
        });
  }

  _showModelSheetServices(
      {required BuildContext context, required List<Services> services}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            builder: (context,controllerScroll) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 4,
                    vertical: SizeConfig.heightMultiplier * 1.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
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
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    Center(
                      child: Text("Select a service",
                          style: TextStyling.formGreyTextStyle),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 4,
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: controllerScroll,
                          shrinkWrap: true,
                          itemCount: services.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Navigator.pop(context);
                                Get.toNamed(RouteLinks.homeRecordAttendance,
                                    arguments: {
                                      "project": project,
                                      "service": services[index],
                                      "time":
                                          controller.mainController.dateTme.value,
                                      "shiftId":
                                          controller.mainController.shift.value
                                              ? 2
                                              : 1,
                                      "workers": getWorkersAttendances(
                                          attendances: controller
                                              .mainController.allAttendances,
                                          isShift:
                                              controller.mainController.shift.value,
                                          // service: services[index]
                                          )
                                    });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _viewTabs(
                                      logo: "",
                                      name: "${services[index].name}",
                                      color: blackColor,
                                      logo2: Images.arrorwRight,
                                      isRed: false),
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
                          }),
                    )
                  ],
                ),
              );
            }
          );
        });
  }

  _showModelSheetAppBarReasons(
      {required BuildContext context,
      required GestureTapCallback press,
      required bool isRemoving,
      required String buttonText}) {
    controller.selectedReason.value = {"id": 0, "name": "none"};
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 4,
                  vertical: SizeConfig.heightMultiplier * 1.2),
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
                    height: SizeConfig.heightMultiplier * 1.5,
                  ),
                  Center(
                    child: Text(
                        isRemoving
                            ? "Select the reason to remove the selected worker(s)"
                            : "Select the reason to Apply shift to the selected worker(s)",
                        style: TextStyling.formGreyTextStyle),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.reasons.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => controller.setReason(
                              setReason: controller.reasons[index]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _viewTabsCircled(
                                  name: "${controller.reasons[index]["name"]}",
                                  color: blackColor,
                                  selectedReasonId: controller.reasons[index]
                                      ["id"]),
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
                      }),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.5,
                  ),
                  GestureDetector(
                    onTap: press,
                    child: Container(
                      height: SizeConfig.heightMultiplier * 6,
                      decoration: BoxDecoration(
                        color: blueColorText,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                          child: Text(
                        buttonText,
                        style: TextStyling.buttonWhiteTextStyle,
                      )),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _showMessageModal({required BuildContext context}) {
    return showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                          behavior: HitTestBehavior.opaque,
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
                        "Send Message to ${controller.selectedWorkerData.length} workers",
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
                          controller: controller.sms.value,
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 5,
                          autocorrect: false,
                          validator: (value) {
                            return value!.isEmpty ? "Insert a message" : null;
                          },
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
                  GestureDetector(
                    onTap: () {
                      controller.sendMessage();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: SizeConfig.widthMultiplier * 3),
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
                            child: controller.issmsLoading.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: whiteColor,
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      "Send",
                                      style:
                                          TextStyling.nameWhiteProfileTextStyle,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.5,
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showModelSheetBulkAction(
      {required String name, required BuildContext context}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 4,
                vertical: SizeConfig.heightMultiplier * 1.2),
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
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
                Center(
                  child: Text("Bulk action to the $name selected workers",
                      style: TextStyling.formGreyTextStyle),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 4,
                ),
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _showMessageModal(context: context),
                    child: _viewTabs(
                        logo: Images.smsIcon,
                        name: "Send message",
                        color: blackColor,
                        logo2: "",
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
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _showModalBulkDeductions(context: context),
                    child: _viewTabs(
                        logo: Images.deductionIcon,
                        name: "Add Deductions",
                        color: blackColor,
                        logo2: "",
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
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _showModelSheetAppBarReasons(
                        context: context,
                        isRemoving: false,
                        buttonText: "apply",
                        press: () {
                          controller.applyHalfShiftWorkers(
                              projectId: project.projectId!,
                              time: controller.mainController.dateTme.value);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }),
                    child: _viewTabs(
                        logo: Images.halfIcon,
                        name: "Apply Half-Shift",
                        color: blackColor,
                        logo2: "",
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
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _showModelSheetAppBarReasons(
                        context: context,
                        isRemoving: true,
                        buttonText: "Remove",
                        press: () {
                          controller.removeWorkerFromAttendance(
                              projectId: project.projectId!,
                              time: controller.mainController.dateTme.value);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }),
                    child: _viewTabs(
                        logo: Images.banIcon,
                        name: "Remove",
                        color: redDark,
                        logo2: "",
                        isRed: true)),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
                Divider(
                  thickness: 1.5,
                  color: textFormBorderColor,
                ),
              ],
            ),
          );
        });
  }

  _formText({required String text}) {
    return Text(
      text,
      style: TextStyling.nameProfileGreyTextStyle,
    );
  }

  _fieldForm({required String hintText}) {
    return Container(
      height: SizeConfig.heightMultiplier * 6,
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
          autocorrect: false,
          // validator: (value) {
          //   return controller.emailValidator(value!);
          // },
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            fillColor: whiteColor,
            filled: true,
            hintStyle: TextStyling.formTextStyle,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  _fieldDropDownForm({required String hintText}) {
    return Container(
      // height: SizeConfig.heightMultiplier * 6,
      width: double.infinity,
      decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: greyLightColor),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonFormField<Services>(
            icon:  Icon(
              Icons.arrow_drop_down,
              color: blackColor,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: whiteColor,
              hintStyle: TextStyling.formTextStyle,
              filled: true,
              hintText: hintText,
            ),
            items: project.services!
                .map((val) => DropdownMenuItem<Services>(
                      child: Text(val.name!),
                      value: val,
                    ))
                .toList(),
            onChanged: (value) {}),
      ),
    );
  }

  _addService() {
    return Container(
      width: SizeConfig.widthMultiplier * 35,
      decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: greyLightColor),
          borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 2.5,
            vertical: SizeConfig.heightMultiplier * 0.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Images.plusIcon,
              color: appBarColorText,
              height: SizeConfig.heightMultiplier * 1.2,
            ),
            SizedBox(width: SizeConfig.widthMultiplier * 3),
            Text(
              "Add deductions",
              style: TextStyling.nameSmallGreyTextStyle,
            )
          ],
        ),
      ),
    );
  }

  _widgetListDeductions({required DeductionControllers deduction}) {
    var dedeductionType = controller.deductionsTypes
        .where((item) => item.id == deduction.deductionTypeId)
        .toList();
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.heightMultiplier * 1.2,
          horizontal: SizeConfig.widthMultiplier * 4),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(color: greyLightColor),
            borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.heightMultiplier * 1.2,
              horizontal: SizeConfig.widthMultiplier * 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _formText(text: "Deduction Type"),
                  // GestureDetector(
                  //   // onTap: () => controller.removeDeduction(
                  //   //     deductionController: deductionController),
                  //   child: SvgPicture.asset(
                  //     Images.trashIcon,
                  //     color: appBarColorText,
                  //   ),
                  // )
                ],
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 1.2),
              Container(
                // height: SizeConfig.heightMultiplier * 6,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: greyLightColor),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<DeductionTypes>(
                      value: dedeductionType[0],
                      icon:  Icon(
                        Icons.arrow_drop_down,
                        color: blackColor,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: whiteColor,
                        hintStyle: TextStyling.formTextStyle,
                        filled: true,
                        hintText: "choose deduction type",
                      ),
                      items: controller.deductionsTypes
                          .map((val) => DropdownMenuItem<DeductionTypes>(
                                child: Text(val.title!),
                                value: val,
                              ))
                          .toList(),
                      onChanged: (value) {
                        deduction.deductionTypeId = value!.id!;
                      }),
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              _formText(text: "Amount"),
              SizedBox(height: SizeConfig.heightMultiplier * 1.2),
              Container(
                height: SizeConfig.heightMultiplier * 6,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: greyLightColor),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: deduction.deductedAmount,
                    enabled: false,
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    // validator: (value) {
                    //   return controller.emailValidator(value!);
                    // },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: whiteColor,
                      filled: true,
                      hintStyle: TextStyling.formTextStyle,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _widgetDeductions(
      {required DeductionControllers deductionController,
      required BuildContext context,
      required int assignedWorkerId}) {
    if (deductionController.deductionId != 0) {
      var dedeductionType = controller.deductionsTypes
          .where((item) => item.id == deductionController.deductionTypeId)
          .toList();
      return Padding(
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1.2,
            horizontal: SizeConfig.widthMultiplier * 4),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: whiteColor,
              border: Border.all(color: greyLightColor),
              borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.heightMultiplier * 1.2,
                horizontal: SizeConfig.widthMultiplier * 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _formText(text: "Deduction Type"),
                    GestureDetector(
                      onTap: () async {
                        await controller.removeWorkerDeduction(
                            projectId: project.projectId!,
                            assignedWorkerId: assignedWorkerId,
                            time: controller.mainController.dateTme.value,
                            deductionId: deductionController.deductionId);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        Images.trashIcon,
                        color: appBarColorText,
                      ),
                    )
                  ],
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 1.2),
                Container(
                  // height: SizeConfig.heightMultiplier * 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(color: greyLightColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<DeductionTypes>(
                        value: dedeductionType[0],
                        icon:  Icon(
                          Icons.arrow_drop_down,
                          color: blackColor,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: whiteColor,
                          hintStyle: TextStyling.formTextStyle,
                          filled: true,
                          hintText: "choose deduction type",
                        ),
                        items: controller.deductionsTypes
                            .map((val) => DropdownMenuItem<DeductionTypes>(
                                  child: Text(val.title!),
                                  value: val,
                                ))
                            .toList(),
                        onChanged: (value) {
                          deductionController.deductionTypeId = value!.id!;
                        }),
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                _formText(text: "Amount"),
                SizedBox(height: SizeConfig.heightMultiplier * 1.2),
                Container(
                  height: SizeConfig.heightMultiplier * 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(color: greyLightColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: deductionController.deductedAmount,
                      keyboardType: TextInputType.number,
                      autocorrect: false,
                      // validator: (value) {
                      //   return controller.emailValidator(value!);
                      // },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: whiteColor,
                        filled: true,
                        hintStyle: TextStyling.formTextStyle,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1.2,
            horizontal: SizeConfig.widthMultiplier * 4),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: whiteColor,
              border: Border.all(color: greyLightColor),
              borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.heightMultiplier * 1.2,
                horizontal: SizeConfig.widthMultiplier * 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _formText(text: "Deduction Type"),
                    GestureDetector(
                      onTap: () => controller.removeDeduction(
                          deductionController: deductionController),
                      child: SvgPicture.asset(
                        Images.trashIcon,
                        color: appBarColorText,
                      ),
                    )
                  ],
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 1.2),
                Container(
                  // height: SizeConfig.heightMultiplier * 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(color: greyLightColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<DeductionTypes>(
                        icon:  Icon(
                          Icons.arrow_drop_down,
                          color: blackColor,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: whiteColor,
                          hintStyle: TextStyling.formTextStyle,
                          filled: true,
                          hintText: "choose deduction type",
                        ),
                        items: controller.deductionsTypes
                            .map((val) => DropdownMenuItem<DeductionTypes>(
                                  child: Text(val.title!),
                                  value: val,
                                ))
                            .toList(),
                        onChanged: (value) {
                          deductionController.deductionTypeId = value!.id!;
                        }),
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                _formText(text: "Amount"),
                SizedBox(height: SizeConfig.heightMultiplier * 1.2),
                Container(
                  height: SizeConfig.heightMultiplier * 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(color: greyLightColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: deductionController.deductedAmount,
                      keyboardType: TextInputType.number,
                      autocorrect: false,
                      // validator: (value) {
                      //   return controller.emailValidator(value!);
                      // },
                      decoration: InputDecoration(
                        hintText: "insert amount",
                        border: InputBorder.none,
                        fillColor: whiteColor,
                        filled: true,
                        hintStyle: TextStyling.formTextStyle,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  _showModalDeductions(
      {required context, required WorkerAttendance workerAttendance}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        // context: context,
        builder: (context) {
          return GetBuilder<HomeAttendanceController>(
              initState: (_) => controller.getWorkerDeductions(
                  time: controller.mainController.dateTme.value,
                  projectId: project.projectId!,
                  assignedWorkerId: workerAttendance.assignedWorkerId!),
              builder: (controllerBuilder) {
                return Padding(
                  padding: EdgeInsets.only(
                      right: SizeConfig.widthMultiplier * 7,
                      left: SizeConfig.widthMultiplier * 7,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Column(
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
                            height: SizeConfig.heightMultiplier * 5,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add deductions",
                                  style: TextStyling.normalBoldTextStyle,
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
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
                            height: SizeConfig.heightMultiplier * 3,
                          ),
                          controller.isgettingDeduction.value
                              ? Center(
                                  child: CircularProgressIndicator(
                                      color: blueDark))
                              : Container(),
                          ...controller.deductionsControllers.isEmpty
                              ? []
                              : controller.deductionsControllers.map(
                                  (deductionController) => _widgetDeductions(
                                      context: context,
                                      assignedWorkerId:
                                          workerAttendance.assignedWorkerId!,
                                      deductionController:
                                          deductionController)),
                          SizedBox(height: SizeConfig.heightMultiplier * 1.2),
                          GestureDetector(
                              onTap: () => controller.addDeduction(),
                              child: _addService()),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 1.3,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 6),
                            child: controller.isAddingDeduction.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: blueDark,
                                    ),
                                  )
                                : DefaultButton(
                                    text: "Save Deduction",
                                    press: () async {
                                      await controller.saveDeductions(
                                          deductionDate: controller
                                              .mainController.dateTme.value,
                                          project: project,
                                          workerAssignedId: workerAttendance
                                              .assignedWorkerId!);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  ),
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }

  _showModalBulkDeductions({required context}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        // context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                right: SizeConfig.widthMultiplier * 7,
                left: SizeConfig.widthMultiplier * 7,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
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
                      height: SizeConfig.heightMultiplier * 5,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Add deductions",
                            style: TextStyling.normalBoldTextStyle,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
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
                      height: SizeConfig.heightMultiplier * 3,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.heightMultiplier * 1.2,
                          horizontal: SizeConfig.widthMultiplier * 4),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            border: Border.all(color: greyLightColor),
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.heightMultiplier * 1.2,
                              horizontal: SizeConfig.widthMultiplier * 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _formText(text: "Deduction Type"),
                                ],
                              ),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier * 1.2),
                              Container(
                                // height: SizeConfig.heightMultiplier * 6,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    border: Border.all(color: greyLightColor),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButtonFormField<
                                          DeductionTypes>(
                                      icon:  Icon(
                                        Icons.arrow_drop_down,
                                        color: blackColor,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        fillColor: whiteColor,
                                        hintStyle: TextStyling.formTextStyle,
                                        filled: true,
                                        hintText: "choose deduction type",
                                      ),
                                      items: controller.deductionsTypes
                                          .map((val) =>
                                              DropdownMenuItem<DeductionTypes>(
                                                child: Text(val.title!),
                                                value: val,
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        controller.typeIdBulkDeduction.value =
                                            value!.id!;
                                      }),
                                ),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
                              _formText(text: "Amount"),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier * 1.2),
                              Container(
                                height: SizeConfig.heightMultiplier * 6,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    border: Border.all(color: greyLightColor),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller:
                                        controller.amountBulkDeduction.value,
                                    keyboardType: TextInputType.number,
                                    autocorrect: false,
                                    // validator: (value) {
                                    //   return controller.emailValidator(value!);
                                    // },
                                    decoration: InputDecoration(
                                      hintText: "insert amount",
                                      border: InputBorder.none,
                                      fillColor: whiteColor,
                                      filled: true,
                                      hintStyle: TextStyling.formTextStyle,
                                      disabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.3,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 6),
                      child: controller.isAddingBulkDeduction.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: blueDark,
                              ),
                            )
                          : DefaultButton(
                              text: "Save Deduction",
                              press: () async {
                                await controller.saveBulkDeductions(
                                    project: project);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 3,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _showModelSheet(
      {required String name,
      required WorkerAttendance workerAttendance,
      required int serviceId,
      required BuildContext context,
      required int assignedWorkerId}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 4,
                vertical: SizeConfig.heightMultiplier * 1.2),
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
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
                Center(
                  child: Text("Action to $name",
                      style: TextStyling.formGreyTextStyle),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 4,
                ),
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      Get.toNamed(RouteLinks.homeWorkerProfile, arguments: {
                        "worker_id": workerAttendance.workerId,
                        "worker_name":"${nameCapitalised(workerAttendance.firstname)} ${nameCapitalised(workerAttendance.lastname)}",
                        "assigned_worker_id": workerAttendance.assignedWorkerId,
                        "project": project
                      });
                    },
                    child: _viewTabs(
                        logo: Images.userLogo,
                        name: "View Profile",
                        color: blackColor,
                        logo2: "",
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
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Get.toNamed(RouteLinks.homeWorkerAssessment,
                            arguments: {
                              "workerFullName":
                                  '${workerAttendance.firstname} ${workerAttendance.lastname}',
                              'project_id': project.projectId,
                              'service_id': workerAttendance.serviceId,
                              "worker_id": workerAttendance.workerId,
                              "assignedWorkerId":
                                  workerAttendance.assignedWorkerId,
                              "status": true,
                            }),
                    child: _viewTabs(
                        logo: Images.starrIcon,
                        name: "Assess worker",
                        color: blackColor,
                        logo2: "",
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
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _showModelSheetAppBarReasons(
                        context: context,
                        isRemoving: false,
                        buttonText: "apply",
                        press: () {
                          controller.applyHalfShiftWorker(
                              workerId: workerAttendance.assignedWorkerId!,
                              projectId: project.projectId!,
                              time: controller.mainController.dateTme.value);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }),
                    child: _viewTabs(
                        logo: Images.halfIcon,
                        name: "Apply Half-Shift",
                        color: blackColor,
                        logo2: "",
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
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _showModalDeductions(
                        context: context, workerAttendance: workerAttendance),
                    child: _viewTabs(
                        logo: Images.deductionIcon,
                        name: "Add Deductions",
                        logo2: "",
                        color: blackColor,
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
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _showModelSheetAppBarReasons(
                        context: context,
                        isRemoving: true,
                        buttonText: "Remove",
                        press: () {
                          controller.removeOneWorkerFromAttendance(
                              projectId: project.projectId!,
                              time: controller.mainController.dateTme.value,
                              workerId: workerAttendance.assignedWorkerId!);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }),
                    child: _viewTabs(
                        logo: Images.banIcon,
                        name: "Remove",
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
              ],
            ),
          );
        });
  }

  _viewTabsCircled(
      {required String name,
      required int selectedReasonId,
      required Color color}) {
    return Obx(
      () => Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: controller.selectedReason["id"] == selectedReasonId
                      ? blueDark
                      : whiteColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: blueDark)),
              child: Center(
                child: SvgPicture.asset(
                  Images.selectIcon,
                  height: SizeConfig.heightMultiplier * 1.3,
                  color: whiteColor,
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 3,
            ),
            Text(name, style: TextStyling.normalBoldTextStyle),
          ],
        ),
      ),
    );
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
                  // height: SizeConfig.heightMultiplier * 2,
                ),
          SizedBox(
            width: SizeConfig.widthMultiplier * 3,
          ),
          Text(
            nameCapitalised(name),
            style: !isRed
                ? TextStyling.normalBoldTextStyle
                : TextStyling.normalBoldRedTextStyle,
          ),
          Spacer(),
          logo2.isEmpty
              ? Container()
              : SvgPicture.asset(
                  logo2,
                  color: color,
                  // height: SizeConfig.heightMultiplier * 2,
                ),
        ],
      ),
    );
  }

  _tabs() {
    return SizedBox(
      height: SizeConfig.heightMultiplier * 6,
      child: Obx(
        () => ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: arrangeServices(
                    shift: controller.mainController.shift.value,
                    allServices: controller.allServices,
                    workersAttendance:
                        controller.mainController.allServicesAttendances)
                .length,
            itemBuilder: (context, index) {
              var serviceData = arrangeServices(
                  shift: controller.mainController.shift.value,
                  allServices: controller.allServices,
                  workersAttendance:
                      controller.mainController.allServicesAttendances)[index];
              return Obx(
                () => GestureDetector(
                  onTap: () => controller.changeService(
                      id: serviceData["service_id"],
                      serviceName: serviceData["service_name"].toLowerCase()),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 2),
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 4,
                        vertical: SizeConfig.heightMultiplier * 0.5),
                    decoration: BoxDecoration(
                        color: serviceData["service_id"] ==
                                controller.mainController.selectedService.value
                            ? whiteColor
                            : blueDark,
                        border: Border.all(color: bluelight),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${serviceData["service_name"]}",
                            style: serviceData["service_id"] ==
                                    controller
                                        .mainController.selectedService.value
                                ? TextStyling.blueTextStyle
                                : TextStyling.buttonMediumWhiteTextStyle),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 2,
                        ),
                        serviceData["service_workers"] == 0
                            ? Container()
                            : Container(
                                decoration: BoxDecoration(
                                  color: serviceData["service_id"] ==
                                          controller.mainController
                                              .selectedService.value
                                      ? blueDark
                                      : blueDark,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: bluelight)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.widthMultiplier * 2,
                                      vertical: 2),
                                  child: Text(
                                    "${serviceData["service_workers"]}",
                                    style:
                                        TextStyling.buttonMediumWhiteTextStyle,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  _attendanceInfo() {
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // approval
          controller.mainController.attendances.isEmpty
              ? Text(
                  " - ",
                  style: TextStyling.nameWhiteProfileTextStyle,
                )
              : getAttendanceStatus(
                  status:
                      "${controller.mainController.attendances[0].attendanceStatus}"),
          controller.selectedWorkerData.isEmpty
              ? Container()
              : Text.rich(
                  TextSpan(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      TextSpan(
                        text: "(${controller.selectedWorkerData.length})",
                        style: TextStyling.buttonMediumWhiteBoldTextStyle,
                      ),
                    ],
                  ),
                ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      controller.mainController.shift.value
                          ? TextSpan(
                              text: "Night: ",
                              style: TextStyling.buttonMediumWhiteTextStyle,
                            )
                          : TextSpan(
                              text: "Day: ",
                              style: TextStyling.buttonMediumWhiteTextStyle,
                            ),
                      controller.mainController.shift.value
                          ? TextSpan(
                              text:
                                  "${controller.mainController.allAttendances.where((item) => item.shiftName == "night").toList().length}",
                              style: TextStyling.buttonMediumWhiteBoldTextStyle,
                            )
                          : TextSpan(
                              text:
                                  "${controller.mainController.allAttendances.where((item) => item.shiftName == "day").toList().length}",
                              style: TextStyling.buttonMediumWhiteBoldTextStyle,
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 4,
                ),
                Container(
                  height: SizeConfig.heightMultiplier * 3,
                  width: 1.2,
                  decoration: BoxDecoration(
                      color: bluelight, borderRadius: BorderRadius.circular(4)),
                ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 4,
                ),
                Text.rich(
                  TextSpan(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      TextSpan(
                        text: "Total workers: ",
                        style: TextStyling.buttonMediumWhiteTextStyle,
                      ),
                      TextSpan(
                        text:
                            "${controller.mainController.allAttendances.length}",
                        style: TextStyling.buttonMediumWhiteBoldTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _appShiftDate({required BuildContext context}) {
    return Container(
      height: SizeConfig.heightMultiplier * 8,
      width: double.infinity,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 3,
                  vertical: SizeConfig.heightMultiplier * 0.6),
              child: GestureDetector(
                onTap: () => _showModelTableCalendar(context: context),
                child: Obx(
                  () => Container(
                    // width: SizeConfig.widthMultiplier * 30,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Date", style: TextStyling.formGreyTextStyle),
                        SizedBox(height: SizeConfig.heightMultiplier * 0.6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${controller.mainController.dateTme.value.day} | ${controller.mainController.dateTme.value.month} | ${controller.mainController.dateTme.value.year}',
                              style: TextStyling.formBlueTextStyle,
                            ),
                            SvgPicture.asset(
                              Images.calendarIcon,
                              color: blueDark,
                              height: SizeConfig.heightMultiplier * 2.5,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Spacer(),
          Container(
            height: SizeConfig.heightMultiplier * 6,
            width: 1.2,
            decoration: BoxDecoration(
                color: blueDark, borderRadius: BorderRadius.circular(4)),
          ),
          Obx(
            () => Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () => controller.toggleShifts(
                    status: controller.mainController.shift.value),
                child: Container(
                  // width: SizeConfig.widthMultiplier * 45,
                  decoration: BoxDecoration(
                    color: controller.mainController.shift.value
                        ? blackLightColorText
                        : textFormColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 3,
                        vertical: SizeConfig.heightMultiplier * 0.6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Shift",
                            style: controller.mainController.shift.value
                                ? TextStyling.buttonMediumWhiteTextStyle
                                : TextStyling.formGreyTextStyle),
                        SizedBox(height: SizeConfig.heightMultiplier * 0.6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.mainController.shift.value
                                  ? 'Night'
                                  : 'Day',
                              style: controller.mainController.shift.value
                                  ? TextStyling.formBlueLightTextStyle
                                  : TextStyling.formBlueTextStyle,
                            ),
                            SvgPicture.asset(
                              controller.mainController.shift.value
                                  ? Images.moonIcon
                                  : Images.sunIcon,
                              color: controller.mainController.shift.value
                                  ? whiteColor
                                  : blueDark,
                              height: SizeConfig.heightMultiplier * 2.5,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _searchAppBar({required BuildContext context}) {
    return Obx(() => controller.isSearching.value
        ? Container(
            height: SizeConfig.heightMultiplier * 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.setIsSearching(
                          status: controller.isSearching.value);

                      controller.searchWorkers(data: '', isEmpty: true);
                    },
                    child: SvgPicture.asset(
                      Images.timesIcon,
                      color: appBarColorText,
                      width: SizeConfig.widthMultiplier * 4,
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
                ],
              ),
            ),
          )
        : Container());
  }

  appBarAttendance({required String text, required BuildContext context}) {
    return Obx(
      () => controller.selectedWorkerData.isNotEmpty
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (!statusNavigator) {
                      Get.back();
                    }
                  },
                  child: Container(
                    height: SizeConfig.heightMultiplier * 5,
                    width: SizeConfig.widthMultiplier * 12,
                    color: Colors.transparent,
                    child: Center(
                      child: SvgPicture.asset(
                        Images.leftArrowIcon,
                        color: statusNavigator ? blueDark : whiteColor,
                        width: SizeConfig.widthMultiplier * 4,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => _showModelSheetBulkAction(
                      context: context,
                      name: controller.selectedWorkerData.length.toString()),
                  child: Text("Bulk action",
                      style: TextStyling.buttonMediumWhiteBoldTextStyle),
                ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 3,
                ),
                GestureDetector(
                  onTap: () => controller.setIsSearching(
                      status: controller.isSearching.value),
                  child: SvgPicture.asset(
                    Images.searchIcon,
                    color: whiteColor,
                    width: SizeConfig.widthMultiplier * 4,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 3,
                ),
                GestureDetector(
                  onTap: () => _showModelSheetBulkAction(
                      context: context,
                      name: controller.selectedWorkerData.length.toString()),
                  child: Container(
                    height: SizeConfig.heightMultiplier * 5,
                    width: SizeConfig.widthMultiplier * 12,
                    color: Colors.transparent,
                    child: Center(
                      child: SvgPicture.asset(
                        Images.moreIcon,
                        color: whiteColor,
                        height: SizeConfig.widthMultiplier * 3,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (!statusNavigator) {
                      Get.back();
                    }
                  },
                  child: Container(
                    height: SizeConfig.heightMultiplier * 5,
                    width: SizeConfig.widthMultiplier * 12,
                    color: Colors.transparent,
                    child: Center(
                      child: SvgPicture.asset(
                        Images.leftArrowIcon,
                        color: statusNavigator ? blueDark : whiteColor,
                        // width: SizeConfig.widthMultiplier * 2,
                      ),
                    ),
                  ),
                ),
                Text(text, style: TextStyling.nameWhiteProfileTextStyle),
                GestureDetector(
                  onTap: () => controller.setIsSearching(
                      status: controller.isSearching.value),
                  child: Container(
                    height: SizeConfig.heightMultiplier * 5,
                    width: SizeConfig.widthMultiplier * 12,
                    color: Colors.transparent,
                    child: Center(
                      child: SvgPicture.asset(
                        Images.searchIcon,
                        color: whiteColor,
                        // width: SizeConfig.widthMultiplier * 4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  _ratingBar({required int meanScore}) {
    return RatingBar(
      ignoreGestures: true,
      onRatingUpdate: (value) {},
      // initialRating: 0.0,
      initialRating:
          double.parse(getAssessmentRank(meanScore: meanScore).toString()),
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 3,
      itemSize: 14,
      ratingWidget: RatingWidget(
          full: Icon(
            Icons.star,
            color: orangeLightColor,
            // size: SizeConfig.imageSizeMultiplier * 0.5,
          ),
          half: Icon(
            Icons.star,
            color: greyLightColor,
            // size: SizeConfig.imageSizeMultiplier * 0.5,
          ),
          empty: Icon(
            Icons.star,
            color: greyLightColor,
            // size: SizeConfig.imageSizeMultiplier * 0.5,
          )),
      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
    );
  }
}
