// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, unused_element, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:fixa/fixa_main_routes.dart';
import 'package:intl/intl.dart';

class TabBarCategories extends SliverPersistentHeaderDelegate {
  // final ValueChanged<int> onChanged;
  // final int selectedIndex;

  // TabBarCategories({required this.onChanged, required this.selectedIndex});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        height: SizeConfig.heightMultiplier * 8, child: HomeTabBar());
  }

  @override
  double get maxExtent => SizeConfig.heightMultiplier * 8;

  @override
  double get minExtent => SizeConfig.heightMultiplier * 8;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class HomeWorkerProfile extends GetWidget<WorkerProfileController> {
  final Project project;
  final int assignedWorkerId;
  final int workerId;
  final String workerName;
  const HomeWorkerProfile(
      {Key? key,
      required this.project,
      required this.workerId,
      required this.workerName,
      required this.assignedWorkerId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
          init: WorkerProfileController(),
          initState: (_) => controller.getWorkerProfileInfo(
              workerId: workerId,
              workerProjectId: project.projectId!,
              assignedWorkerId: assignedWorkerId),
          builder: (cons) {
            return controller.isLoading
                ? CustomScrollView(
                    slivers: [
                      _appBar(),
                      SliverToBoxAdapter(
                        child: lottieLoading(sizeConfigHeight: 16),
                      ),
                    ],
                  )
                : CustomScrollView(
                    slivers: [
                      _appBar(),
                      SliverToBoxAdapter(
                        child: _workerInfo(),
                      ),
                      SliverPersistentHeader(
                          delegate: TabBarCategories(), pinned: true),
                      // SliverToBoxAdapter(
                      //   child: _tabBar(),
                      // ),

                      SliverToBoxAdapter(
                        child: IndexedStack(
                          children: [
                            controller.selectedTab == 0
                                ? _workerDetailsInfo()
                                : _workHistoryInfo(context: context),
                          ],
                        ),
                      )
                    ],
                  );
          }),
    );
  }

  _tabBar() {
    return HomeTabBar();
  }

  _appBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: SizeConfig.heightMultiplier * 2,
      leading: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
        child: GestureDetector(
          onTap: () => Get.back(),
          child: SvgPicture.asset(Images.leftArrowIcon, color: appBarColorText),
        ),
      ),
      title: Text(workerName, style: TextStyling.nameProfileTextStyle),
    );
  }

  _workerInfo() {
    return Obx(
      () => Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  maxRadius: SizeConfig.widthMultiplier * 8,
                  minRadius: SizeConfig.widthMultiplier * 8,
                  backgroundColor: textFormColor,
                  child: Center(
                    child: Text(
                      "${checkForStringNull(controller.workerProfile.value.workerInformation!.worker![0].firstName, "no name")[0].toString().toUpperCase()}${checkForStringNull(controller.workerProfile.value.workerInformation!.worker![0].lastName, "no name")[0].toString().toUpperCase()}",
                      style: TextStyling.formBlueTextStyle,
                    ),
                  ),
                  // backgroundImage: AssetImage(Images.workerImg),
                ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 4,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 60,
                          child: Text(
                            "${nameCapitalised(controller.workerProfile.value.workerInformation!.worker![0].firstName)} ${nameCapitalised(controller.workerProfile.value.workerInformation!.worker![0].lastName)}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyling.nameProfileTextStyle,
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 2,
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller
                                            .workerProfile
                                            .value
                                            .workerInformation!
                                            .verification!
                                            .workerIsVerified ==
                                        null ||
                                    controller
                                            .workerProfile
                                            .value
                                            .workerInformation!
                                            .verification!
                                            .workerIsVerified ==
                                        false
                                ? whiteColor
                                : blueColorText,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgPicture.asset(
                              Images.selectIcon,
                              height: 12,
                              width: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    controller.workerProfile.value.workerDetails == null
                        ? Text("---", style: TextStyling.normalTextStyle)
                        : Text(
                            "${controller.workerProfile.value.workerInformation!.worker![0].phoneNumber!}",
                            style: TextStyling.normalTextStyle),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    Container(
                      height: SizeConfig.heightMultiplier * 7,
                      // width: controller.workerProfile.value.workerInformation!
                      //             .workerRates!.all!.length ==
                      //         1
                      //     ? SizeConfig.widthMultiplier * 25
                      //     : SizeConfig.widthMultiplier * 55,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        border: Border.all(color: lightBlueGreyColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.widthMultiplier * 1.3,
                              vertical: SizeConfig.heightMultiplier * 0.3),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: SizeConfig.widthMultiplier * 1.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: textFormColor,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.widthMultiplier * 1.5,
                                        vertical:
                                            SizeConfig.heightMultiplier * 0.3),
                                    child: Text(
                                      "${controller.workerProfile.value.workerInformation!.workerRates!.current!.serviceName}",
                                      style: TextStyling.blueSmallTextStyle,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 0.5),
                                Text(
                                    "${controller.workerProfile.value.workerInformation!.workerRates!.current!.value} Rwf")
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: SizeConfig.heightMultiplier * 2.5,
                          // width: SizeConfig.widthMultiplier * 14,
                          decoration: BoxDecoration(
                            color: controller
                                            .workerProfile
                                            .value
                                            .workerInformation!
                                            .verification!
                                            .isWorkerActive ==
                                        null ||
                                    controller
                                            .workerProfile
                                            .value
                                            .workerInformation!
                                            .verification!
                                            .isWorkerActive ==
                                        false
                                ? redDark
                                : greyGreenColorText,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 1.5),
                            child: controller
                                            .workerProfile
                                            .value
                                            .workerInformation!
                                            .verification!
                                            .isWorkerActive ==
                                        null ||
                                    controller
                                            .workerProfile
                                            .value
                                            .workerInformation!
                                            .verification!
                                            .isWorkerActive ==
                                        false
                                ? Center(
                                    child: Text(
                                    "Inactive",
                                    style: TextStyling.smallWhiteTextStyle,
                                  ))
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: greenColorText,
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier * 2,
                                      ),
                                      Text(
                                        "Active",
                                        style: TextStyling.smallTextStyle,
                                      )
                                    ],
                                  ),
                          ),
                        ),
                        SizedBox(width: SizeConfig.widthMultiplier * 4),
                        Text(
                          "L1 Rating",
                          style: TextStyling.formGreyyTextStyle,
                        ),
                        SizedBox(width: SizeConfig.widthMultiplier * 2),
                        _ratingBar(
                            assessmentsResults: controller.workerProfile.value
                                .workerInformation!.assessments!),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    Text(
                        "ID Number: ${controller.workerProfile.value.workerInformation!.worker![0].nidNumber}",
                        style: TextStyling.normalTextStyle),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
            Container(
              // height: SizeConfig.heightMultiplier * 6,
              decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(color: lightBlueGreyColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 4,
                    vertical: SizeConfig.heightMultiplier * 0.6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 1.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Date Onboarded",
                              style: TextStyling.formBgGreyTextStyle),
                          SizedBox(height: SizeConfig.heightMultiplier * 0.5),
                          Obx(() => controller.workerProfile.value
                                          .workerInformation ==
                                      null ||
                                  controller.workerProfile.value
                                          .workerInformation!.dateOnboarded ==
                                      null
                              ? Text(
                                  "--",
                                  style: TextStyling.nameProfileTextStyle,
                                )
                              : Text(
                                  parsingToDate(controller.workerProfile.value
                                      .workerInformation!.dateOnboarded),
                                  // "${controller.workerProfile.value.workerInformation!.dateOnboarded}",
                                  style: TextStyling.nameProfileTextStyle,
                                ))
                        ],
                      ),
                    ),
                    Container(
                      height: SizeConfig.heightMultiplier * 5,
                      width: 0.5,
                      decoration: BoxDecoration(
                          color: lightBlueGreyColor,
                          borderRadius: BorderRadius.circular(3)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Last attendance",
                            style: TextStyling.formBgGreyTextStyle),
                        SizedBox(height: SizeConfig.heightMultiplier * 0.5),
                        Obx(() =>
                            controller.workerProfile.value.workerInformation ==
                                        null ||
                                    controller
                                            .workerProfile
                                            .value
                                            .workerInformation!
                                            .lastAttendance ==
                                        null
                                ? Text(
                                    "--",
                                    style: TextStyling.nameProfileTextStyle,
                                  )
                                : Text(
                                    parsingToDate(controller.workerProfile.value
                                        .workerInformation!.lastAttendance),
                                    // "${controller.workerProfile.value.workerInformation!.lastAttendance}",
                                    style: TextStyling.nameProfileTextStyle,
                                  ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      if (controller.workerProfile.value.workerInformation!
                              .assessments!.isEmpty ||
                          controller.workerProfile.value.workerInformation!
                                  .assessments !=
                              null) {
                        Get.toNamed(RouteLinks.homeWorkerAssessment,
                            arguments: {
                              "status": false,
                              "assignedWorkerId": assignedWorkerId,
                              "workerFullName":
                                  '${controller.workerProfile.value.workerInformation!.worker![0].firstName} ${controller.workerProfile.value.workerInformation!.worker![0].lastName}',
                              'project_id': project.projectId,
                              'service_id': controller.workerProfile.value
                                  .workerInformation!.services!.last.serviceId,
                              "worker_id": workerId,
                            });
                        // _showModelSheetALevels(
                        //     context: context, services: controller.levels);
                      } else {
                        warningMessage(message: "worker already assessed");
                      }
                    },
                    child: buttonSupplements(
                        iconName: Images.starrIcon,
                        text: "Assess Worker",
                        status: false)),
                GestureDetector(
                    onTap: () {
                      if (controller.workerProfile.value.workerDetails !=
                          null) {
                        Get.toNamed(RouteLinks.homeEditWorkerProfile,
                            arguments: {
                              "worker_id": workerId,
                              "assign_worker_id": assignedWorkerId,
                              "first_name": controller.workerProfile.value
                                  .workerInformation!.worker![0].firstName,
                              "district_name": controller.workerProfile.value
                                  .workerInformation!.worker![0].district,
                              "last_name": controller.workerProfile.value
                                  .workerInformation!.worker![0].lastName,
                              "rssb_code": controller.workerProfile.value
                                  .workerInformation!.worker![0].rssbCode,
                              "id_number": controller.workerProfile.value
                                  .workerInformation!.worker![0].nidNumber,
                              "phone_number": controller.workerProfile.value
                                  .workerInformation!.worker![0].phoneNumber,
                              "current_rate": (controller.workerProfile.value
                                              .workerInformation!.workerRates !=
                                          null ||
                                      controller
                                              .workerProfile
                                              .value
                                              .workerInformation!
                                              .workerRates!
                                              .current !=
                                          null)
                                  ? controller
                                      .workerProfile
                                      .value
                                      .workerInformation!
                                      .workerRates!
                                      .current!
                                      .value
                                      .toString()
                                  : "0",
                              "gender": controller.workerProfile.value
                                      .workerInformation!.worker![0].gender ??
                                  "male",
                              "current_service": (controller.workerProfile.value
                                              .workerInformation!.workerRates !=
                                          null ||
                                      controller
                                              .workerProfile
                                              .value
                                              .workerInformation!
                                              .workerRates!
                                              .current !=
                                          null)
                                  ? controller
                                      .workerProfile
                                      .value
                                      .workerInformation!
                                      .workerRates!
                                      .current!
                                      .serviceName
                                  : "no service",
                              "project": project,
                              "worker_rates": controller.workerProfile.value
                                  .workerInformation!.workerRates!.all,
                            });
                      }
                    },
                    child: buttonSupplements(
                        iconName: Images.penIcon,
                        text: "Edit worker",
                        status: false)),
              ],
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
          ],
        ),
      ),
    );
  }

  _ratingBar({required List<AssessmentResult> assessmentsResults}) {
    return RatingBar(
      ignoreGestures: true,
      onRatingUpdate: (value) {},
      initialRating: double.parse(
          getRankProfile(assessmentsResults: assessmentsResults).toString()),
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
            color: greyBlackColorText,
            // size: SizeConfig.imageSizeMultiplier * 0.5,
          ),
          empty: Icon(
            Icons.star,
            color: greyBlackColorText,
            // size: SizeConfig.imageSizeMultiplier * 0.5,
          )),
      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
    );
  }

  buttonSupplements(
      {required String iconName, required String text, required bool status}) {
    return Container(
      height: SizeConfig.heightMultiplier * 4,
      // width: SizeConfig.widthMultiplier * 40,
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: blueDark),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 1.3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(iconName,
                height: SizeConfig.heightMultiplier * 2,
                color: status ? redColor : blueDark),
            SizedBox(width: SizeConfig.widthMultiplier * 3),
            Text(text,
                style: status
                    ? TextStyling.redTextStyle
                    : TextStyling.blueTextStyle)
          ],
        ),
      ),
    );
  }

  _workHistoryInfo({required BuildContext context}) {
    return Container(
        color: lightgreyBlueGreyColor,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 4),
                child: GestureDetector(
                    onTap: () =>
                        _showBottomSheetPayrollPeriod(context: context),
                    child: _appShiftDate()),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 4),
                child: _appWorkerInfo(
                    context: context,
                    workerName:
                        "${controller.workerProfile.value.workerInformation!.worker![0].firstName} ${controller.workerProfile.value.workerInformation!.worker![0].lastName}"),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      topLeft: Radius.circular(24),
                    ),
                  ),
                  child: Obx(
                    () => controller.workerHistories.value.statistics == null
                        ? Container()
                        : controller.isgettingWorkerHistory.value
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.widthMultiplier * 4),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: controller
                                        .workerHistories.value.history!.length,
                                    itemBuilder: (context, index) {
                                      var date = DateTime.parse(controller
                                          .workerHistories
                                          .value
                                          .history![index]
                                          .date!);
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: textFormBorderColor)),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            right:
                                                SizeConfig.widthMultiplier * 4,
                                            left:
                                                SizeConfig.widthMultiplier * 4,
                                            bottom:
                                                SizeConfig.heightMultiplier *
                                                    1.2,
                                            top:
                                                SizeConfig.heightMultiplier * 2,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      "${date.day} | ${date.month} | ${date.year} ",
                                                      style: TextStyling
                                                          .formBgGreyTextStyle),
                                                  Container(
                                                    width: 2,
                                                    height: SizeConfig
                                                            .heightMultiplier *
                                                        2,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            textFormBorderColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                  ),
                                                  Text(nameCapitalised(
                                                          controller
                                                              .workerHistories
                                                              .value
                                                              .history![index]
                                                              .service!
                                                              .name)),

                                                      Text(
                                                        nameCapitalised(
                                                            controller
                                                                .workerHistories
                                                                .value
                                                                .history![index]
                                                                .shift!
                                                                .name),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Text(
                                                        "${currencyFormat(price: double.parse(controller.workerHistories.value.history![index].dailyEarnings.toString()))} Rwf",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),

                                                ],
                                              ),
               
                                              SizedBox(
                                                  height: SizeConfig
                                                          .heightMultiplier *
                                                      0.5),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                        "${nameCapitalised(controller.workerHistories.value.history![index].supervisor!.name)} , "),
                                                    Text(nameCapitalised(
                                                        controller
                                                            .workerHistories
                                                            .value
                                                            .history![index]
                                                            .project!
                                                            .name)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _workerDetailsInfo() {
    return Obx(
      () => Container(
        color: lightgreyBlueGreyColor,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Personal Details",
                      style: TextStyling.nameProfileTextStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoDetails(
                              text1: "First Name",
                              text2:
                                  "${nameCapitalised(controller.workerProfile.value.workerInformation!.worker![0].firstName)}"),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          _infoDetails(
                              text1: "Gender",
                              text2: controller.workerProfile.value
                                          .workerDetails!.worker![0].gender ==
                                      null
                                  ? "-"
                                  : nameCapitalised(controller.workerProfile
                                      .value.workerDetails!.worker![0].gender)),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          _infoDetails(
                              text1: "RSSB Code",
                              text2: controller.workerProfile.value
                                          .workerDetails!.worker![0].rssbCode ==
                                      null
                                  ? "-"
                                  : nameCapitalised(controller
                                      .workerProfile
                                      .value
                                      .workerDetails!
                                      .worker![0]
                                      .rssbCode)),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoDetails(
                              text1: "Last Name",
                              text2:
                                  "${nameCapitalised(controller.workerProfile.value.workerInformation!.worker![0].lastName)}"),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          _infoDetails(
                              text1: "Date of Birth",
                              text2: setDateOfBirth(
                                controller.workerProfile.value.workerDetails!
                                    .worker![0].dateOfBirth,
                              )),
                        ]),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 4,
                ),
                Text(
                  "Contact Details",
                  style: TextStyling.nameProfileTextStyle,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                _infoDetails(
                    text1: "Address",
                    text2:
                        "${checkForStringNull(controller.workerProfile.value.workerDetails!.worker![0].district, '-')}, ${checkForStringNull(controller.workerProfile.value.workerDetails!.worker![0].province, '-')}"),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                Divider(
                  thickness: 0.8,
                  color: appBarColorText,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 4,
                ),
                Text(
                  "Certificates",
                  style: TextStyling.nameProfileTextStyle,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller
                      .workerProfile.value.workerDetails!.certificates!.length,
                  itemBuilder: (context, index) {
                    var certificate = controller.workerProfile.value
                        .workerDetails!.certificates![index];
                    return _certificatesDetails(
                        certifcateName: "${certificate.field}",
                        certifcateDetails: "${certificate.level}",
                        certifcateStart:
                            "${DateFormat('yyyy-MM-dd').format(DateTime.parse(certificate.startDate!))}",
                        certifcateEnd:
                            "${DateFormat('yyyy-MM-dd').format(DateTime.parse(certificate.endDate!))}");
                  },
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _certificatesDetails(
      {required String certifcateName,
      required String certifcateDetails,
      required String certifcateStart,
      required String certifcateEnd}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          certifcateName,
          style: TextStyling.nameProfileGreyTextStyle,
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 1.2,
        ),
        Text(
          certifcateDetails,
          style: TextStyling.normalTextStyle,
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 1.2,
        ),
        Text(
          "$certifcateStart - $certifcateEnd",
          style: TextStyling.greyTextStyle,
        ),
      ],
    );
  }

  _infoDetails({required String text1, required String text2}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: TextStyling.greyTextStyle,
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 1.2,
        ),
        Text(
          text2,
          style: TextStyling.nameProfileGreyTextStyle,
        ),
      ],
    );
  }

  _infoAttendance({required String text1, required String text2}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: TextStyling.nameProfileGreyTextStyle,
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 1.2,
        ),
        Text(
          text2,
          style: TextStyling.greyTextStyle,
        ),
      ],
    );
  }

  _appShiftDate() {
    return Obx(
      () => Container(
        height: SizeConfig.heightMultiplier * 8,
        width: double.infinity,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: textFormBorderColor)),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Time period", style: TextStyling.formGreyTextStyle),
                  SizedBox(height: SizeConfig.heightMultiplier * 0.6),
                  Text(
                    controller.dataPayroll.value.dateStart.isEmpty
                        ? "-"
                        : '${getDate(date: controller.dataPayroll.value.dateStart)} - ${getDate(date: controller.dataPayroll.value.dateEnd)}',
                    style: TextStyling.formBlueTextStyle,
                  )
                ],
              ),
              SvgPicture.asset(
                Images.arrowDownIcon,
                color: blueColorText,
                height: SizeConfig.heightMultiplier * 1.5,
              )
            ],
          ),
        ),
      ),
    );
  }

  _showBottomSheetPayrollPeriod({required BuildContext context}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Obx(
            () => Padding(
              padding: const EdgeInsets.all(16.0),
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
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Center(
                    child: Text("Select Date",
                        style: TextStyling.formGreyTextStyle),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (controller.selectedCurrentPayrollIndex.value >
                              1) {
                            controller.getNextPayroll(
                                currentPayrollIndex: controller
                                        .selectedCurrentPayrollIndex.value -
                                    2);
                          } else {
                            controller.changeYear(
                                currentPayrollIndex: controller
                                    .selectedCurrentPayrollIndex.value,
                                yearr: DateTime.parse(controller
                                            .dataPayroll.value.dateStart)
                                        .year -
                                    1);
                          }
                        },
                        child: Container(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Images.backIcon,
                                color: textFormBorderColor,
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 0.1,
                              ),
                              SvgPicture.asset(
                                Images.backIcon,
                                color: textFormBorderColor,
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 3,
                              ),
                              SvgPicture.asset(
                                Images.backIcon,
                                color: textFormBorderColor,
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "${DateFormat('MMMM').format(DateTime.parse(controller.dataPayroll.value.dateStart))} - ${DateTime.parse(controller.dataPayroll.value.dateStart).year}",
                        style: TextStyling.normalBoldTextStyle,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (controller.selectedCurrentPayrollIndex.value <
                              22) {
                            controller.getNextPayroll(
                                currentPayrollIndex: controller
                                        .selectedCurrentPayrollIndex.value +
                                    2);
                          } else {
                            controller.changeYear(
                                currentPayrollIndex: controller
                                    .selectedCurrentPayrollIndex.value,
                                yearr: DateTime.parse(controller
                                            .dataPayroll.value.dateStart)
                                        .year +
                                    1);
                          }
                        },
                        child: Container(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Images.arrorwRight,
                                color: textFormBorderColor,
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 3,
                              ),
                              SvgPicture.asset(
                                Images.arrorwRight,
                                color: textFormBorderColor,
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 0.1,
                              ),
                              SvgPicture.asset(
                                Images.arrorwRight,
                                color: textFormBorderColor,
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                  Divider(
                    thickness: 0.5,
                    color: textFormBorderColor,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setPayrollTimeFrame(
                          workerId: workerId,
                          timeFrame: controller
                              .payrollFrames[controller.firstDateIndex.value]);
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        '${getDate(date: controller.payrollFrames[controller.firstDateIndex.value].dateStart)} - ${getDate(date: controller.payrollFrames[controller.firstDateIndex.value].dateEnd)}',
                        // '${controller.dataPayrolls[controller.selectedCurrentPayrollIndex.value]["payrolls"][0]["start-date"].toString().replaceAll('-', ' | ')} - ${controller.dataPayrolls[controller.selectedCurrentPayrollIndex.value]["payrolls"][0]["end-date"].toString().replaceAll('-', ' | ')}',
                        style: TextStyling.formBlueTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                  Divider(
                    thickness: 0.5,
                    color: textFormBorderColor,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setPayrollTimeFrame(
                          workerId: workerId,
                          timeFrame: controller
                              .payrollFrames[controller.lastDateIndex.value]);
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        '${getDate(date: controller.payrollFrames[controller.lastDateIndex.value].dateStart)} - ${getDate(date: controller.payrollFrames[controller.lastDateIndex.value].dateEnd)}',
                        // '${controller.dataPayrolls[controller.selectedCurrentPayrollIndex.value]["payrolls"][1]["start-date"].toString().replaceAll('-', ' | ')} - ${controller.dataPayrolls[controller.selectedCurrentPayrollIndex.value]["payrolls"][1]["end-date"].toString().replaceAll('-', ' | ')}',
                        style: TextStyling.formBlueTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                  Divider(
                    thickness: 0.5,
                    color: textFormBorderColor,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.payrollFrames.value = [];
                      controller.getPayrollRange(datePayrll: DateTime.now());
                      controller.getWorkerHistory(
                          workerId: workerId,
                          timeFrame: controller.dataPayroll.value);
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
                        "Jump to current payroll",
                        style: TextStyling.buttonTextStyle,
                      )),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                ],
              ),
            ),
          );
        });
  }

  _appWorkerInfo({required String workerName, required BuildContext context}) {
    return Obx(
      () => Container(
        // height: SizeConfig.heightMultiplier * 8,
        width: double.infinity,
        decoration: BoxDecoration(
          color: textFormColor,
          borderRadius: BorderRadius.circular(12),
          // border: Border.all(color: textFormBorderColor)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier * 4,
              vertical: SizeConfig.heightMultiplier * 1.2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("$workerName",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyling.blueTextStyle),
                    Text(
                        controller.workerHistories.value.statistics == null
                            ? "Total: 0 Rwf"
                            : "Total: ${controller.workerHistories.value.statistics!.totalEarnings} Rwf",
                        style: TextStyling.blueTextStyle),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        controller.workerHistories.value.statistics == null
                            ? "Day: 0 days, 0 Rwf"
                            : getSingleWorkerPayrollShiftSum(
                                isDay: true,
                                workerHistories:
                                    controller.workerHistories.value.history!),
                        style: TextStyling.blueSmallTextStyle),
                    Text(
                        controller.workerHistories.value.statistics == null
                            ? "Night: 0 days, 0 Rwf"
                            : getSingleWorkerPayrollShiftSum(
                                isDay: false,
                                workerHistories:
                                    controller.workerHistories.value.history!),
                        style: TextStyling.blueSmallTextStyle),
                    GestureDetector(
                      // onTap: () => _showModalDeductions(context: context),
                      child: Row(
                        children: [
                          Text(
                            controller.workerHistories.value.statistics == null
                                ? "Deduction: 0 Rwf"
                                : "Deduction ${controller.workerHistories.value.statistics!.totalDeduction} Rwf",
                            style: TextStyling.redSmallTextStyle,
                          ),
                          SizedBox(width: SizeConfig.widthMultiplier * 1.3),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeTabBar extends GetWidget<WorkerProfileController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: SizeConfig.heightMultiplier * 6,
      color: lightgreyBlueGreyColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 4,
            vertical: SizeConfig.heightMultiplier * 1.5),
        child: Container(
          height: SizeConfig.heightMultiplier * 6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: lightGreyColor
              // border: Border(bottom: BorderSide(color: lightBlueGreyColor))
              ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                // horizontal: SizeConfig.widthMultiplier * 0.4,
                vertical: SizeConfig.heightMultiplier * 0.3),
            child: TabBar(
                controller: controller.tabController!,
                unselectedLabelStyle: TextStyling.tabUnSelectedTextStyle,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: whiteColor),
                onTap: (index) {
                  controller.changeTabIndex(indexTab: index);
                },
                tabs: List<Widget>.generate(
                    controller.tabs.length,
                    (index) => Tab(
                          child: Container(
                            width: SizeConfig.widthMultiplier * 60,
                            child: Center(
                              child: Text(controller.tabs[index]["tab_name"],
                                  style:
                                      controller.tabs[index]["tab_id"] == index
                                          ? TextStyling.tabSelectedTextStyle
                                          : TextStyling.tabUnSelectedTextStyle),
                            ),
                          ),
                        ))),
          ),
        ),
      ),
    );
  }
}

