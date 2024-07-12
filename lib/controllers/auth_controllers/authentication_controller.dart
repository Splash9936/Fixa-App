// ignore_for_file: prefer_const_constructors

import 'package:fixa/fixa_main_routes.dart';

class AuthenticationController extends GetxController {
  final _dataProvider = DataProvider();
  final _apiHandler = ApiHandler();
  final _authenticationStateStream = AuthenticationState().obs;
  AuthenticationState get state => _authenticationStateStream.value;

  // getUserLoginDetails() async {
  //   print("inside");
  //   try {
  //     var userCurrent = await _dataProvider.getUserDetails();
  //     if (userCurrent.jwt != null) {
  //       print("userrr ${userCurrent.jwt}");
  //       var response = await _apiHandler.getRequestMethod(
  //           headers: await _dataProvider.headerDetails(),
  //           endPoint: '${Enpoints.usersEnpoint}/${userCurrent.user!.id}');
  //       print("response :: ${response.response!.body}");
  //       if (!response.error) {
  //         UserDetails userDetails =
  //             UserDetails.fromJson(jsonDecode(response.response!.body));
  //         User user = User(jwt: userCurrent.jwt, user: userDetails);
  //         await _dataProvider.updateUserInfo(user: user);
  //         if (userDetails.blocked!) {
  //           await signOut();
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print("error :: ${e.toString()}");
  //   }
  // }

  // check if user is authenticated
  void _getAuthenticatedUser() async {
    _authenticationStateStream.value = AuthenticationLoading();
    final token = await _dataProvider.readToken();
    final user = await _dataProvider.getUserDetails();
    // getUserLoginDetails();

    if (token.isEmpty) {
      _authenticationStateStream.value = UnAuthenticated();
    } else {
      _authenticationStateStream.value = Authenticated(user: user);
    }
  }

  // login
  Future<void> logIn({required String email, required String password}) async {
    var userResponse =
        await _dataProvider.login(email: email, password: password);
    if (!userResponse.error) {
      _getAuthenticatedUser();
      _authenticationStateStream.value =
          Authenticated(user: userResponse.response!);
    } else {
      _authenticationStateStream.value = UnAuthenticated();
      Get.snackbar('Error', '${userResponse.errorMessage}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: redColor,
          colorText: whiteColor,
          borderRadius: 10,
          margin: const EdgeInsets.all(10));
    }
  }

  // log-out
  signOut() async {
    Get.delete<HomeWorkForceController>();
    Get.delete<HomePayrollController>();
    Get.delete<HomeAttendanceController>();
    Get.delete<MainController>();
    Get.delete<LoginController>();
    // Get.delete<AuthenticationController>();
    await _dataProvider.removeToken();
    await _dataProvider.deleteUserObject();
    await _dataProvider.deleteOders();
    await DatabaseService.instance.delete(tableName: 'assignedWorkers');
    await DatabaseService.instance.delete(tableName: 'newworkers');
    await DatabaseService.instance.delete(tableName: 'attendanceWorkers');
    _authenticationStateStream.value = UnAuthenticated();
    Get.offAllNamed(RouteLinks.wrapper);
  }

  // delete user
  deleteUser({required int userId}) async {
    var response = await _apiHandler.deleteRequestMethod(
        headers: await _dataProvider.headerDetails(),
        endPoint: "${Enpoints.userEndpoint}/$userId");
    if (response.error) {
      negativeMessage(message: "${response.errorMessage}");
    } else {
      positiveMessage(message: "User deleted Successfully");
      await signOut();
    }
  }

  @override
  void onInit() {
    _getAuthenticatedUser();
    super.onInit();
  }
}
