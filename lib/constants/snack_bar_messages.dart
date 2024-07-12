// ignore_for_file: unnecessary_string_interpolations

import 'package:fixa/fixa_main_routes.dart';

positiveMessage({required String message, required}) {
  return Get.rawSnackbar(
      messageText: Text(
        "${nameCapitalised(message)}",
        style: TextStyling.buttonMediumWhiteTextStyle,
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: greenColor,
      borderRadius: 10,
      margin: const EdgeInsets.all(10));
}

negativeMessage({required String message}) {
  return Get.rawSnackbar(
      messageText: Text(
        "${nameCapitalised(message)}",
        style: TextStyling.buttonMediumWhiteTextStyle,
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: redColor,
      borderRadius: 10,
      margin: const EdgeInsets.all(10));
}

warningMessage({required String message}) {
  return Get.rawSnackbar(
      messageText: Text(
        "${nameCapitalised(message)}",
        style: TextStyling.buttonMediumWhiteTextStyle,
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: orangeLight,
      borderRadius: 10,
      margin: const EdgeInsets.all(10));
}
