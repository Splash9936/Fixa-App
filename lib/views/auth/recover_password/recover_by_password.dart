// ignore_for_file: sized_box_for_whitespace

import 'package:fixa/fixa_main_routes.dart';

class HomeRecoverByPassword extends GetWidget<LoginController> {
  HomeRecoverByPassword({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 6),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(height: SizeConfig.heightMultiplier * 8),
                    // fixa logo
                    _fixaLogo(),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    // fixa picture login
                    _fixaLoginImage(),
                    SizedBox(height: SizeConfig.heightMultiplier * 4),
                    Text(
                      "Recover Password ",
                      style: TextStyling.nameProfileTextStyle,
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 4),
                    // login_form
                    Text(
                      "New Password : ",
                      style: TextStyling.greyTextStyle,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.8,
                    ),
                    _loginTextForm(
                        textController: controller.newPassword.value,
                        hintText: "Enter your New Password"),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    Text(
                      "Confirm Password : ",
                      style: TextStyling.greyTextStyle,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.8,
                    ),
                    _loginTextPasswordForm(
                        textController: controller.confirmPassword.value,
                        hintText: "Confirm your new password"),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.6,
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 6),
                    _button(text: 'Recover', key: _formKey),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),

                    // login button
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _fixaLogo() {
    return Center(
      child: SvgPicture.asset(
        Images.logoFixaIcon,
        height: SizeConfig.imageSizeMultiplier * 18,
      ),
    );
  }

  _fixaLoginImage() {
    return Center(
      child: SvgPicture.asset(
        Images.loginFixaIcon,
        // height: SizeConfig.heightMultiplier * 8,
      ),
    );
  }

  _loginTextForm(
      {required TextEditingController textController,
      required String hintText}) {
    return Obx(
      () => Container(
        // height: SizeConfig.heightMultiplier * 6,
        width: double.infinity,
        decoration: BoxDecoration(
            color: textFormColor.withOpacity(0.5),
            border: Border.all(color: greyLightColor),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            obscureText: controller.isNObscure.value,
            controller: textController,
            keyboardType: TextInputType.visiblePassword,
            autocorrect: false,
            validator: (value) {
              return controller.passwordValidator(value!);
            },
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              hintStyle: TextStyling.formBoldTextStyle,
              disabledBorder: InputBorder.none,
              suffixIcon: GestureDetector(
                onTap: () => controller.changeNPasswordObscure(),
                child: Container(
                  height: SizeConfig.heightMultiplier * 2,
                  width: SizeConfig.widthMultiplier * 10,
                  child: Center(
                    child: SvgPicture.asset(
                      Images.eyeIcon,
                      height: SizeConfig.heightMultiplier * 1.8,
                      width: SizeConfig.widthMultiplier * 8,
                      color: !controller.isNObscure.value
                          ? blueDark
                          : lightBlueGreyColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _loginTextPasswordForm(
      {required TextEditingController textController,
      required String hintText}) {
    return Obx(
      () => Container(
        // height: SizeConfig.heightMultiplier * 6,
        width: double.infinity,
        decoration: BoxDecoration(
            color: textFormColor.withOpacity(0.5),
            border: Border.all(color: greyLightColor),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            obscureText: controller.isCObscure.value,
            controller: textController,
            keyboardType: TextInputType.visiblePassword,
            autocorrect: false,
            validator: (value) {
              return controller.passwordValidator(value!);
            },
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              hintStyle: TextStyling.formBoldTextStyle,
              disabledBorder: InputBorder.none,
              suffixIcon: GestureDetector(
                onTap: () => controller.changeCPasswordObscure(),
                child: Container(
                  height: SizeConfig.heightMultiplier * 2,
                  width: SizeConfig.widthMultiplier * 10,
                  child: Center(
                    child: SvgPicture.asset(
                      Images.eyeIcon,
                      height: SizeConfig.heightMultiplier * 1.8,
                      width: SizeConfig.widthMultiplier * 8,
                      color: !controller.isCObscure.value
                          ? blueDark
                          : lightBlueGreyColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _button({required String text, required GlobalKey<FormState> key}) {
    return GestureDetector(
      child: Container(
        height: SizeConfig.heightMultiplier * 6,
        decoration: BoxDecoration(
          color: blueColorText,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyling.buttonWhiteTextStyle,
        )),
      ),
    );
  }
}
