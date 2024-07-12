// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:fixa/fixa_main_routes.dart';

class HomeSelectBusiness extends GetWidget<LoginController> {
   HomeSelectBusiness({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    _fixaLoginImage(),
              SizedBox(height: SizeConfig.heightMultiplier * 4),
               Text(
                  "Welcome ",
                  style: TextStyling.nameProfileTextStyle,
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                _cardProject(appEnv: appValuesEnv),
                ],
              )),
            
              
                _button(text: 'Next'),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                
            ],
          ),
        ),
      ),
    );
  }

  _cardProject({required List<AppValues> appEnv}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 2,
      child: Container(
        height: SizeConfig.heightMultiplier * 14,
        width: double.infinity,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                    "Business Name ",
                    style: TextStyling.buttonTextStyle,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 2),
                child:   Container(
                  decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: greyLightColor),
          borderRadius: BorderRadius.circular(4)),
                  child: DropdownButtonFormField<AppValues>(
                  icon:  Icon(
                    Icons.arrow_drop_down,
                    color: blackColor,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: whiteColor,
                    hintStyle: TextStyling.formTextStyle,
                    filled: true,
                    hintText: AppConfig.instance.appValues!.appTitle,
                  ),
                  items: appEnv
                      .map((val) => DropdownMenuItem<AppValues>(
                            child: Text(val.appTitle!),
                            value: val,
                          ))
                      .toList(),
                  onChanged: (value) {
                    controller.appValue.value = value!;
                    // AppConfig(appValues: value!);
                    
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  
  }

  _fixaLoginImage() {
    return Center(
      child: SvgPicture.asset(
        Images.loginFixaIcon,
        height: SizeConfig.heightMultiplier * 23,
      ),
    );
  }
  _button({required String text}) {
    return Obx(() => controller.isLoading.value
        ? Container()
        : GestureDetector(
            onTap: () async{
             await controller.changeCompany(appValues: AppValues(isConfirmed: true,appTitle: controller.appValue.value.appTitle, loginIcon: controller.appValue.value.loginIcon, logoIcon: controller.appValue.value.logoIcon, baseUrl: controller.appValue.value.baseUrl, lottie: controller.appValue.value.lottie));
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
          ));
  }
}