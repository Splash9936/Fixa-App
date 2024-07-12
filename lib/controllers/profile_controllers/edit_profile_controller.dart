import 'package:fixa/fixa_main_routes.dart';

class EditProfileController extends GetxController {
  List<AssignedWorkers> assignedWorkers = [];
  final _apiHandler = ApiHandler();
  final _dataProvider = DataProvider();
  final MainController mainController = Get.find();
  RxBool isPassword = false.obs;
  RxBool isOldPassword = true.obs;
  RxBool isNewPassword = true.obs;
  RxBool isConfirmPassword = true.obs;
  RxBool isSubmiting = false.obs;
  Rx<TextEditingController> firstName = TextEditingController().obs;
  Rx<TextEditingController> lastName = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> currentPassword = TextEditingController().obs;
  Rx<TextEditingController> newPassword = TextEditingController().obs;
  Rx<TextEditingController> confirmPassword = TextEditingController().obs;
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;

  void setOldPassword() {
    isOldPassword.value = !isOldPassword.value;
  }

  void setNewPassword() {
    isNewPassword.value = !isNewPassword.value;
  }

  void setConfirmPassword() {
    isConfirmPassword.value = !isConfirmPassword.value;
  }

  submit(
      {required GlobalKey<FormState> key,
      required String currentfirstName,
      required String currentlastName,
      required String currentemail,
      required String currentphoneNumber}) async {
    var user = await _dataProvider.getUserDetails();
    final isValid = key.currentState!.validate();
    isSubmiting.value = true;
    if (isValid) {
      var body = {
        "first_name": firstName.value.text.isEmpty
            ? currentfirstName
            : firstName.value.text,
        "last_name":
            lastName.value.text.isEmpty ? currentlastName : lastName.value.text,
        "username": phoneNumber.value.text.isEmpty
            ? currentphoneNumber
            : phoneNumber.value.text,
        "email": email.value.text.isEmpty ? currentemail : email.value.text,
      };

      var response = await _dataProvider.updateUserInfoRequest(
          body: body, endPoint: "${Enpoints.usersEnpoint}/${user.user!.id}");
      if (response.error) {
        negativeMessage(message: "${response.errorMessage}");
      } else {
        // update current user info
        await _dataProvider.updateUserInfo(
            user: User(jwt: user.jwt, user: response.response));
        await mainController.getUserInfo();
        positiveMessage(message: "Successfully updated");
      }
    }
    isSubmiting.value = false;
  }

  void setIsPassword() {
    isPassword.value = !isPassword.value;
  }

  void changePassword({
    required GlobalKey<FormState> key,
  }) async {
    final isValid = key.currentState!.validate();
    if (isValid) {
      isSubmiting.value = true;
      var payload = {
        "currentPassword": currentPassword.value.text,
        "newPassword": newPassword.value.text,
        "newPasswordConfirmation": confirmPassword.value.text,
      };
      var response = await _apiHandler.postRequestMethod(
          headers: await _dataProvider.headerDetails(),
          body: payload,
          endPoint: Enpoints.changePasswordEndpoint);
      if (response.error && response.response!.statusCode != 200) {
        negativeMessage(message: response.errorMessage!);
        isSubmiting.value = false;
      } else if (response.response!.statusCode == 200 &&
          json.decode(response.response!.body)["status"] == "failure") {
        negativeMessage(
            message: json.decode(response.response!.body)["errors"][0]);
      } else {
        isSubmiting.value = false;
        await mainController.signedOut();
      }
      isSubmiting.value = false;
    }
  }

  bool checkIfPhoneNumberExist({required String phoneNumber}) {
    for (var item in assignedWorkers) {
      if (item.phoneNumber == phoneNumber) {
        return true;
      }
    }
    return false;
  }

  String? phoneNumberValidator(String value) {
    if (value.isEmpty || value.length < 10 || value.length > 10) {
      return 'Please, Input a phoneNumber';
    } else if (checkIfPhoneNumberExist(phoneNumber: value)) {
      return 'Attention, This Phone number is already in use';
    }
    return null;
  }

  // get workers saved
  getWorkersSaved() async {
    assignedWorkers = await DatabaseService.instance.getAssingedWorkerSaved();
  }

  @override
  void onInit() {
    getWorkersSaved();
    super.onInit();
  }
}
