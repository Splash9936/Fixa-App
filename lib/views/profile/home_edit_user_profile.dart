// ignore_for_file: sized_box_for_whitespace

import 'package:fixa/fixa_main_routes.dart';

class HomeEditUserProfile extends GetWidget<EditProfileController> {
  final UserDetails userInfo;
  HomeEditUserProfile({Key? key, required this.userInfo}) : super(key: key);
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
                      horizontal: SizeConfig.widthMultiplier * 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!controller.isPassword.value) {
                            Get.back();
                          } else {
                            controller.setIsPassword();
                          }
                        },
                        child: SvgPicture.asset(
                          Images.leftArrowIcon,
                          color: blackColor,
                          width: SizeConfig.widthMultiplier * 6,
                        ),
                      ),
                      SizedBox(width: SizeConfig.widthMultiplier * 25),
                      Text("Edit profile",
                          style: TextStyling.nameProfileTextStyle)
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                controller.isPassword.value
                    ? Expanded(
                        child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 6),
                        child: ListView(
                          children: [
                            Text(
                              "Change password",
                              style: TextStyling.nameSmallGreyTextStyle,
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 2),
                            _formText(text: "Current Password"),
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
                                    vertical:
                                        SizeConfig.heightMultiplier * 0.5),
                                child: TextFormField(
                                  obscureText: controller.isOldPassword.value,
                                  controller: controller.currentPassword.value,
                                  keyboardType: TextInputType.text,
                                  autocorrect: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Insert current password';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Insert current password",
                                    border: InputBorder.none,
                                    fillColor: whiteColor,
                                    filled: true,
                                    hintStyle: TextStyling.formTextStyle,
                                    disabledBorder: InputBorder.none,
                                    suffixIcon: GestureDetector(
                                      onTap: () => controller.setOldPassword(),
                                      child: Container(
                                        height: SizeConfig.heightMultiplier * 2,
                                        width: SizeConfig.widthMultiplier * 10,
                                        child: Center(
                                          child: controller.isOldPassword.value
                                              ? SvgPicture.asset(
                                                  Images.eyeSlashedIcon,
                                                  height: SizeConfig
                                                          .heightMultiplier *
                                                      1.8,
                                                  width: SizeConfig
                                                          .widthMultiplier *
                                                      8,
                                                  color: lightBlueGreyColor,
                                                )
                                              : SvgPicture.asset(
                                                  Images.eyeIcon,
                                                  height: SizeConfig
                                                          .heightMultiplier *
                                                      1.8,
                                                  width: SizeConfig
                                                          .widthMultiplier *
                                                      8,
                                                  color:blueDark,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 2),
                            _formText(text: "New Password"),
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
                                    vertical:
                                        SizeConfig.heightMultiplier * 0.5),
                                child: TextFormField(
                                  obscureText: controller.isNewPassword.value,
                                  controller: controller.newPassword.value,
                                  keyboardType: TextInputType.text,
                                  autocorrect: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Insert new password';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Insert new password",
                                    border: InputBorder.none,
                                    fillColor: whiteColor,
                                    filled: true,
                                    hintStyle: TextStyling.formTextStyle,
                                    disabledBorder: InputBorder.none,
                                    suffixIcon: GestureDetector(
                                      onTap: () => controller.setNewPassword(),
                                      child: Container(
                                        height: SizeConfig.heightMultiplier * 2,
                                        width: SizeConfig.widthMultiplier * 10,
                                        child: Center(
                                          child: controller.isNewPassword.value
                                              ? SvgPicture.asset(
                                                  Images.eyeSlashedIcon,
                                                  height: SizeConfig
                                                          .heightMultiplier *
                                                      1.8,
                                                  width: SizeConfig
                                                          .widthMultiplier *
                                                      8,
                                                  color: lightBlueGreyColor,
                                                )
                                              : SvgPicture.asset(
                                                  Images.eyeIcon,
                                                  height: SizeConfig
                                                          .heightMultiplier *
                                                      1.8,
                                                  width: SizeConfig
                                                          .widthMultiplier *
                                                      8,
                                                  color: blueDark,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 2),
                            _formText(text: "Confirm New Password"),
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
                                    vertical:
                                        SizeConfig.heightMultiplier * 0.5),
                                child: TextFormField(
                                  obscureText:
                                      controller.isConfirmPassword.value,
                                  controller: controller.confirmPassword.value,
                                  keyboardType: TextInputType.text,
                                  autocorrect: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Insert confirmation password';
                                    } else if (value !=
                                        controller.newPassword.value.text) {
                                      return 'Confirm password and new password do not match.';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Insert confirm new password",
                                    border: InputBorder.none,
                                    fillColor: whiteColor,
                                    filled: true,
                                    hintStyle: TextStyling.formTextStyle,
                                    disabledBorder: InputBorder.none,
                                    suffixIcon: GestureDetector(
                                      onTap: () =>
                                          controller.setConfirmPassword(),
                                      child: Container(
                                        height: SizeConfig.heightMultiplier * 2,
                                        width: SizeConfig.widthMultiplier * 10,
                                        child: Center(
                                          child:
                                              controller.isConfirmPassword.value
                                                  ? SvgPicture.asset(
                                                      Images.eyeSlashedIcon,
                                                      height: SizeConfig
                                                              .heightMultiplier *
                                                          1.8,
                                                      width: SizeConfig
                                                              .widthMultiplier *
                                                          8,
                                                      color: lightBlueGreyColor,
                                                    )
                                                  : SvgPicture.asset(
                                                      Images.eyeIcon,
                                                      height: SizeConfig
                                                              .heightMultiplier *
                                                          1.8,
                                                      width: SizeConfig
                                                              .widthMultiplier *
                                                          8,
                                                      color: blueDark,
                                                    ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 2),
                          ],
                        ),
                      ))
                    : Expanded(
                        child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 6),
                        child: ListView(
                          children: [
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
                                    vertical:
                                        SizeConfig.heightMultiplier * 0.5),
                                child: TextFormField(
                                  controller: controller.firstName.value,
                                  keyboardType: TextInputType.text,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    hintText: "${userInfo.firstName}",
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.widthMultiplier * 4,
                                    vertical:
                                        SizeConfig.heightMultiplier * 0.5),
                                child: TextFormField(
                                  controller: controller.lastName.value,
                                  keyboardType: TextInputType.text,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    hintText: "${userInfo.lastName}",
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
                            _formText(text: "Email"),
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
                                    vertical:
                                        SizeConfig.heightMultiplier * 0.5),
                                child: TextFormField(
                                  controller: controller.email.value,
                                  keyboardType: TextInputType.text,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    hintText: "${userInfo.email}",
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.widthMultiplier * 4,
                                    vertical:
                                        SizeConfig.heightMultiplier * 0.5),
                                child: TextFormField(
                                  controller: controller.phoneNumber.value,
                                  keyboardType: TextInputType.text,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    hintText: "${userInfo.username}",
                                    border: InputBorder.none,
                                    fillColor: whiteColor,
                                    filled: true,
                                    hintStyle: TextStyling.formTextStyle,
                                    disabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 4),
                            Padding(
                              padding: EdgeInsets.only(
                                right: SizeConfig.widthMultiplier * 30,
                              ),
                              child: GestureDetector(
                                onTap: () => controller.setIsPassword(),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.widthMultiplier * 2.5,
                                      vertical:
                                          SizeConfig.heightMultiplier * 1.5),
                                  decoration: BoxDecoration(
                                      color: whiteColor,
                                      border: Border.all(color: greyLightColor),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text(
                                      "Change password",
                                      style: TextStyling.nameSmallGreyTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                controller.isSubmiting.value
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
                            if (controller.isPassword.value) {
                              controller.changePassword(
                                key: _formKey,
                              );
                            } else {
                              await controller.submit(
                                  key: _formKey,
                                  currentfirstName: userInfo.firstName!,
                                  currentlastName: userInfo.lastName!,
                                  currentemail: userInfo.email!,
                                  currentphoneNumber: userInfo.username!);
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                SizedBox(height: SizeConfig.heightMultiplier * 3),
              ],
            ),
          )),
        ));
  }

  _formText({required String text}) {
    return Text(
      text,
      style: TextStyling.nameProfileGreyTextStyle,
    );
  }
}
