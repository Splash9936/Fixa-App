// ignore_for_file: prefer_const_constructors

import 'package:fixa/fixa_main_routes.dart';

class HomeUserProfile extends GetWidget<MainController> {
  const HomeUserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgreyBlueGreyColor,
      body: SafeArea(
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
                child: appBar(text: "User profile"),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
              ),
              Center(
                child: CircleAvatar(
                  maxRadius: SizeConfig.widthMultiplier * 20,
                  minRadius: SizeConfig.widthMultiplier * 20,
                  backgroundColor: textFormColor,
                  child: Center(
                    child: Text(
                      "${checkForStringNull(controller.userInfo.value.firstName, "no name")[0].toString().toUpperCase()}${checkForStringNull(controller.userInfo.value.lastName, "no name")[0].toString().toUpperCase()}",
                      style: TextStyling.formBlueTextStyle,
                    ),
                  ),
                  // backgroundImage: AssetImage(Images.workerImg),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Center(
                child: Text(
                  " ${nameCapitalised(controller.userInfo.value.firstName)} ${nameCapitalised(controller.userInfo.value.lastName)}",
                  style: TextStyling.bigTextStyle,
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Center(
                child: Text(
                  controller.userInfo.value.username ?? "no phone number",
                  style: TextStyling.greyTextStyle,
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Center(
                child: Text(
                  controller.userInfo.value.email ?? "no email",
                  style: TextStyling.greyTextStyle,
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 8),
                child: DefaultButton(
                    text: "Edit profile",
                    press: () =>
                        Get.toNamed(RouteLinks.homeEditUserProfile, arguments: {
                          "user_info": controller.userInfo.value,
                        })),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 8),
                child: DefaultButtonEmpty(
                  text: "Logout",
                  press: () async {
                    await controller.signedOut();
                  },
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 8),
                child: GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                    width: double.infinity,
                    height: SizeConfig.heightMultiplier * 7.4,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(redColor)),
                      onPressed: () => _openDialog(),
                      child: Text(
                        "Delete Account",
                        style: TextStyling.buttonWhiteTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _openDialog() {
    return Get.dialog(AlertDialog(
      content: Text(
        "Are you sure you want to delete your account",
        textAlign: TextAlign.center,
        style: TextStyling.nameProfileTextStyle,
      ),
      actions: [
        TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'No',
              style: TextStyling.nameProfileTextStyle,
            )),
        TextButton(
            onPressed: () async => await controller.deleteUser(
                workerId: controller.userInfo.value.id!),
            child: Text(
              'Yes',
              style: TextStyling.blueTextStyle,
            ))
      ],
    ));
  }
}
