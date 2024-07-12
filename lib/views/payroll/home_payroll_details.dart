// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_element

import 'package:fixa/fixa_main_routes.dart';
import 'package:intl/intl.dart';

class HomePayrollDetails extends GetWidget<HomePayrollDetailsController> {
  final Payments payment;
  final String paymentType;
  final Project project;
  const HomePayrollDetails(
      {Key? key,
      required this.payment,
      required this.paymentType,
      required this.project})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: GetBuilder<HomePayrollDetailsController>(
          init: HomePayrollDetailsController(),
          initState: (_) => controller.getPayrollTransactions(
              paymentId: payment.id!,
              project: project,
              paymentType: paymentType),
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
                      paymentType == 'payout'
                          ? _appBarPayment(text: "Payout List", isPayout: true)
                          : _appBarPayment(
                              text: "Payroll List", isPayout: false),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 4,
                      ),
                      Center(
                        child: paymentType == 'payout'
                            ? Text('Payout: ${payment.title}',
                                textAlign: TextAlign.center,
                                style: TextStyling.nameWhiteProfileTextStyle)
                            : Text('Payroll: ${payment.title}',
                                textAlign: TextAlign.center,
                                style: TextStyling.nameWhiteProfileTextStyle),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 1.4,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          getPaymentStatus(status: payment.status!),
                          SizedBox(width: SizeConfig.widthMultiplier * 3),
                          payment.updatedAt == null
                              ? Container()
                              : Text(
                                  "Updated on ${DateFormat('dd/MM/yyyy').format(DateTime.parse(payment.updatedAt!))}",
                                  style: TextStyling
                                      .nameSmallWhiteProfileTextStyle)
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 1.4,
                      ),
                      Center(
                        child: paymentType == 'payout'
                            ? Text('Total Payees: ${payment.totalPayees}',
                                textAlign: TextAlign.center,
                                style: TextStyling.nameWhiteProfileTextStyle)
                            : Text('Total Workers: ${payment.totalPayees}',
                                textAlign: TextAlign.center,
                                style: TextStyling.nameWhiteProfileTextStyle),
                      ),
                      // SizedBox(
                      //   height: SizeConfig.heightMultiplier * 2,
                      // ),
                      // paymentType == 'payout'
                      //     ? Container()
                      //     : Obx(() => controller.allServices.isEmpty
                      //         ? Container()
                      //         : _tabs()),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 4,
                      ),
                      paymentType == 'payout'
                          ? _paymentListPayout(context: context)
                          : _paymentListPayroll(context: context),
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
      () => controller.payrollTRansactions.isEmpty
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
                      "No transactions found",
                      textAlign: TextAlign.center,
                      style: TextStyling.formBgGreyTextStyle,
                    )
                  ],
                ),
              ))
          : Container(),
    );
  }

  _appBarPayment({required String text, required bool isPayout}) {
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
                            controller.searchPaymentTRansactions(
                                isPayout: isPayout,
                                data: value.toLowerCase(),
                                isEmpty: true);
                          } else {
                            controller.searchPaymentTRansactions(
                                isPayout: isPayout,
                                data: value.toLowerCase(),
                                isEmpty: false);
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Search by Name or Phone Number",
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
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    Images.leftArrowIcon,
                    color: whiteColor,
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

  getPaymentStatus({required String status}) {
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
              nameCapitalised(status),
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
              nameCapitalised(status),
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
              nameCapitalised(status),
              style: TextStyling.blackSmallTextStyle,
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  getPaymentWorkerStatus({required String status}) {
    if (status == "successful") {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 1.3,
            vertical: SizeConfig.heightMultiplier * 0.3),
        decoration: BoxDecoration(
          color: greyGreenColorText,
          border: Border.all(color: greenColor),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          nameCapitalised(status),
          style: TextStyling.smallRedTextStyle,
        ),
      );
    } else if (status == "failed") {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 1.3,
            vertical: SizeConfig.heightMultiplier * 0.3),
        decoration: BoxDecoration(
          color: redlightDark,
          border: Border.all(color: redColor),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          nameCapitalised(status),
          style: TextStyling.redSmallTextStyle,
        ),
      );
    } else if (status == "unpaid") {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 1.3,
            vertical: SizeConfig.heightMultiplier * 0.3),
        decoration: BoxDecoration(
          color: greyLightColor,
          border: Border.all(color: greyColor),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          nameCapitalised(status),
          style: TextStyling.blackSmallTextStyle,
        ),
      );
    } else {
      return Container();
    }
  }

  _tabs() {
    return SizedBox(
      height: SizeConfig.heightMultiplier * 6,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: controller.allServices.length,
          itemBuilder: (context, index) {
            return Obx(
              () => GestureDetector(
                onTap: () => controller.changeService(
                    service: controller.allServices[index]),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 2),
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 4,
                      vertical: SizeConfig.heightMultiplier * 0.5),
                  decoration: BoxDecoration(
                      color: controller.allServices[index].id! ==
                              controller.selectedService.value
                          ? whiteColor
                          : blueDark,
                      border: Border.all(color: bluelight),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.allServices[index].name!,
                          style: controller.allServices[index].id! ==
                                  controller.selectedService.value
                              ? TextStyling.blueTextStyle
                              : TextStyling.buttonMediumWhiteTextStyle),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 2,
                      ),
                      controller.payrollTRansactions.isEmpty
                          ? Container()
                          : getPayrollHistoryPerService(
                                      payrollWorkers:
                                          controller.allPayrollTRansactions,
                                      service: controller.allServices[index]) ==
                                  "0"
                              ? Container()
                              : Container(
                                  decoration: BoxDecoration(
                                    color: controller.allServices[index].id! ==
                                            controller.selectedService.value
                                        ? blueDark
                                        : bluelight,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.widthMultiplier * 2,
                                        vertical: 2),
                                    child: Text(
                                      getPayrollHistoryPerService(
                                          payrollWorkers:
                                              controller.allPayrollTRansactions,
                                          service:
                                              controller.allServices[index]),
                                      style: TextStyling
                                          .buttonMediumWhiteTextStyle,
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

  _paymentListPayroll({required BuildContext context}) {
    return Obx(() => controller.isLoadingTransactions.value
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
        : controller.payrollTRansactions.isEmpty
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
                    itemCount: controller.payrollTRansactions.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // get deduction & attendance info
                          controller.getWorkerInformation(
                              payrollTransactionId:
                                  controller.payrollTRansactions[index].id!);
                          _showBottomSheetWorkerInfo(
                              context: context,
                              payrollWorker:
                                  controller.payrollTRansactions[index]);
                        },
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: SizeConfig.heightMultiplier * 7,
                                      width: SizeConfig.widthMultiplier * 16,
                                      decoration: BoxDecoration(
                                          color: textFormColor,
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Text(
                                          splitName(
                                              "${controller.payrollTRansactions[index].workerName!.split(' ').isEmpty ? "X" : controller.payrollTRansactions[index].workerName!.split(' ')[0]} ${controller.payrollTRansactions[index].workerName!.split(' ').isEmpty ? "XX" : controller.payrollTRansactions[index].workerName!.split(' ')[1]}"),
                                          style: TextStyling.formBlueTextStyle,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 3,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 3,
                                          width:
                                              SizeConfig.widthMultiplier * 55,
                                          child: ListView(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              Text(
                                                fullNameCapitalised(controller
                                                    .payrollTRansactions[index]
                                                    .workerName),
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyling
                                                    .normalBoldTextStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 0.6,
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 3,
                                          width:
                                              SizeConfig.widthMultiplier * 56,
                                          // width: double.infinity,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                getPaymentWorkerStatus(
                                                    status: controller
                                                        .payrollTRansactions[
                                                            index]
                                                        .status!),

                                                SizedBox(
                                                  width: SizeConfig
                                                          .widthMultiplier *
                                                      1.5,
                                                ),
                                                Text(
                                                    "${currencyFormat(price: double.parse(controller.payrollTRansactions[index].takeHome.toString()))} Rwf, ",
                                                    style: TextStyling
                                                        .buttonMediumTextStyle),
                                                SizedBox(
                                                  width: SizeConfig
                                                          .widthMultiplier *
                                                      1.5,
                                                ),
                                                Text(
                                                    "${controller.payrollTRansactions[index].phoneNumber}",
                                                    style: TextStyling
                                                        .buttonMediumTextStyle),

                                                SizedBox(
                                                  width: SizeConfig
                                                          .widthMultiplier *
                                                      1.5,
                                                ),
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    SvgPicture.asset(
                                      Images.moreIcon,
                                      height: SizeConfig.heightMultiplier * 1.6,
                                      color: lightBlueGreyColor,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )));
  }

  _paymentListPayout({required BuildContext context}) {
    return Obx(() => controller.isLoadingTransactions.value
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
        : controller.payoutTRansactions.isEmpty
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
                    itemCount: controller.payoutTRansactions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 5.5,
                            vertical: SizeConfig.heightMultiplier * 1.2),
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: SizeConfig.heightMultiplier * 0.5),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            border: Border(
                                bottom: BorderSide(color: textFormBorderColor)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: SizeConfig.heightMultiplier * 7,
                                    width: SizeConfig.widthMultiplier * 16,
                                    decoration: BoxDecoration(
                                        color: textFormColor,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Text(
                                        splitName(
                                            "${controller.payoutTRansactions[index].payeeName!.split(' ').isEmpty || controller.payoutTRansactions[index].payeeName == null ? "X" : controller.payoutTRansactions[index].payeeName!.split(' ')[0]} ${controller.payoutTRansactions[index].payeeName!.split(' ').length == 1 || controller.payoutTRansactions[index].payeeName == null ? "XX" : controller.payoutTRansactions[index].payeeName!.split(' ')[1]}"),
                                        style: TextStyling.formBlueTextStyle,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 3,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: SizeConfig.heightMultiplier * 3,
                                        width: SizeConfig.widthMultiplier * 55,
                                        child: ListView(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            Text(
                                              "${fullNameCapitalised(controller.payoutTRansactions[index].payeeName)}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyling
                                                  .normalBoldTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            SizeConfig.heightMultiplier * 0.6,
                                      ),
                                      SizedBox(
                                        height: SizeConfig.heightMultiplier * 3,
                                        width: SizeConfig.widthMultiplier * 55,
                                        // width: double.infinity,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              getPaymentWorkerStatus(
                                                  status: controller
                                                      .payoutTRansactions[index]
                                                      .status!),
                                              SizedBox(
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        1.5,
                                              ),
                                              Text(
                                                  "${currencyFormat(price: double.parse(controller.payoutTRansactions[index].amount.toString()))} Rwf, ",
                                                  style: TextStyling
                                                      .buttonMediumTextStyle),
                                              SizedBox(
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        1.5,
                                              ),
                                              Text(
                                                  "${controller.payoutTRansactions[index].phoneNumber}, ",
                                                  style: TextStyling
                                                      .buttonMediumTextStyle),
                                              SizedBox(
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        1.5,
                                              ),
                                              Text(
                                                  "${fullNameCapitalised(controller.payoutTRansactions[index].payeeTypeName)} ",
                                                  style: TextStyling
                                                      .formGreyTextStyle),

                                              SizedBox(
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        1.5,
                                              ),
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  paymentType == 'payout'
                                      ? Container()
                                      : SvgPicture.asset(
                                          Images.moreIcon,
                                          height:
                                              SizeConfig.heightMultiplier * 1.6,
                                          color: lightBlueGreyColor,
                                        )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              )));
  }

  _showBottomSheetWorkerInfo({
    required BuildContext context,
    required PayrollTransactions payrollWorker,
  }) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Obx(() => Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
                child: controller.isSearchingWorkerInfo.value
                    ? Container(
                        height: SizeConfig.heightMultiplier * 30,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(24),
                            topLeft: Radius.circular(24),
                          ),
                        ),
                        child: lottieLoading(sizeConfigHeight: 16),
                      )
                    : Column(
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
                                "${payrollWorker.workerName} Payroll Summary",
                                style: TextStyling.formGreyTextStyle),
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 3,
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 18,
                            width: SizeConfig.widthMultiplier * 55,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.attendanceInfo.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.widthMultiplier * 3),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: textFormBorderColor,
                                                width: 1.2))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: textFormColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    SizeConfig.widthMultiplier *
                                                        2,
                                                vertical: 2),
                                            child: Text(
                                              "${controller.attendanceInfo[index]["service_name"]}",
                                              style:
                                                  TextStyling.formBlueTextStyle,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 1.3,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${controller.attendanceInfo[index]["total_shift_days"]} days",
                                              style: TextStyling
                                                  .normalBoldTextStyle,
                                            ),
                                            SizedBox(
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        4),
                                            Text(
                                              "${currencyFormat(price: double.parse(controller.attendanceInfo[index]["total_day_value"].toString()))} Rwf",
                                              style: TextStyling
                                                  .normalBoldTextStyle,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 0.6,
                                        ),
                                        Text(
                                            "${currencyFormat(price: double.parse(controller.attendanceInfo[index]["shift_day_value"].toString()))} Rwf",
                                            style:
                                                TextStyling.formGreyTextStyle),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 0.2,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeConfig.widthMultiplier * 36,
                                          height: 1.2,
                                          child: Divider(
                                            thickness: 1.2,
                                            color: textFormBorderColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 0.2,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${controller.attendanceInfo[index]["total_shift_nights"]} nights",
                                              style: TextStyling
                                                  .normalBoldTextStyle,
                                            ),
                                            SizedBox(
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        4),
                                            Text(
                                              "${currencyFormat(price: double.parse(controller.attendanceInfo[index]["total_night_value"].toString()))} Rwf",
                                              style: TextStyling
                                                  .normalBoldTextStyle,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 0.6,
                                        ),
                                        Text(
                                            "${currencyFormat(price: double.parse(controller.attendanceInfo[index]["shift_night_value"].toString()))} Rwf",
                                            style:
                                                TextStyling.formGreyTextStyle),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 0.6,
                          ),
                          Divider(
                            thickness: 1.2,
                            color: textFormBorderColor,
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 1.5,
                          ),
                          // controller.isLoadingDeduction.value
                          //     ?
                          GestureDetector(
                            onTap: () {
                              if (payment.status != null &&
                                  payment.status!.toLowerCase() == 'unpaid') {
                                _showModalDeductions(
                                    context: context,
                                    payrollId: payrollWorker.id!,
                                    paymentId:
                                        int.parse(payrollWorker.paymentId!),
                                    workerAssignedId: int.parse(
                                        payrollWorker.assignedWorkerId!));
                              }
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Deduction ${currencyFormat(price: double.parse(payrollWorker.totalDeductions ?? "0"))} rwf",
                                  style: TextStyling.formOrangeTextStyle,
                                ),
                                Spacer(),
                                (payment.status != null &&
                                        payment.status!.toLowerCase() ==
                                            'unpaid')
                                    ? SvgPicture.asset(
                                        Images.editIcon,
                                        color: blueColorText,
                                        height: SizeConfig.heightMultiplier * 2,
                                      )
                                    : Container(),
                                SizedBox(width: SizeConfig.widthMultiplier * 2),
                                (payment.status != null &&
                                        payment.status!.toLowerCase() ==
                                            'unpaid')
                                    ? Text(
                                        "Edit",
                                        style: TextStyling.blueSmallTextStyle,
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          // : Text(
                          //     "Deduction ${currencyFormat(price: double.parse(controller.totalDeductions.toString()))} rwf",
                          //     style: TextStyling.formOrangeTextStyle,
                          //   ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 0.6,
                          ),
                          Divider(
                            thickness: 1.2,
                            color: textFormBorderColor,
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 1.5,
                          ),
                          Text(
                            "Total Take Home ${currencyFormat(price: double.parse(payrollWorker.takeHome.toString()))} rwf",
                            style: TextStyling.normalBoldTextStyle,
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 0.6,
                          ),
                          Divider(
                            thickness: 1.2,
                            color: textFormBorderColor,
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 1.5,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => Get.toNamed(
                                RouteLinks.homeWorkerPayroll,
                                arguments: {
                                  "payrollTransaction": payrollWorker,
                                  "project_id": project.projectId
                                }),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("View Payslip",
                                    style: TextStyling.formGreyTextStyle),
                                SvgPicture.asset(
                                  Images.arrorwRight,
                                  color: blackColor,
                                  height: SizeConfig.heightMultiplier * 1.3,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 1.5,
                          ),
                        ],
                      ),
              ));
        });
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

  _showModalDeductions(
      {required context,
      required int payrollId,
      required int paymentId,
      required int workerAssignedId}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        // context: context,
        builder: (context) {
          return GetBuilder<HomePayrollDetailsController>(
              initState: (_) => controller.getWorkerDeductions(
                  time: controller.mainController.dateTme.value,
                  projectId: project.projectId!,
                  payrollId: payrollId),
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
                                      paymentId: paymentId,
                                      payrollId: payrollId,
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
                                          workerAssignedId: workerAssignedId,
                                          paymentId: paymentId,
                                          deductionDate: controller
                                              .mainController.dateTme.value,
                                          project: project,
                                          payrollId: payrollId);
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

  _widgetDeductions(
      {required DeductionControllers deductionController,
      required BuildContext context,
      required int payrollId,
      required int paymentId}) {
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
                            project: project,
                            paymentId: paymentId,
                            payrollId: payrollId,
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

  _formText({required String text}) {
    return Text(
      text,
      style: TextStyling.nameProfileGreyTextStyle,
    );
  }
}
