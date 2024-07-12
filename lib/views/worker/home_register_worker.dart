// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:fixa/fixa_main_routes.dart';
import 'package:intl/intl.dart';

class HomeRegisterWorker extends GetWidget<RegisterWorkerController> {
  final Project project;
  final Services selectedService;

  HomeRegisterWorker(
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
                    Text("Add new Worker",
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
              controller.isNationalitySelected.value
                  ? _workerRegistration(context: context)
                  : _nidWorkerSearching(),
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              controller.isNationalitySelected.value
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 6),
                      child: DefaultButton(
                        text: "Add worker",
                        press: () {
                          if (controller.dateOfBirth.value.text.isEmpty) {
                            negativeMessage(
                                message: 'Please Select a Date Of Birth');
                          } 
                          // else if (controller.checkIfIdExist(
                          //     idNumber:
                          //         controller.idVerificationNumber.value.text)) {
                          //   negativeMessage(
                          //       message: 'Id number already in use');
                          // } else if (controller.checkIfPhoneNumberIsCorrect(
                          //     phoneNumber: controller.phoneNumber.value.text)) {
                          //   negativeMessage(
                          //       message: 'phone number format is incorrect');
                          // } else if (controller.checkIfPhoneNumberExist(
                          //     phoneNumber: controller.phoneNumber.value.text)) {
                          //   negativeMessage(
                          //       message: 'Phone number already in use');
                          // } 
                          else {
                            controller.submit(
                                key: _formKey,
                                project: project,
                                selectedService: selectedService.id == 0
                                    ? controller.serviceSelected.value
                                    : selectedService);
                          }
                        },
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 6),
                      child: controller.isSubmitLoading.value
                          ? Center(
                              child: CircularProgressIndicator(color: blueDark))
                          : DefaultButton(
                              text: "Submit",
                              press: () {
                                if (controller.idVerificationNumber.value.text
                                        .isEmpty ||
                                    controller.idVerificationNumber.value.text
                                            .length >
                                        16 ||
                                    controller.idVerificationNumber.value.text
                                            .length <
                                        16 ||
                                    controller.checkIfIDIsCorrect(
                                        idDNumber: controller
                                            .idVerificationNumber.value.text)== false) {
                                  negativeMessage(
                                      message: 'The ID number is invalid');
                                } else if (controller.checkIfIdExist(
                                    idNumber: controller
                                        .idVerificationNumber.value.text)) {
                                  negativeMessage(
                                      message:
                                          'Attention this id is already in use');
                                } else {
                                  controller.searchingNid(
                                      nid: controller
                                          .idVerificationNumber.value.text);
                                }
                              },
                            ),
                    ),
              SizedBox(height: SizeConfig.heightMultiplier * 3),
            ],
          ),
        )),
      ),
    );
  }

  _nidWorkerSearching() {
    return Obx(
      () => Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      onTap: () => controller.changeNationality(),
                      child: Container(
                        decoration: BoxDecoration(
                            color: controller.isForeigner.value
                                ? whiteColor
                                : blueDark,
                            // border: Border.all(color: greyLightColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            "Rwandan",
                            style: controller.isForeigner.value
                                ? TextStyling.formTextStyle
                                : TextStyling.buttonWhiteTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.changeNationality(),
                      child: Container(
                        decoration: BoxDecoration(
                            color: controller.isForeigner.value
                                ? blueDark
                                : whiteColor,
                            // border: Border.all(color: greyLightColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            "Foreigner",
                            style: !controller.isForeigner.value
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
                padding:
                    const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
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
                        idDNumber: value) == false) {
                      return 'ID number is invalid';
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
          ],
        ),
      ),
    );
  }

  _workerRegistration({required BuildContext context}) {
    return Obx(
      () => Expanded(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 6),
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
                  enabled: controller.workerInformation.value.firstName != null
                      ? false
                      : true,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insert worker first name';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: controller.workerInformation.value.firstName ??
                        "Insert worker first name",
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
                  enabled: controller.workerInformation.value.lastName != null
                      ? false
                      : true,
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
                    hintText: controller.workerInformation.value.lastName ??
                        "Insert worker last name",
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
            _formText(text: "Country"),
            SizedBox(height: SizeConfig.heightMultiplier * 1.2),
            controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: blueDark,
                    ),
                  )
                : _fieldDropDownForm(
                    hintText: "Select Country",
                    countries: controller.countries),
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
                padding:
                    const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
                child: TextFormField(
                  controller: controller.idVerificationNumber.value,
                  enabled: controller.isIdNumberLocked.value == true ?  false:true,
                  keyboardType: TextInputType.number,
                  maxLength: null,
                  autocorrect: false,
                  validator: (value) {
                    if (controller.checkIfIdExist(idNumber: value!)) {
                        return 'Attention this id is already in use';
                      }
                      if(getCountryName(countryId: controller.countryId.value, countries: controller.countries).toLowerCase() == "rwanda" && controller.checkIfIDIsCorrect(idDNumber: value)== false){
                          return 'ID number is invalid';
                        
                      }
                      return null;
                  },
                  decoration: InputDecoration(
                    hintText: controller.idVerificationNumber.value.text.isEmpty
                        ? "Insert ID number"
                        : controller.idVerificationNumber.value.text,
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
                if (controller.workerInformation.value.dateOfBirth == null ||
                    controller.workerInformation.value.dateOfBirth!.isEmpty) {
                  var year = DateTime.now().year - 18;
                  final datePicked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(year),
                      firstDate: DateTime(1950, 8),
                      lastDate: DateTime(year, DateTime.now().month));
                  final DateFormat formatter = DateFormat('yyyy-MM-dd');
                  final String formattedDate = formatter.format(datePicked!);
                  controller.dateOfBirth.value.text = formattedDate;
                  controller.dateOfBirthInput.value = formattedDate;
                }
              },
              child: Container(
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
                    child: Text(
                      '${controller.dateOfBirthInput.value}',
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
                padding:
                    const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
                child: TextFormField(
                  controller: controller.phoneNumber.value,
                  keyboardType: TextInputType.phone,
                  autocorrect: false,
                  maxLength: 10,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      if (value.length < 10 || value.length > 10) {
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
            // SizedBox(height: SizeConfig.heightMultiplier * 1.2),
            // _phoneVerification(),
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
          selectedService.id == 0
              ? _fieldDropDownServicesForm(
                  hintText: 'Select a service', services: project.services!)
              : Container(
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
                inputFormatters: [CurrencyInputFormatter()],
                validator: (value) {
                  var newValue = value!.replaceAll(',', '');

                  var projectService = project.services!
                      .where((item) =>
                          item.id.toString() == selectedService.id.toString())
                      .toList();
                  if (newValue != null && projectService.isNotEmpty) {
                    if (projectService[0].maximumRate != null &&
                        projectService[0].maximumRate != '0') {
                      if (int.parse(newValue) <=
                          int.parse(projectService[0].maximumRate!)) {
                        return null;
                      } else {
                        return 'Amount should be less or equal to ${int.parse(projectService[0].maximumRate!)}';
                      }
                    } else {
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

  _fieldDropDownForm(
      {required String hintText, required List<Country> countries}) {
    return Obx(
      () => controller.isForeigner.value
          ? Container(
              // height: SizeConfig.heightMultiplier * 6,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(color: greyLightColor),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<Country>(
                    value: countries[0],
                    isExpanded: true,
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
                    items: countries
                        .map((val) => DropdownMenuItem<Country>(
                              child: Text(val.countryName!),
                              value: val,
                            ))
                        .toList(),
                    onChanged: (value) {
                      controller.countryId.value = value!.id!;
                    }),
              ),
            )
          : Container(
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
                  decoration: InputDecoration(
                    hintText: "Rwanda",
                    border: InputBorder.none,
                    fillColor: whiteColor,
                    filled: true,
                    hintStyle: TextStyling.formTextStyle,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
    );
  }

  _fieldDropDownServicesForm(
      {required String hintText, required List<Services> services}) {
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
            // value: services[0] ,
            isExpanded: true,
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
            validator: (value) {
              if (controller.serviceSelected.value.id == null) {
                return 'Please select a service';
              }
              return null;
            },
            items: services
                .map((val) => DropdownMenuItem<Services>(
                      child: Text(val.name!),
                      value: val,
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                controller.serviceSelected.value = value;
              }
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

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    //  final formatter = NumberFormat("#,##0", "en_US");
    final valueCurrency =
        newValue.text.isEmpty ? '0' : newValue.text.replaceAll(',', '');
    return TextEditingValue(
      text: NumberFormat("#,##0", "en_US").format(double.parse(valueCurrency)),
      selection: TextSelection.collapsed(
          offset: NumberFormat("#,##0", "en_US")
              .format(double.parse(valueCurrency))
              .length),
    );
  }
}
