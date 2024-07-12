import 'package:fixa/fixa_main_routes.dart';

class ForgotPasswordController extends GetxController {
  final _apiHandler = ApiHandler();
  // final _dataProvider = DataProvider();
  RxBool isLoading = false.obs;
  Rx<TextEditingController> email = TextEditingController().obs;

  Future<bool> submit({required GlobalKey<FormState> key}) async {
    bool status = false;
    isLoading.value = true;
    final isValid = key.currentState!.validate();
    if (isValid) {
      var response = await _apiHandler.postRequestMethod(headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      }, body: {
        "email": email.value.text
      }, endPoint: Enpoints.forgotPasswordEnpoint);
      if (response.error) {
        isLoading.value = false;
        negativeMessage(message: response.errorMessage!);
      } else {
        isLoading.value = false;
        positiveMessage(
            message:
                "Check your email, we have shared the link to reset your password to ${email.value.text}");
        status = true;
      }
    }
    isLoading.value = false;
    return status;
  }

  // email validator
  String? emailValidator(String value) {
    if (value.isEmpty || !value.contains('@')) {
      return 'Please, Input a correct email';
    }
    return null;
  }
}
