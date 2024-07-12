// ignore_for_file: sized_box_for_whitespace

import 'package:fixa/fixa_main_routes.dart';

class HomeLogin extends GetWidget<LoginController> {
  HomeLogin({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.appValue.value.isConfirmed!
        ? _fixaLoginMethod()
        : HomeSelectBusiness());
  }

   _fixaLoginMethod() {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 6),
          child: Form(
            key: _formKey,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                 _fixaLogo(),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  // fixa picture login
                  _fixaLoginImage(),
                  SizedBox(height: SizeConfig.heightMultiplier * 4),
                  Text(
                    "Login ",
                    style: TextStyling.nameProfileTextStyle,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 4),
                  // login_form
                  Text(
                    "Email : ",
                    style: TextStyling.greyTextStyle,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 0.8,
                  ),
                  _loginTextForm(
                      textController: controller.email.value,
                      hintText: "Enter your email"),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  Text(
                    "Password : ",
                    style: TextStyling.greyTextStyle,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 0.8,
                  ),
                  _loginTextPasswordForm(
                      textController: controller.password.value,
                      hintText: "Enter your password"),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.6,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => controller.changeRemberMe(),
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              color: controller.isRemberMe.value
                                  ? blueDark
                                  : whiteColor,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: greyBlackColorText)),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 4,
                      ),
                      Text(
                        "Remember me",
                        style: TextStyling.greyTextStyle,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () =>
                            Get.toNamed(RouteLinks.recoverPasswordEmail),
                        child: Text(
                          "Forgot password",
                          style: TextStyling.blueTextStyle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 6),
                  _button(text: 'Login', key: _formKey),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                ],
              ),
            ),
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   // ignore: prefer_const_literals_to_create_immutables
            //   children: [
            //     // SizedBox(height: SizeConfig.heightMultiplier * 8),
            //     // fixa logo
            //     _fixaLogo(),
            //     SizedBox(height: SizeConfig.heightMultiplier * 2),
            //     // fixa picture login

            //     // _fixaLoginImage(),

            //     // login button
            //   ],
            // ),
          ),
        ),
      ),
    );
  }

  _fixaLogo() {
    return Center(
      child: SvgPicture.asset(
        Images.logoFixaIcon,
        height: SizeConfig.imageSizeMultiplier * 12,
      ),
    );
  }

  _fixaLoginImage() {
    return Obx(
      () => controller.isLoading.value
          ? lottieLoading(sizeConfigHeight: 16)
          : SvgPicture.asset(
              Images.loginFixaIcon,
              height: SizeConfig.heightMultiplier * 18,
            ),
    );
  }

  _loginTextForm(
      {required TextEditingController textController,
      required String hintText}) {
    return Container(
      // height: SizeConfig.heightMultiplier * 6,
      width: double.infinity,
      decoration: BoxDecoration(
          color: textFormColor.withOpacity(0.5),
          border: Border.all(color: greyLightColor),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: textController,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          validator: (value) {
            return controller.emailValidator(value!);
          },
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: TextStyling.formBoldTextStyle,
            disabledBorder: InputBorder.none,
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
            obscureText: controller.isObscure.value,
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
                onTap: () => controller.changePasswordObscure(),
                child: Container(
                  height: SizeConfig.heightMultiplier * 2,
                  width: SizeConfig.widthMultiplier * 10,
                  child: Center(
                    child: SvgPicture.asset(
                      Images.eyeIcon,
                      height: SizeConfig.heightMultiplier * 1.8,
                      width: SizeConfig.widthMultiplier * 8,
                      color: !controller.isObscure.value
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
    return Obx(() => controller.isLoading.value
        ? Container()
        : GestureDetector(
            onTap: () => controller.submitLogin(key: key),
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
          ));
  }
}
