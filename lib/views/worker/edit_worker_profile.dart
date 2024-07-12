// ignore_for_file: unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_const_constructors

import 'package:fixa/fixa_main_routes.dart';

class HomeEditWorkerProfile extends GetWidget<EditWorkerProfileController> {
  final Project project;
  final String firstName;
  final String lastName;
  final String districtName;
  final String gender;
  final String idNUmber;
  final String rssbCode;
  final String phoneNUmber;
  final int workerId;
  final int assignedWorkerId;
  final String currentService;
  final String currentRate;
  final List<All> workerRates;
  HomeEditWorkerProfile({
    Key? key,
    required this.project,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.rssbCode,
    required this.idNUmber,
    required this.districtName,
    required this.phoneNUmber,
    required this.workerId,
    required this.assignedWorkerId,
    required this.workerRates,
    required this.currentRate,
    required this.currentService,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgreyBlueGreyColor,
      body: GetBuilder<EditWorkerProfileController>(
          init: EditWorkerProfileController(),
          initState: (_) => controller.setTextField(
              firstNam: firstName,
              lastNam: lastName,
              districtNam: districtName,
              gendr: gender,
              idNUmbr: idNUmber,
              phoneNUmbr: phoneNUmber),
          builder: (cons) {
            return SafeArea(
                child: Form(
              key: _formKey,
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 3,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 8),
                      child: appBar(text: "Edit Worker Profile"),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 3,
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 6),
                      child: ListView(
                        children: [
                          // Text(
                          //   "Edit worker profile",
                          //   style: TextStyling.normalBoldTextStyle,
                          // ),
                          SizedBox(height: SizeConfig.heightMultiplier * 4),
                          _formText(text: "First Name"),
                          SizedBox(height: SizeConfig.heightMultiplier * 1.2),
                          Container(
                            // height: SizeConfig.heightMultiplier * 6,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: whiteColor,
                                border: Border.all(color: greyLightColor),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.widthMultiplier * 4,
                                  vertical: SizeConfig.heightMultiplier * 0.5),
                              child: TextFormField(
                                controller: controller.firstName.value,
                                keyboardType: TextInputType.text,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  hintText: "${firstName}",
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
                          _formText(text: "Last Name"),
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
                              child: TextFormField(
                                controller: controller.lastName.value,
                                keyboardType: TextInputType.text,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  hintText: "${lastName}",
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
                          _formText(text: "Gender"),
                          SizedBox(height: SizeConfig.heightMultiplier * 1.2),
                          Container(
                            height: SizeConfig.heightMultiplier * 6,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: whiteColor,
                                border: Border.all(color: greyLightColor),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => controller.changeGender(),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: controller.isGender.value
                                              ? whiteColor
                                              : blueDark,
                                          // border: Border.all(color: greyLightColor),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Center(
                                        child: Text(
                                          "Male",
                                          style: controller.isGender.value
                                              ? TextStyling.formTextStyle
                                              : TextStyling
                                                  .buttonWhiteTextStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => controller.changeGender(),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: controller.isGender.value
                                              ? blueDark
                                              : whiteColor,
                                          // border: Border.all(color: greyLightColor),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Center(
                                        child: Text(
                                          "Female",
                                          style: !controller.isGender.value
                                              ? TextStyling.formTextStyle
                                              : TextStyling
                                                  .buttonWhiteTextStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 2),
                          _formText(text: "District Residence"),
                          SizedBox(height: SizeConfig.heightMultiplier * 1.2),
                          controller.isLoading.value
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: blueDark,
                                  ),
                                )
                              : _fieldDropDownForm(
                                  hintText: "select district",
                                  districts: controller.districts),
                          SizedBox(height: SizeConfig.heightMultiplier * 2),
                          _formText(text: "ID Number"),
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
                              child: TextFormField(
                                controller: controller.idNumber.value,
                                keyboardType: TextInputType.text,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  hintText: "${idNUmber}",
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
                          _formText(text: "RSSB Code"),
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
                              child: TextFormField(
                                controller: controller.rssbCodeText.value,
                                keyboardType: TextInputType.text,
                                autocorrect: false,
                                validator: (value) {
                                  if (value!.isNotEmpty && value.length != 9) {
                                    return 'RSSB Code must be 9 characters';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "${rssbCode}",
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

                          _formText(text: "Phone Number"),
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
                              child: TextFormField(
                                controller: controller.phoneNumber.value,
                                keyboardType: TextInputType.text,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  hintText: "${phoneNUmber}",
                                  border: InputBorder.none,
                                  fillColor: whiteColor,
                                  filled: true,
                                  hintStyle: TextStyling.formTextStyle,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 1.2),

                          _phoneVerification(),
                          SizedBox(height: SizeConfig.heightMultiplier * 2),
                          SizedBox(height: SizeConfig.heightMultiplier * 2),
                          _formText(text: "Current worker rate"),
                          SizedBox(height: SizeConfig.heightMultiplier * 1.2),
                          _serviceOffWidget(
                              rate: currentRate, service: currentService),
                          // ...workerRates.map((workerRate) => _serviceOffWidget(
                          //     rate: workerRate.value!.toString(),
                          //     service: workerRate.serviceName!)),
                          SizedBox(height: SizeConfig.heightMultiplier * 2),
                          ...controller.rateControllers.isEmpty
                              ? []
                              : controller.rateControllers.map(
                                  (rateController) =>
                                      _serviceWidget(rate: rateController)),
                          SizedBox(height: SizeConfig.heightMultiplier * 1.2),
                          SizedBox(height: SizeConfig.heightMultiplier * 1.2),
                          controller.serviceWidgets.isNotEmpty
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.only(
                                      right: SizeConfig.widthMultiplier * 45),
                                  child: GestureDetector(
                                    onTap: () => controller.addRate(),
                                    child: Container(
                                      // width: SizeConfig.widthMultiplier * 12,
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          border:
                                              Border.all(color: greyLightColor),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                SizeConfig.widthMultiplier *
                                                    2.5,
                                            vertical:
                                                SizeConfig.heightMultiplier *
                                                    0.5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              Images.plusIcon,
                                              color: appBarColorText,
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1.2,
                                            ),
                                            SizedBox(
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        3),
                                            Text(
                                              "Add service",
                                              style: TextStyling
                                                  .nameSmallGreyTextStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
                    )),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    controller.isSubmitLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: blueDark,
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 6),
                            child: DefaultButton(
                              text: "Save",
                              press: () async {
                                await controller.submit(
                                    context: context,
                                    projectId: project.projectId!,
                                    assignedWorkerId: assignedWorkerId,
                                    currentdistrictName: districtName,
                                    currentfirstName: firstName,
                                    rssbCode: rssbCode,
                                    currentidNumber: idNUmber,
                                    currentlastName: lastName,
                                    currentphoneNumber: phoneNUmber,
                                    key: _formKey,
                                    workersRates: workerRates,
                                    workerId: workerId);
                              },
                            ),
                          ),
                    SizedBox(height: SizeConfig.heightMultiplier * 3),
                  ],
                ),
              ),
            ));
          }),
    );
  }

  // _services() {
  //   return GetBuilder<EditWorkerProfileController>(
  //     init: EditWorkerProfileController(),
  //     initState: (_)=>,
  //     builder: (cons) {
  //       return Container(
  //           width: double.infinity,
  //           decoration: BoxDecoration(
  //               color: lightgreyBlueGreyColor,
  //               border: Border.all(color: greyLightColor),
  //               borderRadius: BorderRadius.circular(4)),
  //           child: ListView.builder(
  //               shrinkWrap: true,
  //               physics: const NeverScrollableScrollPhysics(),
  //               itemCount: controller.serviceWidgets.length,
  //               itemBuilder: (context, index) {
  //                 return controller.serviceWidgets[index];
  //               }));
  //     }
  //   );
  // }

  _serviceOffWidget({required String rate, required String service}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1.2,
            horizontal: SizeConfig.widthMultiplier * 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: greyLightColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.heightMultiplier * 1.2),
            _formText(text: "Service"),
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
                child: TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: "${service}",
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
            _formText(text: "Rate"),
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
                child: TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: "$rate Rwf",
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
    );
  }

  _serviceWidget({required DeductionControllers rate}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.heightMultiplier * 1.2,
          horizontal: SizeConfig.widthMultiplier * 4),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1.2,
            horizontal: SizeConfig.widthMultiplier * 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: greyLightColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _formText(text: "Service"),
                GestureDetector(
                  onTap: () => controller.removeService(),
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
                      hintText: "select a service",
                    ),
                    items: project.services!
                        .map((val) => DropdownMenuItem<Services>(
                              child: Text(val.name!),
                              value: val,
                            ))
                        .toList(),
                    onChanged: (value) {
                      rate.deductionTypeId = value!.id!;
                    }),
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 2),
            _formText(text: "Rate"),
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
                child: TextFormField(
                  controller: rate.deductedAmount,
                  keyboardType: TextInputType.number,
                  autocorrect: false,
                  validator: (value) {
                    if(rate.deductionTypeId == 0){
                      return 'Please select a Service';
                    }else {
                   var projectService = project.services!.where((item) => item.id.toString() == rate.deductionTypeId.toString()).toList();
                  if (value != null && projectService.isNotEmpty) {
                    if(projectService[0].maximumRate != null && projectService[0].maximumRate != '0'){
                    if(int.parse(value) <= int.parse(projectService[0].maximumRate!)){
                      return null;
                    }else {
                      return 'Amount should be less or equal to ${int.parse(projectService[0].maximumRate!)}';
                    }
                    }else {
                      return null;
                    }
                  } else {
                    return null;
                  }
                  }
                  },
                  decoration: InputDecoration(
                    hintText: "Insert worker rate",
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
    );
  }

  _phoneVerification() {
    return Obx(
      () => Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => controller.phoneVerified(),
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    color: controller.isPhoneNumberVerified.value
                        ? blueDark
                        : whiteColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: blueDark)),
              ),
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 4,
            ),
            Text(
              "Phone number is verified",
              style: TextStyling.nameProfileTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  _fieldDropDownForm(
      {required String hintText, required List<District> districts}) {
    return Container(
      // height: SizeConfig.heightMultiplier * 6,
      width: double.infinity,
      decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: greyLightColor),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonFormField<District>(
            value: controller.district.value.districtId != null
                ? controller.district.value
                : districts[0],
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
            items: districts
                .map((val) => DropdownMenuItem<District>(
                      child: Text(val.districtName!),
                      value: val,
                    ))
                .toList(),
            onChanged: (value) {
              controller.districtName.value = value!.districtName!;
            }),
      ),
    );
  }

  _formText({required String text}) {
    return Text(
      text,
      style: TextStyling.nameProfileGreyTextStyle,
    );
  }
}
