import 'package:fixa/fixa_main_routes.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

class ForgetPasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordController());
  }
}

class WrapperBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AuthenticationController(),
    );
    Get.lazyPut(() => MainController());
    Get.lazyPut(
      () => NetworkController(),
    );
    Get.lazyPut(
      () => LoginController(),
    );

    // Get.lazyPut(
    //   () => HomePageController(),
    // );
    // Get.lazyPut(
    //   () => MainAttendanceController(),
    // );
    // Get.lazyPut(
    //   () => MainWorkerForceController(),
    // );
  }
}

class HomeDashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
    // Get.lazyPut(() => HomePageController());
    // Get.lazyPut(() => HomeAttendanceController());
    // Get.lazyPut(() => HomeWorkForceController());
    // Get.lazyPut(() => HomePayrollController());
  }
}

class HomeRegisterWorkerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterWorkerController());
  }
}

class HomeWorkerPayrollBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeWorkerPayrollController());
  }
}

class HomeWorkerSearchBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeSearchWorkerController());
  }
}

class HomeRecordAttendanceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => NetworkController(),
    );
    Get.lazyPut(() => HomeRecordAttendanceController());
  }
}

class HomePayrollDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomePayrollDetailsController(),
    );
  }
}

class HomeWorkerProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkerProfileController());
  }
}

class HomeWorkerAssessmentsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeAssessWorkerController());
  }
}

class HomeEditWorkerProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditWorkerProfileController());
  }
}

class HomeEditUserProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController());
  }
}
