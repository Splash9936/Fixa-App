// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:fixa/fixa_main_routes.dart';
import 'package:intl/intl.dart';

class HomePayroll extends GetWidget<HomePayrollController> {
  final Project project;
  final bool statusNavigator;
  HomePayroll({Key? key, required this.project, required this.statusNavigator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: GetBuilder<HomePayrollController>(
          init: HomePayrollController(),
          initState: (_) =>
              controller.getPaymentInfoData(projectIdValue: project.projectId!),
          builder: (cons) {
            return Stack(
              children: [
                _displayEmptyPayment(),
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
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 4,
                      ),
                      appBarPayment(text: "Payroll List"),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 4,
                      ),
                      GestureDetector(
                          onTap: () =>
                              _showBottomSheetPayrollPeriod(context: context),
                          child: _appShiftDate()),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 1.2,
                      ),
                      _paymentInfo(allPayments: controller.allPayments),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2,
                      ),
                      Obx(() => controller.paymentTypes.isEmpty
                          ? Container()
                          : _tabs()),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 1.8,
                      ),
                      _paymentList(context: context),
                    ],
                  ),
                ))
              ],
            );
          }),
    );
  }

  _displayEmptyPayment() {
    return Obx(
      () => controller.payrollWorkers.isEmpty
          ? Positioned(
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
                      Images.homePayrollIcon,
                      height: SizeConfig.heightMultiplier * 12,
                      color: blueDark,
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    Text(
                      "No payments found",
                      textAlign: TextAlign.center,
                      style: TextStyling.formBgGreyTextStyle,
                    )
                  ],
                ),
              ))
          : Container(),
    );
  }

  appBarPayment({required String text}) {
    return Obx(
      () => controller.isSearching.value
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
                      onTap: () => controller.setIsSearching(
                          status: controller.isSearching.value),
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
                            controller.searchPayment(
                                dataValue: value.toLowerCase(), isEmpty: true);
                          } else {
                            controller.searchPayment(
                                dataValue: value.toLowerCase(), isEmpty: false);
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Search by payment title",
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
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (!statusNavigator) {
                      Get.back();
                      controller.allPayrollWorkers.value = [];
                      controller.payrollWorkers.value = [];
                    }
                  },
                  child: SvgPicture.asset(
                    Images.leftArrowIcon,
                    color: statusNavigator ? blueDark : whiteColor,
                    width: SizeConfig.widthMultiplier * 4,
                  ),
                ),
                Text(text, style: TextStyling.nameWhiteProfileTextStyle),
                GestureDetector(
                  onTap: () => controller.setIsSearching(
                      status: controller.isSearching.value),
                  child: SvgPicture.asset(
                    Images.searchIcon,
                    color: whiteColor,
                    width: SizeConfig.widthMultiplier * 4,
                  ),
                ),
              ],
            ),
    );
  }

  _showBottomSheetPayrollPeriod({required BuildContext context}) {
    return showModalBottomSheet(
        backgroundColor: whiteColor,
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
                        onTap: () => controller.changeYear(
                            dateValue: controller.yearSeleted.value - 1),
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
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "${controller.yearSeleted}",
                        // "${DateFormat.LLLL().format(DateTime.parse(controller.payrollFrames[controller.selectedCurrentPayrollIndex.value].date!))} - ${DateTime.parse(controller.payrollFrames[controller.selectedCurrentPayrollIndex.value].date!).year}",
                        style: TextStyling.normalBoldTextStyle,
                      ),
                      GestureDetector(
                        onTap: () => controller.changeYear(
                            dateValue: controller.yearSeleted.value + 1),
                        child: Container(
                          child: Row(
                            children: [
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 12),
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 3,
                            crossAxisCount: 3,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 4)),
                        itemCount: controller.monthData.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: controller.monthData[index]["id"]
                                        .toString() ==
                                    controller.monthSelected.toString()
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.widthMultiplier * 3,
                                        vertical:
                                            SizeConfig.heightMultiplier * 0.4),
                                    decoration: BoxDecoration(
                                        color: blueDark,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Text(
                                      "${controller.monthData[index]["month_name"].substring(0, 3)}",
                                      // "${DateFormat.LLLL().format(DateTime.parse(controller.payrollFrames[controller.selectedCurrentPayrollIndex.value].date!))} - ${DateTime.parse(controller.payrollFrames[controller.selectedCurrentPayrollIndex.value].date!).year}",
                                      style: TextStyling
                                          .normalSingleWhiteBoldTextStyle,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () => controller.changeMonth(
                                        monthValue: controller.monthData[index]
                                            ["id"],
                                        projectIdValue: project.projectId!),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.widthMultiplier * 3,
                                          vertical:
                                              SizeConfig.heightMultiplier *
                                                  0.4),
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Text(
                                        "${controller.monthData[index]["month_name"].substring(0, 3)}",
                                        // "${DateFormat.LLLL().format(DateTime.parse(controller.payrollFrames[controller.selectedCurrentPayrollIndex.value].date!))} - ${DateTime.parse(controller.payrollFrames[controller.selectedCurrentPayrollIndex.value].date!).year}",
                                        style: TextStyling
                                            .normalSingleBoldTextStyle,
                                      ),
                                    ),
                                  ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
        });
  }

  _appShiftDate() {
    return Obx(
      () => Container(
        height: SizeConfig.heightMultiplier * 8,
        width: double.infinity,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
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
                  Text("Month", style: TextStyling.formGreyTextStyle),
                  SizedBox(height: SizeConfig.heightMultiplier * 0.6),
                  Text(
                    getTimePayroll(
                      monthData: controller.monthData,
                      year: controller.yearSeleted.value,
                      month: controller.monthSelected.value,
                    ),
                    style: TextStyling.formBlueTextStyle,
                  )
                ],
              ),
              SvgPicture.asset(
                Images.arrowDownIcon,
                color: blueDark,
                height: SizeConfig.heightMultiplier * 1.5,
              )
            ],
          ),
        ),
      ),
    );
  }

  _paymentInfo({required List<Payments> allPayments}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => Text(
              getTimePayrollDetails(
                  monthData: controller.monthData,
                  month: controller.monthSelected.value),
              style: TextStyling.buttonMediumWhiteTextStyle)),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Total Payments: ",
                  style: TextStyling.buttonMediumWhiteTextStyle,
                ),
                TextSpan(
                  text: "${allPayments.length.toString()}",
                  style: TextStyling.buttonMediumWhiteBoldTextStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _tabs() {
    return SizedBox(
      height: SizeConfig.heightMultiplier * 6,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: controller.paymentTypes.length,
          itemBuilder: (context, index) {
            return Obx(
              () => GestureDetector(
                onTap: () => controller.changePaymentType(
                    paymentTypeValue: controller.paymentTypes[index].id!),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 2),
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 4,
                      vertical: SizeConfig.heightMultiplier * 0.5),
                  decoration: BoxDecoration(
                      color: controller.paymentTypes[index].id! ==
                              controller.selectedPaymentType.value
                          ? whiteColor
                          : blueDark,
                      border: Border.all(color: bluelight),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "${fullNameCapitalised(controller.paymentTypes[index].typeName)}",
                          style: controller.paymentTypes[index].id! ==
                                  controller.selectedPaymentType.value
                              ? TextStyling.blueTextStyle
                              : TextStyling.buttonMediumWhiteTextStyle),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 2,
                      ),
                      getPaymentTypesInfo(
                                  paymentTypeId:
                                      controller.paymentTypes[index].id!,
                                  payments: controller.allPayments) ==
                              "0"
                          ? Container()
                          : Container(
                              decoration: BoxDecoration(
                                color: controller.paymentTypes[index].id! ==
                                        controller.selectedPaymentType.value
                                    ? blueDark
                                     : blueDark,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: bluelight)
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.widthMultiplier * 2,
                                    vertical: 2),
                                child: Text(
                                  getPaymentTypesInfo(
                                      paymentTypeId:
                                          controller.paymentTypes[index].id!,
                                      payments: controller.allPayments),
                                  style: TextStyling.buttonMediumWhiteTextStyle,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  _paymentList({required BuildContext context}) {
    return Obx(() => controller.isLoadingPayments.value
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
        : controller.payments.isEmpty
            ? Container()
            : Expanded(
                child: Container(
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
                    itemCount: controller.payments.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Get.toNamed(RouteLinks.homePayrollDetails,
                            arguments: {
                              "payment_type": getPaymentTypeName(
                                      paymentTypeId: controller
                                          .payments[index].paymentTypesId!,
                                      paymentTypes: controller.paymentTypes)
                                  .toLowerCase(),
                              "project": project,
                              "payment": controller.payments[index]
                            }),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 5.5,
                                vertical: SizeConfig.heightMultiplier * 1.2),
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.heightMultiplier * 0.5),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                border: Border(
                                    bottom:
                                        BorderSide(color: textFormBorderColor)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${controller.payments[index].id}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyling.normalBoldTextStyle,
                                  ),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 3,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 8,
                                              child: Text(
                                                "${fullNameCapitalised(controller.payments[index].title)}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyling
                                                    .normalBoldTextStyle,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                  fullNameCapitalised(
                                                      getPaymentTypeName(
                                                          paymentTypeId: controller
                                                              .payments[index]
                                                              .paymentTypesId!,
                                                          paymentTypes: controller
                                                              .paymentTypes)),
                                                  style: TextStyling
                                                      .formGreyTextStyle),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 0.8,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child: Text(
                                                "Created On ${DateFormat('dd/MM/yyyy').format(DateTime.parse(controller.payments[index].addedOn!))}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyling
                                                    .formGreyTextStyle,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                  fullNameCapitalised(
                                                      "${controller.payments[index].totalPayees} Payees"),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyling
                                                      .formGreyTextStyle),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 0.8,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child: Text(
                                                "${currencyFormat(price: double.parse(controller.payments[index].totalAmount!))} RWF",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyling
                                                    .formGreyTextStyle,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                  "${fullNameCapitalised(project.projectName)}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyling
                                                      .formGreyTextStyle),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 0.8,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            getAttendanceStatus(
                                                status: controller
                                                    .payments[index].status!),
                                            SizedBox(
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        3),
                                            Text(
                                                "Updated On ${DateFormat('dd/MM/yyyy').format(DateTime.parse(controller.payments[index].updatedAt!))}",
                                                style: TextStyling
                                                    .formGreyTextStyle),
                                          ],
                                        ),

                                        // SizedBox(
                                        //   height: SizeConfig.heightMultiplier * 6,
                                        //   child: ListView(
                                        //     shrinkWrap: true,
                                        //     scrollDirection: Axis.horizontal,
                                        //     children: [

                                        //     ],
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // child: Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Row(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         Text(
                              //           "${controller.payments[index].id}",
                              //           overflow: TextOverflow.ellipsis,
                              //           style: TextStyling.normalBoldTextStyle,
                              //         ),
                              //         SizedBox(
                              //           width: SizeConfig.widthMultiplier * 6,
                              //         ),
                              //         Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           children: [
                              //             Row(
                              //               // crossAxisAlignment:
                              //               //     CrossAxisAlignment.start,
                              //               // mainAxisAlignment:
                              //               //     MainAxisAlignment
                              //               //         .spaceBetween,
                              //               children: [
                              //                 Center(
                              //                   child: Text(
                              //                     "${fullNameCapitalised(controller.payments[index].title)}",
                              //                     overflow:
                              //                         TextOverflow.ellipsis,
                              //                     style: TextStyling
                              //                         .normalBoldTextStyle,
                              //                   ),
                              //                 ),
                              //                 SizedBox(
                              //                     width: SizeConfig
                              //                             .widthMultiplier *
                              //                         10),
                              //                 Text(
                              //                     fullNameCapitalised(
                              //                         getPaymentTypeName(
                              //                             paymentTypeId: controller
                              //                                 .payments[index]
                              //                                 .paymentTypesId!,
                              //                             paymentTypes: controller
                              //                                 .paymentTypes)),
                              //                     style: TextStyling
                              //                         .formGreyTextStyle),
                              //               ],
                              //             ),
                              //             SizedBox(
                              //               height:
                              //                   SizeConfig.heightMultiplier *
                              //                       0.6,
                              //             ),
                              //             SizedBox(
                              //               height:
                              //                   SizeConfig.heightMultiplier * 6,
                              //               // width:
                              //               //     SizeConfig.widthMultiplier * 55,
                              //               child: ListView(
                              //                 shrinkWrap: true,
                              //                 scrollDirection: Axis.horizontal,
                              //                 children: [
                              //                   Column(
                              //                     crossAxisAlignment:
                              //                         CrossAxisAlignment.start,
                              //                     children: [
                              //                       Text(
                              //                           "Created On ${DateFormat('dd/MM/yyyy').format(DateTime.parse(controller.payments[index].addedOn!))}",
                              //                           style: TextStyling
                              //                               .formGreyTextStyle),
                              //                       SizedBox(
                              //                         height: SizeConfig
                              //                                 .heightMultiplier *
                              //                             0.6,
                              //                       ),
                              //                       Text(
                              //                           "${controller.payments[index].totalPayees} Payees",
                              //                           style: TextStyling
                              //                               .formGreyTextStyle),
                              //                     ],
                              //                   ),
                              //                   SizedBox(
                              //                     width: SizeConfig
                              //                             .widthMultiplier *
                              //                         6,
                              //                   ),
                              //                   Column(
                              //                     crossAxisAlignment:
                              //                         CrossAxisAlignment.start,
                              //                     children: [
                              //                       Text(
                              //                           "${fullNameCapitalised(project.projectName)}",
                              //                           style: TextStyling
                              //                               .formGreyTextStyle),
                              //                       SizedBox(
                              //                         height: SizeConfig
                              //                                 .heightMultiplier *
                              //                             0.6,
                              //                       ),
                              //                       Text(
                              //                           "${currencyFormat(price: double.parse(controller.payments[index].totalAmount!))} RWF",
                              //                           style: TextStyling
                              //                               .formGreyTextStyle),
                              //                     ],
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //             Row(
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.start,
                              //               children: [
                              //                 getAttendanceStatus(
                              //                     status: controller
                              //                         .payments[index].status!),
                              //                 SizedBox(
                              //                     width: SizeConfig
                              //                             .widthMultiplier *
                              //                         3),
                              //                 controller.payments[index]
                              //                             .updatedAt ==
                              //                         null
                              //                     ? Container()
                              //                     : Text(
                              //                         "Updated On ${DateFormat('dd/MM/yyyy').format(DateTime.parse(controller.payments[index].updatedAt!))}",
                              //                         style: TextStyling
                              //                             .formGreyTextStyle)
                              //               ],
                              //             ),
                              //             SizedBox(
                              //               height:
                              //                   SizeConfig.heightMultiplier *
                              //                       0.6,
                              //             ),
                              //           ],
                              //         ),
                              //       ],
                              //     ),

                              //   ],
                              // ),
                            )),
                      );
                    }),
              )));
  }

  getAttendanceStatus({required String status}) {
    if (status == "closed") {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 3, vertical: 3),
        decoration: BoxDecoration(
          color: greyGreenColorText,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              Images.halfIcon,
              height: 12,
              width: 12,
            ),
            SizedBox(width: SizeConfig.widthMultiplier * 1.3),
            Text(
              "${fullNameCapitalised(status)}",
              style: TextStyling.smallRedTextStyle,
            ),
          ],
        ),
      );
    } else if (status == "open") {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 3, vertical: 3),
        decoration: BoxDecoration(
          color: yeollowLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              Images.halfIcon,
              height: 12,
              width: 12,
            ),
            SizedBox(width: SizeConfig.widthMultiplier * 1.3),
            Text(
              "${fullNameCapitalised(status)}",
              style: TextStyling.nameSmallOrangeTextStyle,
            ),
          ],
        ),
      );
    } else if (status == "unpaid") {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 3, vertical: 3),
        decoration: BoxDecoration(
          color: greyLightColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              Images.halfIcon,
              height: 12,
              width: 12,
            ),
            SizedBox(width: SizeConfig.widthMultiplier * 1.3),
            Text(
              "${fullNameCapitalised(status)}",
              style: TextStyling.blackSmallTextStyle,
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
