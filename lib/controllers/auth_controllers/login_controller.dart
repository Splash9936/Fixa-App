import 'package:fixa/fixa_main_routes.dart';

class LoginController extends GetxController {
  final AuthenticationController _authenticationController = Get.find();
  final _databaseService = DataProvider();
  RxBool isLoading = false.obs;
  RxBool isObscure = true.obs;
  RxBool isNObscure = true.obs;
  RxBool isCObscure = true.obs;
  RxBool isRemberMe = false.obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> emailPassword = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> newPassword = TextEditingController().obs;
  Rx<TextEditingController> confirmPassword = TextEditingController().obs;
  Rx<AppValues> appValue = AppConfig.instance.appValues!.obs;

  changeCompany({required AppValues appValues}) async{
    appValue.value = appValues;
    AppConfig.instance.updateAppValues(appValues);
   await _databaseService.updateAppFlavorInfo(appValue: appValues);
  }

  // email validator
  String? emailValidator(String value) {
    if (value.isEmpty || !value.contains('@')) {
      return 'Please, Input a correct email';
    }
    return null;
  }

  // password validator
  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Please, Input a password';
    }
    return null;
  }

  void changeRemberMe() {
    isRemberMe.value = !isRemberMe.value;
  }

  void changePasswordObscure() {
    isObscure.value = !isObscure.value;
  }

  void changeNPasswordObscure() {
    isNObscure.value = !isNObscure.value;
  }

  void changeCPasswordObscure() {
    isCObscure.value = !isCObscure.value;
  }

  // login
  void submitLogin({required GlobalKey<FormState> key}) async {
    isLoading.value = true;
    final isValid = key.currentState!.validate();
    Get.focusScope!.unfocus();
    if (isValid) {
      key.currentState!.save();
      await _authenticationController.logIn(
          email: email.value.text.trim(), password: password.value.text);
    }
    isLoading.value = false;
  }
}
