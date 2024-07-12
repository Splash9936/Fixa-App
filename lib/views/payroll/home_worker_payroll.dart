// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:fixa/fixa_main_routes.dart';

class HomeWorkerPayroll extends GetWidget<HomeWorkerPayrollController> {
  final PayrollTransactions payrollTransaction;
  final int projectId;
  const HomeWorkerPayroll(
      {Key? key, required this.payrollTransaction, required this.projectId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: GetBuilder<HomeWorkerPayrollController>(
            init: HomeWorkerPayrollController(),
            initState: (_) => controller.getData(
                payrollTransactionId: payrollTransaction.id!),
            builder: (cons) {
              return SafeArea(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 4,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 4),
                        child: _appBar()),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    _appWorkerInfo(totalDeductions: 0, context: context),
                    // controller.isLoading
                    //     ? Container()
                    //     : Obx(() => _appWorkerInfo(
                    //         totalDeductions: 0, context: context)),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.2,
                    ),
                    controller.isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: blueDark,
                            ),
                          )
                        : controller.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: blueDark,
                                ),
                              )
                            : Expanded(
                                child: Obx(
                                () => ListView.builder(
                                    itemCount:
                                        controller.payrollAttendance.length,
                                    itemBuilder: (context, index) {
                                      var date = DateTime.parse(controller
                                          .payrollAttendance[index].date!);
                                      return Container(
                                        decoration: BoxDecoration(
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
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
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
                                                    color: textFormBorderColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(nameCapitalised(
                                                      controller
                                                          .payrollAttendance[
                                                              index]
                                                          .serviceName)),
                                                  SizedBox(
                                                    width: SizeConfig
                                                            .widthMultiplier *
                                                        3,
                                                  ),
                                                  Text(nameCapitalised(
                                                      controller
                                                          .payrollAttendance[
                                                              index]
                                                          .shiftName)),
                                                  SizedBox(
                                                    width: SizeConfig
                                                            .widthMultiplier *
                                                        3,
                                                  ),
                                                  Text(
                                                      "${currencyFormat(price: double.parse(controller.payrollAttendance[index].value.toString()))} Rwf"),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              )),
                  ],
                ),
              ));
            }));
  }

  _formText({required String text}) {
    return Text(
      text,
      style: TextStyling.nameProfileGreyTextStyle,
    );
  }

  _widgetListDeductions({required Deductions deduction}) {
    var dedeductionType = [];
    // controller.deductionsTypes
    //     .where((item) => item.id == deduction.deductionTypeId)
    //     .toList();
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
                            "Deductions",
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
                    // ...controller.deductions.isEmpty
                    //     ? []
                    //     : controller.deductions.map((deductionController) =>
                    //         _widgetListDeductions(
                    //             deduction: deductionController)),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.3,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _appWorkerInfo(
      {required int totalDeductions, required BuildContext context}) {
    return Container(
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
                  Text("${payrollTransaction.workerName}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyling.blueTextStyle),
                  Text(
                      "Total: ${currencyFormat(price: double.parse(payrollTransaction.takeHome!))} Rwf",
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
                      "Day: ${payrollTransaction.dayShifts} days,  ${currencyFormat(price: double.parse((payrollTransaction.dayShifts! * int.parse(payrollTransaction.dailyRate!)).toString()))} Rwf",
                      style: TextStyling.blueSmallTextStyle),
                  Text(
                      "Night: ${payrollTransaction.nightShifts} days,  ${currencyFormat(price: double.parse((payrollTransaction.nightShifts! * int.parse(payrollTransaction.dailyRate!)).toString()))} Rwf",
                      style: TextStyling.blueSmallTextStyle),
                  Text(
                    "Deduction: ${currencyFormat(price: double.parse(payrollTransaction.totalDeductions!))} Rwf",
                    style: TextStyling.redSmallTextStyle,
                  ),
                  // GestureDetector(
                  //   // onTap: () => _showModalDeductions(context: context),
                  //   child: Row(
                  //     children: [
                  //       // Text(
                  //       //   "Deduction: ${currencyFormat(price: double.parse(payrollTransaction.totalDeductions!))} Rwf",
                  //       //   style: TextStyling.redSmallTextStyle,
                  //       // ),
                  //       // SizedBox(width: SizeConfig.widthMultiplier * 1.3),
                  //       // Container(
                  //       //     height: 20,
                  //       //     width: 20,
                  //       //     decoration: BoxDecoration(
                  //       //         border: Border.all(color: orangeLightDark),
                  //       //         borderRadius: BorderRadius.circular(4)),
                  //       //     child: Padding(
                  //       //       padding: const EdgeInsets.all(1.5),
                  //       //       child: SvgPicture.asset(Images.penIcon,
                  //       //           height: 15,
                  //       //           width: 15,
                  //       //           color: orangeLightDark),
                  //       //     )),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _appBar() {
    return Container(
      height: SizeConfig.heightMultiplier * 6,
      width: double.infinity,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: SvgPicture.asset(
              Images.leftArrowIcon,
              color: blackColor,
              width: SizeConfig.widthMultiplier * 4,
            ),
          ),
          Text("Payslip", style: TextStyling.nameProfileTextStyle),
          GestureDetector(
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
}