class HomeWorkerProfileTest extends GetWidget<WorkerProfileController> {
  final Project project;
  final int assignedWorkerId;
  final int workerId;
  HomeWorkerProfileTest(
      {Key? key,
      required this.project,
      required this.workerId,
      required this.assignedWorkerId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
          init: WorkerProfileController(),
          initState: (_) => controller.getWorkerProfileInfo(
              workerId: workerId,
              workerProjectId: project.projectId!,
              assignedWorkerId: assignedWorkerId),
          builder: (cons) {
            return controller.isLoading
                ? lottieLoading(sizeConfigHeight: 16)
                : controller.workerProfile.value.workerDetails == null
                    ? SafeArea(
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.heightMultiplier * 2,
                                left: SizeConfig.widthMultiplier * 8,
                                right: SizeConfig.widthMultiplier * 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: SvgPicture.asset(
                                    Images.leftArrowIcon,
                                    color: appBarColorText,
                                    width: SizeConfig.widthMultiplier * 4,
                                  ),
                                ),
                                Text("",
                                    style: TextStyling.nameProfileTextStyle),
                                SvgPicture.asset(
                                  Images.searchIcon,
                                  color: whiteColor,
                                  width: SizeConfig.widthMultiplier * 4,
                                ),
                              ],
                            )))
                    : SafeArea(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.heightMultiplier * 2),
                          child: DefaultTabController(
                              length: controller.tabs.length,
                              child: NestedScrollView(
                                headerSliverBuilder: (context, value) {
                                  return [
                                    _flexibleHeader(context: context),
                                    SliverPersistentHeader(
                                      pinned: true,
                                      delegate: _HeaderTabBu(
                                          fullName:
                                              "${controller.workerProfile.value.workerInformation!.worker![0].firstName} ${controller.workerProfile.value.workerInformation!.worker![0].lastName}"),
                                    ),
                                    SliverPersistentHeader(
                                      pinned: true,
                                      delegate: _HeaderTab(
                                          tabController:
                                              controller.tabController!,
                                          tabTexts: controller.tabs,
                                          fullName:
                                              "${controller.workerProfile.value.workerInformation!.worker![0].firstName} ${controller.workerProfile.value.workerInformation!.worker![0].lastName}"),
                                    ),
                                  ];
                                },
                                body: TabBarView(
                                    controller: controller.tabController,
                                    children: [
                                      _workerDetailsInfo(),
                                      _workHistoryInfo(context: context),
                                    ]),
                              )),
                          // child: CustomScrollView(
                          //   // ignore: prefer_const_literals_to_create_immutables
                          //   slivers: [
                          //     _flexibleHeader(),
                          //     SliverPersistentHeader(
                          //         pinned: true,
                          //         delegate: _HeaderSilverPresistent(fullName: "hala")),
                          //     SliverPersistentHeader(
                          //       delegate: _HeaderTab(
                          //           tabController: controller.tabController!,
                          //           tabTexts: controller.tabs),
                          //     ),
                          //   SliverList(delegate: SliverChildListDelegate([

                          //   ])),
                          //   ],
                          // ),
                        ),
                      );
          }),
    );
  }

  _ratingBar({required List<AssessmentResult> assessmentsResults}) {
    return RatingBar(
      ignoreGestures: true,
      onRatingUpdate: (value) {},
      initialRating: double.parse(
          getRankProfile(assessmentsResults: assessmentsResults).toString()),
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
            color: greyBlackColorText,
            // size: SizeConfig.imageSizeMultiplier * 0.5,
          ),
          empty: Icon(
            Icons.star,
            color: greyBlackColorText,
            // size: SizeConfig.imageSizeMultiplier * 0.5,
          )),
      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
    );
  }

  _appWorkerInfo({required String workerName, required BuildContext context}) {
    return Obx(
      () => Container(
        // height: SizeConfig.heightMultiplier * 8,
        width: double.infinity,
        decoration: BoxDecoration(
          color: textFormColor,
          borderRadius: BorderRadius.circular(12),
          // border: Border.all(color: textFormBorderColor)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier * 4,
              vertical: SizeConfig.heightMultiplier * 1.2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("$workerName",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyling.blueTextStyle),
                    Text(
                        controller.workerHistories.value.statistics == null
                            ? "Total: 0 Rwf"
                            : "Total: ${controller.workerHistories.value.statistics!.totalEarnings} Rwf",
                        style: TextStyling.blueTextStyle),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        controller.workerHistories.value.statistics == null
                            ? "Day: 0 days, 0 Rwf"
                            : getSingleWorkerPayrollShiftSum(
                                isDay: true,
                                workerHistories:
                                    controller.workerHistories.value.history!),
                        style: TextStyling.blueSmallTextStyle),
                    Text(
                        controller.workerHistories.value.statistics == null
                            ? "Night: 0 days, 0 Rwf"
                            : getSingleWorkerPayrollShiftSum(
                                isDay: false,
                                workerHistories:
                                    controller.workerHistories.value.history!),
                        style: TextStyling.blueSmallTextStyle),
                    GestureDetector(
                      // onTap: () => _showModalDeductions(context: context),
                      child: Row(
                        children: [
                          Text(
                            controller.workerHistories.value.statistics == null
                                ? "Deduction: 0 Rwf"
                                : "Deduction ${controller.workerHistories.value.statistics!.totalDeduction} Rwf",
                            style: TextStyling.redSmallTextStyle,
                          ),
                          SizedBox(width: SizeConfig.widthMultiplier * 1.3),
                          // Container(
                          //     height: 20,
                          //     width: 20,
                          //     decoration: BoxDecoration(
                          //         border: Border.all(color: orangeLightDark),
                          //         borderRadius: BorderRadius.circular(4)),
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(1.5),
                          //       child: SvgPicture.asset(Images.penIcon,
                          //           height: 15,
                          //           width: 15,
                          //           color: orangeLightDark),
                          //     )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _appBar({required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: SvgPicture.asset(
            Images.leftArrowIcon,
            color: appBarColorText,
            width: SizeConfig.widthMultiplier * 4,
          ),
        ),
        Text(text, style: TextStyling.nameProfileTextStyle),
        SvgPicture.asset(
          Images.searchIcon,
          color: whiteColor,
          width: SizeConfig.widthMultiplier * 4,
        ),
      ],
    );
  }

  _appShiftDate() {
    return Obx(
      () => Container(
        height: SizeConfig.heightMultiplier * 8,
        width: double.infinity,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: textFormBorderColor)),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Time period", style: TextStyling.formGreyTextStyle),
                  SizedBox(height: SizeConfig.heightMultiplier * 0.6),
                  Text(
                    controller.dataPayroll.value.dateStart.isEmpty
                        ? "-"
                        : '${getDate(date: controller.dataPayroll.value.dateStart)} - ${getDate(date: controller.dataPayroll.value.dateEnd)}',
                    style: TextStyling.formBlueTextStyle,
                  )
                ],
              ),
              SvgPicture.asset(
                Images.arrowDownIcon,
                color: blueColorText,
                height: SizeConfig.heightMultiplier * 1.5,
              )
            ],
          ),
        ),
      ),
    );
  }

  _showBottomSheetPayrollPeriod({required BuildContext context}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Obx(
            () => Padding(
              padding: const EdgeInsets.all(16.0),
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
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Center(
                    child: Text("Select Date",
                        style: TextStyling.formGreyTextStyle),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (controller.selectedCurrentPayrollIndex.value >
                              1) {
                            controller.getNextPayroll(
                                currentPayrollIndex: controller
                                        .selectedCurrentPayrollIndex.value -
                                    2);
                          }
                        },
                        child: Container(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Images.backIcon,
                                color: textFormBorderColor,
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 0.1,
                              ),
                              SvgPicture.asset(
                                Images.backIcon,
                                color: textFormBorderColor,
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 3,
                              ),
                              SvgPicture.asset(
                                Images.backIcon,
                                color: textFormBorderColor,
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "${DateFormat('MMMM').format(DateTime.parse(controller.dataPayroll.value.dateStart))} - ${DateTime.now().year}",
                        style: TextStyling.normalBoldTextStyle,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (controller.selectedCurrentPayrollIndex.value <
                              22) {
                            controller.getNextPayroll(
                                currentPayrollIndex: controller
                                        .selectedCurrentPayrollIndex.value +
                                    2);
                          }
                        },
                        child: Container(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Images.arrorwRight,
                                color: textFormBorderColor,
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 3,
                              ),
                              SvgPicture.asset(
                                Images.arrorwRight,
                                color: textFormBorderColor,
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 0.1,
                              ),
                              SvgPicture.asset(
                                Images.arrorwRight,
                                color: textFormBorderColor,
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                  Divider(
                    thickness: 0.5,
                    color: textFormBorderColor,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setPayrollTimeFrame(
                          workerId: workerId,
                          timeFrame: controller
                              .payrollFrames[controller.firstDateIndex.value]);
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        '${getDate(date: controller.payrollFrames[controller.firstDateIndex.value].dateStart)} - ${getDate(date: controller.payrollFrames[controller.firstDateIndex.value].dateEnd)}',
                        // '${controller.dataPayrolls[controller.selectedCurrentPayrollIndex.value]["payrolls"][0]["start-date"].toString().replaceAll('-', ' | ')} - ${controller.dataPayrolls[controller.selectedCurrentPayrollIndex.value]["payrolls"][0]["end-date"].toString().replaceAll('-', ' | ')}',
                        style: TextStyling.formBlueTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                  Divider(
                    thickness: 0.5,
                    color: textFormBorderColor,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setPayrollTimeFrame(
                          workerId: workerId,
                          timeFrame: controller
                              .payrollFrames[controller.lastDateIndex.value]);
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        '${getDate(date: controller.payrollFrames[controller.lastDateIndex.value].dateStart)} - ${getDate(date: controller.payrollFrames[controller.lastDateIndex.value].dateEnd)}',
                        // '${controller.dataPayrolls[controller.selectedCurrentPayrollIndex.value]["payrolls"][1]["start-date"].toString().replaceAll('-', ' | ')} - ${controller.dataPayrolls[controller.selectedCurrentPayrollIndex.value]["payrolls"][1]["end-date"].toString().replaceAll('-', ' | ')}',
                        style: TextStyling.formBlueTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                  Divider(
                    thickness: 0.5,
                    color: textFormBorderColor,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.payrollFrames.value = [];
                      controller.getPayrollRange(datePayrll: DateTime.now());
                      controller.getWorkerHistory(
                          workerId: workerId,
                          timeFrame: controller.dataPayroll.value);
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
                        "Jump to current payroll",
                        style: TextStyling.buttonTextStyle,
                      )),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                ],
              ),
            ),
          );
        });
  }

  _workHistoryInfo({required BuildContext context}) {
    return Container(
        color: lightgreyBlueGreyColor,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 4),
                child: GestureDetector(
                    onTap: () =>
                        _showBottomSheetPayrollPeriod(context: context),
                    child: _appShiftDate()),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 4),
                child: _appWorkerInfo(
                    context: context,
                    workerName:
                        "${controller.workerProfile.value.workerInformation!.worker![0].firstName} ${controller.workerProfile.value.workerInformation!.worker![0].lastName}"),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      topLeft: Radius.circular(24),
                    ),
                  ),
                  child: Obx(
                    () => controller.workerHistories.value.statistics == null
                        ? Container()
                        : controller.isgettingWorkerHistory.value
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.widthMultiplier * 4),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: controller
                                        .workerHistories.value.history!.length,
                                    itemBuilder: (context, index) {
                                      var date = DateTime.parse(controller
                                          .workerHistories
                                          .value
                                          .history![index]
                                          .date!);
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: textFormBorderColor)),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            right:
                                                SizeConfig.widthMultiplier * 4,
                                            left:
                                                SizeConfig.widthMultiplier * 4,
                                            bottom:
                                                SizeConfig.heightMultiplier *
                                                    1.2,
                                            top:
                                                SizeConfig.heightMultiplier * 2,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                      "${date.day} | ${date.month} | ${date.year} ",
                                                      style: TextStyling
                                                          .formBgGreyTextStyle),
                                                  // SizedBox(
                                                  //   width: SizeConfig.widthMultiplier * 4,
                                                  // ),
                                                  Container(
                                                    width: 2,
                                                    height: SizeConfig
                                                            .heightMultiplier *
                                                        2,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            textFormBorderColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                  ),
                                                  // SizedBox(
                                                  //   width: SizeConfig.widthMultiplier * 4,
                                                  // ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(nameCapitalised(
                                                          controller
                                                              .workerHistories
                                                              .value
                                                              .history![index]
                                                              .service!
                                                              .name)),
                                                      SizedBox(
                                                        width: SizeConfig
                                                                .widthMultiplier *
                                                            3,
                                                      ),
                                                      Text(nameCapitalised(
                                                          controller
                                                              .workerHistories
                                                              .value
                                                              .history![index]
                                                              .shift!
                                                              .name)),
                                                      SizedBox(
                                                        width: SizeConfig
                                                                .widthMultiplier *
                                                            3,
                                                      ),
                                                      Text(
                                                          "${currencyFormat(price: double.parse(controller.workerHistories.value.history![index].dailyEarnings.toString()))} Rwf"),
                                                    ],
                                                  )
                                                  // Expanded(
                                                  //     flex: 3,
                                                  //     child: ListView.builder(
                                                  //         shrinkWrap: true,
                                                  //         physics:
                                                  //             NeverScrollableScrollPhysics(),
                                                  //         itemCount: controller
                                                  //             .data[index]["services"].length,
                                                  //         itemBuilder: (context, idex) {
                                                  //           return Row(
                                                  //             crossAxisAlignment:
                                                  //                 CrossAxisAlignment.center,
                                                  //             children: [
                                                  //               Text(controller.data[index]
                                                  //                       ["services"][idex]
                                                  //                   ["service_name"]),
                                                  //               SizedBox(
                                                  //                 width: SizeConfig
                                                  //                         .widthMultiplier *
                                                  //                     3,
                                                  //               ),
                                                  //               Text(controller.data[index]
                                                  //                       ["services"][idex]
                                                  //                   ["shift"]),
                                                  //               SizedBox(
                                                  //                 width: SizeConfig
                                                  //                         .widthMultiplier *
                                                  //                     3,
                                                  //               ),
                                                  //               Text(controller.data[index]
                                                  //                       ["services"][idex]
                                                  //                   ["rate"]),
                                                  //             ],
                                                  //           );
                                                  //         }))
                                                ],
                                              ),
                                              SizedBox(
                                                  height: SizeConfig
                                                          .heightMultiplier *
                                                      0.5),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                        "${nameCapitalised(controller.workerHistories.value.history![index].supervisor!.name)} , "),
                                                    Text(nameCapitalised(
                                                        controller
                                                            .workerHistories
                                                            .value
                                                            .history![index]
                                                            .project!
                                                            .name)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _workerDetailsInfo() {
    return Obx(
      () => Container(
        color: lightgreyBlueGreyColor,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Personal Details",
                      style: TextStyling.nameProfileTextStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoDetails(
                              text1: "First Name",
                              text2:
                                  "${nameCapitalised(controller.workerProfile.value.workerInformation!.worker![0].firstName)}"),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          _infoDetails(
                              text1: "Gender",
                              text2: controller.workerProfile.value
                                          .workerDetails!.worker![0].gender ==
                                      null
                                  ? "-"
                                  : nameCapitalised(controller.workerProfile
                                      .value.workerDetails!.worker![0].gender)),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          _infoDetails(
                              text1: "RSSB Code",
                              text2: controller.workerProfile.value
                                          .workerDetails!.worker![0].rssbCode ==
                                      null
                                  ? "-"
                                  : nameCapitalised(controller
                                      .workerProfile
                                      .value
                                      .workerDetails!
                                      .worker![0]
                                      .rssbCode)),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoDetails(
                              text1: "Last Name",
                              text2:
                                  "${nameCapitalised(controller.workerProfile.value.workerInformation!.worker![0].lastName)}"),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          _infoDetails(
                              text1: "Date of Birth",
                              text2: setDateOfBirth(
                                controller.workerProfile.value.workerDetails!
                                    .worker![0].dateOfBirth,
                              )),
                        ]),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 4,
                ),
                Text(
                  "Contact Details",
                  style: TextStyling.nameProfileTextStyle,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                _infoDetails(
                    text1: "Address",
                    text2:
                        "${checkForStringNull(controller.workerProfile.value.workerDetails!.worker![0].district, '-')}, ${checkForStringNull(controller.workerProfile.value.workerDetails!.worker![0].province, '-')}"),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                Divider(
                  thickness: 0.8,
                  color: appBarColorText,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 4,
                ),
                Text(
                  "Certificates",
                  style: TextStyling.nameProfileTextStyle,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller
                      .workerProfile.value.workerDetails!.certificates!.length,
                  itemBuilder: (context, index) {
                    var certificate = controller.workerProfile.value
                        .workerDetails!.certificates![index];
                    return _certificatesDetails(
                        certifcateName: "${certificate.field}",
                        certifcateDetails: "${certificate.level}",
                        certifcateStart:
                            "${DateFormat('yyyy-MM-dd').format(DateTime.parse(certificate.startDate!))}",
                        certifcateEnd:
                            "${DateFormat('yyyy-MM-dd').format(DateTime.parse(certificate.endDate!))}");
                  },
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _certificatesDetails(
      {required String certifcateName,
      required String certifcateDetails,
      required String certifcateStart,
      required String certifcateEnd}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          certifcateName,
          style: TextStyling.nameProfileGreyTextStyle,
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 1.2,
        ),
        Text(
          certifcateDetails,
          style: TextStyling.normalTextStyle,
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 1.2,
        ),
        Text(
          "$certifcateStart - $certifcateEnd",
          style: TextStyling.greyTextStyle,
        ),
      ],
    );
  }

  _infoDetails({required String text1, required String text2}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: TextStyling.greyTextStyle,
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 1.2,
        ),
        Text(
          text2,
          style: TextStyling.nameProfileGreyTextStyle,
        ),
      ],
    );
  }

  _infoAttendance({required String text1, required String text2}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: TextStyling.nameProfileGreyTextStyle,
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 1.2,
        ),
        Text(
          text2,
          style: TextStyling.greyTextStyle,
        ),
      ],
    );
  }

  _flexibleHeader({required BuildContext context}) {
    return SliverAppBar(
      expandedHeight: SizeConfig.heightMultiplier * 45,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        stretchModes: [StretchMode.zoomBackground],
        background: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _workerInfo(),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              _workerInfoOnboarded(),
              // _workerActions(),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1.5,
              ),
              _workerActionsSupplements(context: context),
            ],
          ),
        ),
      ),
    );
  }

  _workerInfoOnboarded() {
    return Container(
      // height: SizeConfig.heightMultiplier * 6,
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: lightBlueGreyColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 4,
            vertical: SizeConfig.heightMultiplier * 0.6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 1.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Date Onboarded",
                      style: TextStyling.formBgGreyTextStyle),
                  SizedBox(height: SizeConfig.heightMultiplier * 0.5),
                  Obx(() => controller.workerProfile.value.workerInformation ==
                              null ||
                          controller.workerProfile.value.workerInformation!
                                  .dateOnboarded ==
                              null
                      ? Text(
                          "--",
                          style: TextStyling.nameProfileTextStyle,
                        )
                      : Text(
                          parsingToDate(controller.workerProfile.value
                              .workerInformation!.dateOnboarded),
                          // "${controller.workerProfile.value.workerInformation!.dateOnboarded}",
                          style: TextStyling.nameProfileTextStyle,
                        ))
                ],
              ),
            ),
            Container(
              height: SizeConfig.heightMultiplier * 5,
              width: 0.5,
              decoration: BoxDecoration(
                  color: lightBlueGreyColor,
                  borderRadius: BorderRadius.circular(3)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Last attendance", style: TextStyling.formBgGreyTextStyle),
                SizedBox(height: SizeConfig.heightMultiplier * 0.5),
                Obx(() =>
                    controller.workerProfile.value.workerInformation == null ||
                            controller.workerProfile.value.workerInformation!
                                    .lastAttendance ==
                                null
                        ? Text(
                            "--",
                            style: TextStyling.nameProfileTextStyle,
                          )
                        : Text(
                            parsingToDate(controller.workerProfile.value
                                .workerInformation!.lastAttendance),
                            // "${controller.workerProfile.value.workerInformation!.lastAttendance}",
                            style: TextStyling.nameProfileTextStyle,
                          ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  _workerInfo() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 4),
              child: _appBar(
                  text:
                      "${controller.workerProfile.value.workerInformation!.worker![0].firstName} ${controller.workerProfile.value.workerInformation!.worker![0].lastName}")),
          SizedBox(
            height: SizeConfig.heightMultiplier * 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                maxRadius: SizeConfig.widthMultiplier * 8,
                minRadius: SizeConfig.widthMultiplier * 8,
                backgroundColor: textFormColor,
                child: Center(
                  child: Text(
                    "${checkForStringNull(controller.workerProfile.value.workerInformation!.worker![0].firstName, "no name")[0].toString().toUpperCase()}${checkForStringNull(controller.workerProfile.value.workerInformation!.worker![0].lastName, "no name")[0].toString().toUpperCase()}",
                    style: TextStyling.formBlueTextStyle,
                  ),
                ),
                // backgroundImage: AssetImage(Images.workerImg),
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier * 4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 60,
                        child: Text(
                          "${nameCapitalised(controller.workerProfile.value.workerInformation!.worker![0].firstName)} ${nameCapitalised(controller.workerProfile.value.workerInformation!.worker![0].lastName)}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyling.nameProfileTextStyle,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 2,
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller
                                          .workerProfile
                                          .value
                                          .workerInformation!
                                          .verification!
                                          .workerIsVerified ==
                                      null ||
                                  controller
                                          .workerProfile
                                          .value
                                          .workerInformation!
                                          .verification!
                                          .workerIsVerified ==
                                      false
                              ? whiteColor
                              : blueColorText,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SvgPicture.asset(
                            Images.selectIcon,
                            height: 12,
                            width: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.5,
                  ),
                  controller.workerProfile.value.workerDetails == null
                      ? Text("---", style: TextStyling.normalTextStyle)
                      : Text(
                          "${controller.workerProfile.value.workerInformation!.worker![0].phoneNumber!}",
                          style: TextStyling.normalTextStyle),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.5,
                  ),
                  Container(
                    height: SizeConfig.heightMultiplier * 7,
                    // width: controller.workerProfile.value.workerInformation!
                    //             .workerRates!.all!.length ==
                    //         1
                    //     ? SizeConfig.widthMultiplier * 25
                    //     : SizeConfig.widthMultiplier * 55,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(color: lightBlueGreyColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 1.3,
                            vertical: SizeConfig.heightMultiplier * 0.3),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: SizeConfig.widthMultiplier * 1.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: textFormColor,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.widthMultiplier * 1.5,
                                      vertical:
                                          SizeConfig.heightMultiplier * 0.3),
                                  child: Text(
                                    "${controller.workerProfile.value.workerInformation!.workerRates!.current!.serviceName}",
                                    style: TextStyling.blueSmallTextStyle,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier * 0.5),
                              Text(
                                  "${controller.workerProfile.value.workerInformation!.workerRates!.current!.value} Rwf")
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: SizeConfig.heightMultiplier * 2.5,
                        // width: SizeConfig.widthMultiplier * 14,
                        decoration: BoxDecoration(
                          color: controller
                                          .workerProfile
                                          .value
                                          .workerInformation!
                                          .verification!
                                          .isWorkerActive ==
                                      null ||
                                  controller
                                          .workerProfile
                                          .value
                                          .workerInformation!
                                          .verification!
                                          .isWorkerActive ==
                                      false
                              ? redDark
                              : greyGreenColorText,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.widthMultiplier * 1.5),
                          child: controller
                                          .workerProfile
                                          .value
                                          .workerInformation!
                                          .verification!
                                          .isWorkerActive ==
                                      null ||
                                  controller
                                          .workerProfile
                                          .value
                                          .workerInformation!
                                          .verification!
                                          .isWorkerActive ==
                                      false
                              ? Center(
                                  child: Text(
                                  "Inactive",
                                  style: TextStyling.smallWhiteTextStyle,
                                ))
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: greenColorText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 2,
                                    ),
                                    Text(
                                      "Active",
                                      style: TextStyling.smallTextStyle,
                                    )
                                  ],
                                ),
                        ),
                      ),
                      SizedBox(width: SizeConfig.widthMultiplier * 4),
                      Text(
                        "L1 Rating",
                        style: TextStyling.formGreyyTextStyle,
                      ),
                      SizedBox(width: SizeConfig.widthMultiplier * 2),
                      _ratingBar(
                          assessmentsResults: controller.workerProfile.value
                              .workerInformation!.assessments!),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.5,
                  ),
                  Text(
                      "ID Number: ${controller.workerProfile.value.workerInformation!.worker![0].nidNumber}",
                      style: TextStyling.normalTextStyle),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  buttonSupplements(
      {required String iconName, required String text, required bool status}) {
    return Container(
      height: SizeConfig.heightMultiplier * 4,
      // width: SizeConfig.widthMultiplier * 40,
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: blueDark),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 1.3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(iconName,
                height: SizeConfig.heightMultiplier * 2,
                color: status ? redColor : blueDark),
            SizedBox(width: SizeConfig.widthMultiplier * 3),
            Text(text,
                style: status
                    ? TextStyling.redTextStyle
                    : TextStyling.blueTextStyle)
          ],
        ),
      ),
    );
  }

  button({required String iconName, required String text}) {
    return Container(
      height: SizeConfig.heightMultiplier * 6,
      width: SizeConfig.widthMultiplier * 30,
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: lightBlueGreyColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 1.3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(iconName,
                height: SizeConfig.heightMultiplier * 2, color: blackColorText),
            Text(text, style: TextStyling.buttonTextStyle)
          ],
        ),
      ),
    );
  }

  _workerActionsSupplements({required BuildContext context}) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 1.3),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () => _showModalDeductions(context: context),
                child: buttonSupplements(
                    iconName: Images.dollarIcon,
                    text: "Add Deductions",
                    status: false)),
            SizedBox(width: SizeConfig.widthMultiplier * 3),
            GestureDetector(
                onTap: () {
                  if (controller.workerProfile.value.workerInformation!
                          .assessments!.isEmpty ||
                      controller.workerProfile.value.workerInformation!
                              .assessments !=
                          null) {
                    Get.toNamed(RouteLinks.homeWorkerAssessment, arguments: {
                      "status": false,
                      "assignedWorkerId": assignedWorkerId,
                      "workerFullName":
                          '${controller.workerProfile.value.workerInformation!.worker![0].firstName} ${controller.workerProfile.value.workerInformation!.worker![0].lastName}',
                      'project_id': project.projectId,
                      'service_id': controller.workerProfile.value
                          .workerInformation!.services!.last.serviceId,
                      "worker_id": workerId,
                    });
                    // _showModelSheetALevels(
                    //     context: context, services: controller.levels);
                  } else {
                    warningMessage(message: "worker already assessed");
                  }
                },
                child: buttonSupplements(
                    iconName: Images.starrIcon,
                    text: "Assess Worker",
                    status: false)),
            SizedBox(width: SizeConfig.widthMultiplier * 3),
            GestureDetector(
              onTap: () => _showMoreModal(context: context),
              child: Container(
                height: SizeConfig.heightMultiplier * 4,
                decoration: BoxDecoration(
                  border: Border.all(color: blueDark),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 1.3),
                  child: SvgPicture.asset(
                    Images.hMoreIcon,
                    // height: SizeConfig.heightMultiplier * 2,
                    width: SizeConfig.widthMultiplier * 6,
                    color: blueDark,
                  ),
                ),
              ),
            ),
            SizedBox(width: SizeConfig.widthMultiplier * 3),
          ],
        ),
      ),
    );
  }

  _workerActions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          button(iconName: Images.mailIcon, text: "Send\nMessage"),
          button(
              iconName: Images.workerHelmetIcon, text: "Assign To \nProject"),
          button(iconName: Images.starrIcon, text: "Assess \n Worker"),
        ],
      ),
    );
  }

  serviceBox({required String text, required bool active}) {
    return Container(
      height: SizeConfig.heightMultiplier * 4,
      width: SizeConfig.widthMultiplier * 20,
      decoration: BoxDecoration(
          color: lightGreyColor, borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Text(
          text,
          style: TextStyling.serviceTextStyle,
        ),
      ),
    );
  }

  _workhistorydetailsbox(
      {required String text1,
      required String text2,
      required bool isDeductions}) {
    return Container(
      height: SizeConfig.heightMultiplier * 6,
      width: SizeConfig.widthMultiplier * 45,
      decoration: BoxDecoration(
        color: blackGreyColorText,
        border: Border.all(color: lightBlueGreyColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 1.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(text1.toUpperCase(), style: TextStyling.buttonMediumTextStyle),
            Text(text2,
                style: isDeductions
                    ? TextStyling.redTextStyle
                    : TextStyling.blueTextStyle),
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
      required TextStyle textStyle,
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
          Text(name, textAlign: TextAlign.center, style: textStyle),
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

  _showModelSheetALevels(
      {required BuildContext context, required List<String> services}) {
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
                  child: Text(
                      "Assess ${controller.workerProfile.value.workerInformation!.worker![0].firstName} ${controller.workerProfile.value.workerInformation!.worker![0].lastName} ",
                      style: TextStyling.formGreyTextStyle),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 4,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (services[index] == 'Level 1') {
                            Get.toNamed(RouteLinks.homeWorkerAssessment,
                                arguments: {
                                  "status": false,
                                  "assignedWorkerId": assignedWorkerId,
                                  "workerFullName":
                                      '${controller.workerProfile.value.workerInformation!.worker![0].firstName} ${controller.workerProfile.value.workerInformation!.worker![0].lastName}',
                                  'project_id': project.projectId,
                                  'service_id': controller
                                      .workerProfile
                                      .value
                                      .workerInformation!
                                      .services!
                                      .last
                                      .serviceId,
                                  "worker_id": workerId,
                                });
                            // print("here");
                            // Get.toNamed(RouteLinks.homeWorkerAssessment,
                            //     arguments: {
                            //       "project": project,
                            //       "workerFullName":
                            //           "${controller.workerProfile.value.workerInformation!.worker![0].firstName} ${controller.workerProfile.value.workerInformation!.worker![0].lastName}",
                            //       "worker_id": workerId,
                            //       "assign_worker_id": assignedWorkerId,
                            //       "level": 1
                            //     });
                          } else {
                            negativeMessage(
                                message:
                                    "Assessment ${services[index]} not avalaible");
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _viewTabs(
                                logo: "",
                                textStyle: TextStyling.normalBoldTextStyle,
                                name: "${services[index]}",
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
                    })
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
            icon: Icon(
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
    return Padding(
      padding: EdgeInsets.only(right: SizeConfig.widthMultiplier * 40),
      child: Container(
        // width: SizeConfig.widthMultiplier * 35,
        decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(color: greyLightColor),
            borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier * 2.5,
              vertical: SizeConfig.heightMultiplier * 0.5),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
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
      ),
    );
  }

  _widgetDeductions(
      {required DeductionControllers deductionController,
      required BuildContext context}) {
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
                        // await controller.removeWorkerDeduction(
                        //     projectId: project.projectId!,
                        //     assignedWorkerId: assignedWorkerId,
                        //     time: DateTime.now(),
                        //     deductionId: deductionController.deductionId);
                        // Navigator.pop(context);
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
                        icon: Icon(
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
                        icon: Icon(
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

  _widgetListDeductions({required Deductions deduction}) {
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
                height: SizeConfig.heightMultiplier * 6,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: greyLightColor),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    // controller: deductionController.deductedAmount,
                    enabled: false,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    // validator: (value) {
                    //   return controller.emailValidator(value!);
                    // },
                    decoration: InputDecoration(
                      hintText: dedeductionType.isEmpty
                          ? "-"
                          : "${dedeductionType[0].title}",
                      border: InputBorder.none,
                      fillColor: whiteColor,
                      filled: true,
                      hintStyle: TextStyling.formTextStyle,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
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
                    // controller: deductionController.deductedAmount,
                    enabled: false,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    // validator: (value) {
                    //   return controller.emailValidator(value!);
                    // },
                    decoration: InputDecoration(
                      hintText: "${deduction.deductionAmount}",
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

  _showModalDeductions({required BuildContext context}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        // context: context,
        builder: (context) {
          return GetBuilder<HomeAttendanceController>(
              initState: (_) => controller.getWorkerDeductions(
                  time: DateTime.now(),
                  projectId: project.projectId!,
                  assignedWorkerId: assignedWorkerId),
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
                          // ...controller.deductions.isEmpty
                          //     ? []
                          //     : controller.deductions.map(
                          //         (deductionController) =>
                          //             _widgetListDeductions(
                          //                 deduction: deductionController)),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 1.3,
                          ),
                          ...controller.deductionsControllers.isEmpty
                              ? []
                              : controller.deductionsControllers.map(
                                  (deductionController) => _widgetDeductions(
                                      context: context,
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
                                    text: "Save Deduction", press: () {}
                                    //  controller.saveDeductions(
                                    //     project: project,
                                    //     workerAssignedId: assignedWorkerId,
                                    //     context: context),
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

  _showMoreModal({required BuildContext context}) {
    return showModalBottomSheet(
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
                  height: SizeConfig.heightMultiplier * 5,
                ),
                GestureDetector(
                    onTap: () {
                      if (controller.workerProfile.value.workerDetails !=
                          null) {
                        Get.toNamed(RouteLinks.homeEditWorkerProfile,
                            arguments: {
                              "worker_id": workerId,
                              "assign_worker_id": assignedWorkerId,
                              "first_name": controller.workerProfile.value
                                  .workerInformation!.worker![0].firstName,
                              "district_name": controller.workerProfile.value
                                  .workerInformation!.worker![0].district,
                              "last_name": controller.workerProfile.value
                                  .workerInformation!.worker![0].lastName,
                              "rssb_code": controller.workerProfile.value
                                  .workerInformation!.worker![0].rssbCode,
                              "id_number": controller.workerProfile.value
                                  .workerInformation!.worker![0].nidNumber,
                              "phone_number": controller.workerProfile.value
                                  .workerInformation!.worker![0].phoneNumber,
                              "current_rate": (controller.workerProfile.value
                                              .workerInformation!.workerRates !=
                                          null ||
                                      controller
                                              .workerProfile
                                              .value
                                              .workerInformation!
                                              .workerRates!
                                              .current !=
                                          null)
                                  ? controller
                                      .workerProfile
                                      .value
                                      .workerInformation!
                                      .workerRates!
                                      .current!
                                      .value
                                      .toString()
                                  : "0",
                              "gender": controller.workerProfile.value
                                      .workerInformation!.worker![0].gender ??
                                  "male",
                              "current_service": (controller.workerProfile.value
                                              .workerInformation!.workerRates !=
                                          null ||
                                      controller
                                              .workerProfile
                                              .value
                                              .workerInformation!
                                              .workerRates!
                                              .current !=
                                          null)
                                  ? controller
                                      .workerProfile
                                      .value
                                      .workerInformation!
                                      .workerRates!
                                      .current!
                                      .serviceName
                                  : "no service",
                              "project": project,
                              "worker_rates": controller.workerProfile.value
                                  .workerInformation!.workerRates!.all,
                            });
                      }
                    },
                    child: _viewTabs(
                        logo: Images.penIcon,
                        name: "Edit",
                        textStyle: TextStyling.normalBoldOrangeTextStyle,
                        logo2: "",
                        color: orangeLight,
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
                controller.workerProfile.value.workerInformation!.verification!
                        .workerIsVerified!
                    ? Container()
                    : GestureDetector(
                        onTap: () async {
                          if (!controller.workerProfile.value.workerInformation!
                              .verification!.workerIsVerified!) {
                            controller.verifyWorker(
                                assignWorkerId: assignedWorkerId,
                                projectId: project.projectId!,
                                workerId: workerId);
                            Navigator.pop(context);
                          }
                        },
                        child: _viewTabs(
                            logo: Images.isVerifiedIcon,
                            textStyle: TextStyling.normalBoldGreenTextStyle,
                            name: "Verify Worker",
                            logo2: "",
                            color: greenColorText,
                            isRed: true)),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
                controller.workerProfile.value.workerInformation!.verification!
                        .workerIsVerified!
                    ? Container()
                    : Divider(
                        thickness: 1.5,
                        color: textFormBorderColor,
                      ),
                controller.workerProfile.value.workerInformation!.verification!
                        .workerIsVerified!
                    ? Container()
                    : SizedBox(
                        height: SizeConfig.heightMultiplier * 1.5,
                      ),
              ],
            ),
          );
        });
  }
}

// const _maxHeaderExtent = 50.0;

class _HeaderTab extends SliverPersistentHeaderDelegate {
  final List<Map<String, dynamic>> tabTexts;
  final TabController tabController;
  final String fullName;
  _HeaderTab(
      {required this.tabTexts,
      required this.tabController,
      required this.fullName});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      // height: SizeConfig.heightMultiplier * 6,
      color: lightgreyBlueGreyColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 4,
            vertical: SizeConfig.heightMultiplier * 0.5),
        child: Container(
          height: SizeConfig.heightMultiplier * 6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: lightGreyColor
              // border: Border(bottom: BorderSide(color: lightBlueGreyColor))
              ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 0.4,
                vertical: SizeConfig.heightMultiplier * 0.3),
            child: TabBar(
                controller: tabController,
                unselectedLabelStyle: TextStyling.tabUnSelectedTextStyle,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: whiteColor),
                tabs: List<Widget>.generate(
                    tabTexts.length,
                    (index) => Tab(
                          child: Text(tabTexts[index]["tab_name"],
                              style: tabTexts[index]["tab_id"] == index
                                  ? TextStyling.tabSelectedTextStyle
                                  : TextStyling.tabUnSelectedTextStyle),
                        ))),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => SizeConfig.heightMultiplier * 6;

  @override
  double get minExtent => SizeConfig.heightMultiplier * 6;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class _HeaderTabBu extends SliverPersistentHeaderDelegate {
  final String fullName;
  _HeaderTabBu({required this.fullName});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / SizeConfig.heightMultiplier * 3;
    return Container(
      color: whiteColor,
      child: percent > 0.1
          ? Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.widthMultiplier * 8,
                  right: SizeConfig.widthMultiplier * 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset(
                      Images.leftArrowIcon,
                      color: appBarColorText,
                      width: SizeConfig.widthMultiplier * 4,
                    ),
                  ),
                  Text(fullName, style: TextStyling.nameProfileTextStyle),
                  SvgPicture.asset(
                    Images.searchIcon,
                    color: whiteColor,
                    width: SizeConfig.widthMultiplier * 4,
                  ),
                ],
              ))
          : Container(),
    );
  }

  @override
  double get maxExtent => SizeConfig.heightMultiplier * 3;

  @override
  double get minExtent => SizeConfig.heightMultiplier * 3;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
