// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors

import 'package:fixa/fixa_main_routes.dart';
import 'package:intl/intl.dart';

class HomeRegisterWorkerSaas extends GetWidget<RegisterWorkerController> {
  final Project project;
  final Services selectedService;

  HomeRegisterWorkerSaas(
      {Key? key, required this.project, required this.selectedService})
      : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgreyBlueGreyColor,
      body: Obx(
        () => SafeArea(
            child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset(
                        Images.leftArrowIcon,
                        color: blackColor,
                        width: SizeConfig.widthMultiplier * 6,
                      ),
                    ),
                    Text("Add new ${selectedService.name}",
                        style: TextStyling.nameProfileTextStyle),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset(
                        Images.leftArrowIcon,
                        color: lightgreyBlueGreyColor,
                        width: SizeConfig.widthMultiplier * 6,
                      ),
                    ),
                  ],
                ),
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
                    Text(
                      "Add New worker",
                      style: TextStyling.normalBoldTextStyle,
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 3),
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
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controller.firstName.value,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Insert worker first name';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Insert worker first name",
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              controller.islastName.value = true;
                              return 'Insert worker last name';
                            } else {
                              controller.islastName.value = false;
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Insert worker last name",
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
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                    "Male",
                                    style: controller.isGender.value
                                        ? TextStyling.formTextStyle
                                        : TextStyling.buttonWhiteTextStyle,
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
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                    "Female",
                                    style: !controller.isGender.value
                                        ? TextStyling.formTextStyle
                                        : TextStyling.buttonWhiteTextStyle,
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
                            hintText: "Select District",
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
                        padding: const EdgeInsets.only(
                            top: 4, bottom: 4, left: 8, right: 8),
                        child: TextFormField(
                          controller: controller.idVerificationNumber.value,
                          keyboardType: TextInputType.number,
                          maxLength: 16,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 16 ||
                                value.length > 16) {
                              return 'Please input a valid ID number';
                            } else if (controller.checkIfIDIsCorrect(
                                idDNumber: value)) {
                              return 'ID number is invalid';
                            } else if (controller.checkIfIdExist(
                                idNumber: value)) {
                              return 'Attention this id is already in use';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "16 digits",
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
            _formText(text: "Date Of Birth"),
            SizedBox(height: SizeConfig.heightMultiplier * 1.2),
                GestureDetector(
              onTap: () async {
                if(controller.workerInformation.value.dateOfBirth ==null || controller.workerInformation.value.dateOfBirth!.isEmpty){
                  var year = DateTime.now().year - 18;
                final datePicked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(year),
                    firstDate: DateTime(1950, 8),
                    lastDate: DateTime(year,DateTime.now().month));
                final DateFormat formatter = DateFormat('yyyy-MM-dd');
                final String formattedDate = formatter.format(datePicked!);
                    controller.dateOfBirth.value.text = formattedDate;
                    controller.dateOfBirthInput.value = formattedDate;
                }
                
              },
              child:  Container(
                  // height: SizeConfig.heightMultiplier * 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(color: greyLightColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 4, left: 8, right: 8),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 4,
                          vertical: SizeConfig.heightMultiplier * 1.2),
                      child: Text('${controller.dateOfBirthInput.value}',
                      // controller.dateOfBirth.value.text.isEmpty ? '' 'Select date of birth':"${controller.dateOfBirth.value.text}",
                        style: TextStyling.formTextStyle,
                      ),
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
                          border: Border.all(
                              color: controller.isphoneNumber.value
                                  ? redDark
                                  : greyLightColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 4, bottom: 4, left: 8, right: 8),
                        child: TextFormField(
                          controller: controller.phoneNumber.value,
                          keyboardType: TextInputType.phone,
                          autocorrect: false,
                          maxLength: 10,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 10 ||
                                value.length > 10) {
                              return 'Please input a valid phone number';
                            } else if (controller.checkIfPhoneNumberIsCorrect(
                                phoneNumber: value)) {
                              return 'Phone number is invalid';
                            } else if (controller.checkIfPhoneNumberExist(
                                phoneNumber: value)) {
                              return 'Attention this phone number is already in use';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "078xxxxxxx",
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
                    controller.serviceWidgets.isEmpty
                        ? Container()
                        : Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: lightgreyBlueGreyColor,
                                border: Border.all(color: greyLightColor),
                                borderRadius: BorderRadius.circular(4)),
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.serviceWidgets.length,
                                itemBuilder: (context, index) {
                                  return controller.serviceWidgets[index];
                                })),
                    SizedBox(height: SizeConfig.heightMultiplier * 1.2),
                    controller.serviceWidgets.isNotEmpty
                        ? Container()
                        : GestureDetector(
                            onTap: () =>
                                controller.addService(widget: _serviceWidget()),
                            child: _addService()),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                  ],
                ),
              )),
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 6),
                child: DefaultButton(
                  text: "Add worker",
                  press: () => controller.submit(
                      key: _formKey,
                      project: project,
                      selectedService: selectedService),
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 3),
            ],
          ),
        )),
      ),
    );
  }

  _serviceWidget() {
    return Padding(
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
          // _fieldServicesDropDownForm(
          //     hintText: "Select service", services: project.services!),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(color: greyLightColor),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: "${selectedService.name}",
                      border: InputBorder.none,
                      fillColor: whiteColor,
                      filled: true,
                      hintStyle: TextStyling.formTextStyle,
                      disabledBorder: InputBorder.none,
                    ),
                  ))),
          SizedBox(height: SizeConfig.heightMultiplier * 2),
          _formText(text: "Rate (Rwf)"),
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
                controller: controller.workerRate.value,
                keyboardType: TextInputType.number,
                autocorrect: false,
                validator: (value) {
                  var projectService = project.services!.where((item) => item.id.toString() == selectedService.id.toString()).toList();
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
                },
                decoration: InputDecoration(
                  hintText: "Insert rate",
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
    );
  }

  _addService() {
    return Padding(
      padding: EdgeInsets.only(right: SizeConfig.widthMultiplier * 45),
      child: Container(
        // width: SizeConfig.widthMultiplier * 12,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Images.plusIcon,
                color: appBarColorText,
                height: SizeConfig.heightMultiplier * 1.2,
              ),
              SizedBox(width: SizeConfig.widthMultiplier * 3),
              Text(
                "Add service",
                style: TextStyling.nameSmallGreyTextStyle,
              )
            ],
          ),
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