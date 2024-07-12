// ignore_for_file: prefer_const_constructors

import 'package:fixa/fixa_main_routes.dart';

class HomeRecoverPasswordEmail extends GetWidget<ForgotPasswordController> {
  HomeRecoverPasswordEmail({Key? key}) : super(key: key);
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
                      "Email : ",
                      style: TextStyling.greyTextStyle,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.8,
                    ),
                    Container(
                      // height: SizeConfig.heightMultiplier * 6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: textFormColor.withOpacity(0.5),
                          border: Border.all(color: greyLightColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controller.email.value,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          validator: (value) {
                            return controller.emailValidator(value!);
                          },
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            border: InputBorder.none,
                            hintStyle: TextStyling.formBoldTextStyle,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    SizedBox(height: SizeConfig.heightMultiplier * 6),
                    _button(text: 'Recover', key: _formKey, context: context),
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

  _button(
      {required String text,
      required GlobalKey<FormState> key,
      required BuildContext context}) {
    return Obx(
      () => controller.isLoading.value
          ? Center(
              child: CircularProgressIndicator(
                color: blueColorText,
              ),
            )
          : GestureDetector(
              onTap: () async {
                var status = await controller.submit(key: key);
                if (status) {
                  Navigator.pop(context);
                }
              },
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
            ),
    );
  }
}
