import 'package:fixa/fixa_main_routes.dart';

class DataProvider {
  final secureStorage = const FlutterSecureStorage();
  // user_info_storage
  final userStorage = LocalStorage('user');

  final appFlavorsStorage = LocalStorage('app_flavors');

  // project_storage
  final projectStorage = LocalStorage('projects');
  final _apiHandler = ApiHandler();

  // save token
  Future<void> saveToken({required String token}) async {
    await secureStorage.write(key: 'jwt', value: token);
  }

  // read token
  Future<String> readToken() async {
    var token = await secureStorage.read(key: 'jwt');
    return token ?? "";
  }

  // update user info
  updateUserInfo({required User user}) async {
    await userStorage.ready;
    await userStorage.deleteItem('user');
    await userStorage.setItem('user', user);
  }

   // update appFlavor info
  updateAppFlavorInfo({required AppValues appValue}) async {
    try {
      await appFlavorsStorage.ready;
    await appFlavorsStorage.deleteItem('app_flavors');
    await appFlavorsStorage.setItem('app_flavors', appValue.toJson());
    } catch (e) {
      // print("Error ===> ${e}");
    }
  }

  // save user info
  void saveUser({required User user}) async {
    await userStorage.ready;
    userStorage.setItem("user", user);
  }

  // read user object
  Future<User> getUserDetails() async {
    await userStorage.ready;
    var data = userStorage.getItem('user');
    if (data == null || data.isEmpty) {
      return User();
    }
    User user = User.fromJson(data);
    return user;
  }

   // read appValues object
  Future<AppValues> getAppFlavorDetails() async {
    await appFlavorsStorage.ready;
    var data = appFlavorsStorage.getItem('app_flavors');
    if (data == null || data.isEmpty) {
      return AppValues(appTitle: '',loginIcon: '',logoIcon: '',lottie: '',baseUrl: '',isConfirmed: false);
    }
    AppValues appValues = AppValues.fromJson(data);
    return appValues;
  }

  // remove user object
  Future<void> deleteUserObject() async {
    await userStorage.ready;
    await userStorage.clear();
    await userStorage.deleteItem('user');

    await appFlavorsStorage.ready;
    await appFlavorsStorage.clear();
    await appFlavorsStorage.deleteItem('app_flavors');
  }

  // remove token
  Future<void> removeToken() async {
    await secureStorage.deleteAll();
  }

  // save projects
  saveProjects({required List<Project> projects}) async {
    await projectStorage.ready;
    List newProjects = [];
    for (var item in projects) {
      var newProject = {
        "project_id": item.projectId ?? 0,
        "project_name": item.projectName ?? "",
        "project_descritpion": item.projectDescritpion ?? "",
        "company_id": item.companyId ?? 0,
        "services": item.services ?? []
      };
      newProjects.add(newProject);
    }
    projectStorage.setItem('projects', json.encode(newProjects).toString());
  }

 

  // read projects
  Future<List<Project>> readProject() async {
    await projectStorage.ready;
    var data = projectStorage.getItem('projects');
    List<Project>? projects = [];
    if (data == null || data.isEmpty) {
      return projects;
    } else {
      List jsonResponse = json.decode(data);
      projects =
          jsonResponse.map((project) => Project.fromJson(project)).toList();
      return projects;
    }
  }

  // delete projects
  deleteOders() async {
    await projectStorage.ready;
    await projectStorage.clear();
    await projectStorage.deleteItem('projects');
  }

  // header api
  Future<Map<String, String>> headerDetails() async {
    Map<String, String> headerDetails = {};
    var token = await readToken();
    headerDetails = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };

    return headerDetails;
  }

   Future<ResponseModel<IdVerificationData>> getNidInformation({required String nid}) async {
    try {
      var headers = await headerDetails();
      var response = await _apiHandler.postRequestMethod(headers:  headers, body: {"nid_number":nid}, endPoint: Enpoints.nidInformationEndpoint);
      if(!response.error){
         IdVerificationData workerInformation = IdVerificationData.fromJson(jsonDecode(response.response!.body)['data']);
          return ResponseModel(
          error: false, errorMessage: null, response: workerInformation);
      }else {
         return ResponseModel(
          error: true, errorMessage: "${jsonDecode(response.response!.body)['error']}", response: null);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

// get payroll Attendance
  Future<ResponseModel<List<PayrollAttendance>>> getPayrollAttendance(
      {required String endPoint}) async {
    List<PayrollAttendance> payrollAttendance = [];
    try {
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        List jsonResponse = json.decode(response.response!.body)["data"]
                ["attendance_shifts"] ??
            [];
        payrollAttendance = jsonResponse
            .map((payment) => PayrollAttendance.fromJson(payment))
            .toList();
        return ResponseModel(
            error: false, errorMessage: null, response: payrollAttendance);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: payrollAttendance);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

// get payout transactions
  Future<ResponseModel<List<PayoutTransactions>>> getPayoutTransactions(
      {required String endPoint}) async {
    List<PayoutTransactions> payoutTransactions = [];
    try {
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        List jsonResponse =
            json.decode(response.response!.body)["data"]["transactions"] ?? [];
        payoutTransactions = jsonResponse
            .map((payment) => PayoutTransactions.fromJson(payment))
            .toList();
        return ResponseModel(
            error: false, errorMessage: null, response: payoutTransactions);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: payoutTransactions);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

// get payroll transactions
  Future<ResponseModel<List<PayrollTransactions>>> getPayrollTransactions(
      {required String endPoint}) async {
    List<PayrollTransactions> payrollTransactions = [];
    try {
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        List jsonResponse = json.decode(response.response!.body) ?? [];
        payrollTransactions = jsonResponse
            .map((payment) => PayrollTransactions.fromJson(payment))
            .toList();
        return ResponseModel(
            error: false, errorMessage: null, response: payrollTransactions);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: payrollTransactions);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // getPayments
  Future<ResponseModel<List<Payments>>> getPayments(
      {required String endPoint}) async {
    List<Payments> payments = [];
    try {
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        List jsonResponse = json.decode(response.response!.body)["data"] ?? [];
        payments =
            jsonResponse.map((payment) => Payments.fromJson(payment)).toList();
        return ResponseModel(
            error: false, errorMessage: null, response: payments);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: payments);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // getPaymentTypes
  Future<ResponseModel<List<PaymentsType>>> getPaymentTypes(
      {required String endPoint}) async {
    List<PaymentsType> paymentTypes = [];
    try {
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        List jsonResponse = json.decode(response.response!.body) ?? [];
        paymentTypes = jsonResponse
            .map((paymentType) => PaymentsType.fromJson(paymentType))
            .toList();
        return ResponseModel(
            error: false, errorMessage: null, response: paymentTypes);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: paymentTypes);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // getAssessments
  Future<ResponseModel<List<Assessment>>> getAssessmentsQuestions(
      {required String endPoint}) async {
    List<Assessment> assessments = [];
    try {
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        List jsonResponse = json.decode(response.response!.body) ?? [];
        assessments = jsonResponse
            .map((assessment) => Assessment.fromJson(assessment))
            .toList();
        return ResponseModel(
            error: false, errorMessage: null, response: assessments);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: assessments);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // getDeductionWorkesRange
  Future<ResponseModel<int>> deductionRange({required String endPoint}) async {
    int totalDeductions = 0;
    try {
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        var jsonResponse = json.decode(response.response!.body)["data"];
        totalDeductions = jsonResponse["total_deduction"];
        return ResponseModel(
            error: false, errorMessage: null, response: totalDeductions);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: totalDeductions);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // get payroll worker histories
  Future<ResponseModel<List<PayrollWorkers>>> getPayrollWorkersHistory(
      {required String endPoint}) async {
    try {
      List<PayrollWorkers> payrollWorkers = [];
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        List jsonResponse = json.decode(response.response!.body)["data"];
        payrollWorkers = jsonResponse
            .map((payroll) => PayrollWorkers.fromJson(payroll))
            .toList();
        return ResponseModel(
            error: false, errorMessage: null, response: payrollWorkers);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: payrollWorkers);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // get worker payroll history
  Future<ResponseModel<List<WorkerPayroll>>> getWorkerPayrollHistory(
      {required String endPoint}) async {
    try {
      List<WorkerPayroll> workerPayrollHistory = [];
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        List jsonResponse = json.decode(response.response!.body)["data"] ?? [];
        workerPayrollHistory = jsonResponse
            .map((assignedWorker) => WorkerPayroll.fromJson(assignedWorker))
            .toList();
        return ResponseModel(
            error: false, errorMessage: null, response: workerPayrollHistory);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: workerPayrollHistory);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // auth_login method
  Future<ResponseModel<User>> login(
      {required String email, required String password}) async {
    try {
      var response = await _apiHandler.signIn(
          email: email, password: password, endPoint: Enpoints.loginEndpoint);
      if (!response.error && response.response!.statusCode == 200) {
        User user = User.fromJson(jsonDecode(response.response!.body));
        // save token for future use
        await saveToken(token: user.jwt!);
        // save use to local database
        saveUser(user: user);
        return ResponseModel(error: false, errorMessage: null, response: user);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: null);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // update user info
  Future<ResponseModel<UserDetails>> updateUserInfoRequest(
      {required dynamic body, required String endPoint}) async {
    try {
      var response = await _apiHandler.putRequestMethod(
          headers: await headerDetails(), body: body, endPoint: endPoint);
      if (!response.error && response.response!.statusCode == 200) {
        UserDetails user =
            UserDetails.fromJson(jsonDecode(response.response!.body));

        return ResponseModel(error: false, errorMessage: null, response: user);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: null);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // get deductions
  Future<ResponseModel<List<Deductions>>> getWorkerDeductions(
      {required String endPoint, bool? status}) async {
    try {
      List<Deductions> deductions = [];
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        List jsonResponse = [];
        if (status != null && status == true) {
          jsonResponse = json.decode(response.response!.body)["data"]
              ["workers_deductions"] as List;
          deductions = jsonResponse
              .map((project) => Deductions.fromJson(project))
              .toList();
        } else {
          jsonResponse = json.decode(response.response!.body)["data"] as List;
          deductions = jsonResponse
              .map((project) => Deductions.fromJson(project))
              .toList();
        }
        return ResponseModel(
            error: false, errorMessage: null, response: deductions);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: deductions);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // get projects
  Future<ResponseModel<List<Project>>> getWorkerProjects(
      {required String endPoint}) async {
    try {
      List<Project> projects = [];
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        List jsonResponse = json.decode(response.response!.body);
        projects =
            jsonResponse.map((project) => Project.fromJson(project)).toList();
        return ResponseModel(
            error: false, errorMessage: null, response: projects);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: projects);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // get assigned workers
  Future<ResponseModel<List<AssignedWorkers>>> getAssignedWorkers(
      {required String endPoint}) async {
    try {
      List<AssignedWorkers> assignedWorkers = [];
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        List jsonResponse = json.decode(response.response!.body)["data"];
        assignedWorkers = jsonResponse
            .map((assignedWorker) => AssignedWorkers.fromJson(assignedWorker))
            .toList();
        return ResponseModel(
            error: false, errorMessage: null, response: assignedWorkers);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: assignedWorkers);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

// get countries
  Future<ResponseModel<List<Country>>> getCountries(
      {required String endPoint}) async {
    try {
      List<Country> countries = [];
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: "$endPoint?show=true&_limit=-1");

      if (!response.error) {
        List jsonResponse = json.decode(response.response!.body);
        countries = jsonResponse
            .map((district) => Country.fromJson(district))
            .toList();
        return ResponseModel(
            error: false, errorMessage: null, response: countries);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: countries);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // get districts
  Future<ResponseModel<List<District>>> getDistricts(
      {required String endPoint}) async {
    try {
      List<District> districts = [];
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        List jsonResponse = json.decode(response.response!.body);
        districts = jsonResponse
            .map((district) => District.fromJson(district))
            .toList();
        return ResponseModel(
            error: false, errorMessage: null, response: districts);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: districts);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // get attendance by date
  Future<ResponseModel<List<WorkerAttendance>>> getAttendance(
      {required String endPoint}) async {
    try {
      List<WorkerAttendance> attendances = [];
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        List jsonResponse = json.decode(response.response!.body)["data"] ?? [];
        attendances = jsonResponse
            .map((attendance) => WorkerAttendance.fromJson(attendance))
            .toList();
        return ResponseModel(
            error: false, errorMessage: null, response: attendances);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: attendances);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // get attendance statuses
  Future<ResponseModel<List<AttendanceStatus>>> getAttendanceStatus(
      {required String endPoint, required dynamic body}) async {
    try {
      List<AttendanceStatus> attendances = [];
      var response = await _apiHandler.postRequestMethod(
          body: body, headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        List jsonResponse = json.decode(response.response!.body) ?? [];
        attendances = jsonResponse
            .map((attendance) => AttendanceStatus.fromJson(attendance))
            .toList();
        return ResponseModel(
            error: false, errorMessage: null, response: attendances);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: attendances);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // get payroll by year
  Future<ResponseModel<List<Payroll>>> getPayrolls(
      {required String endPoint}) async {
    try {
      List<Payroll> payrolls = [];
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        List jsonResponse = json.decode(response.response!.body);
        payrolls = jsonResponse
            .map((attendance) => Payroll.fromJson(attendance))
            .toList();
        return ResponseModel(
            error: false, errorMessage: null, response: payrolls);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: payrolls);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // get worker history
  Future<ResponseModel<WorkerHistory>> getWorkerHistories(
      {required String endPoint}) async {
    try {
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        WorkerHistory workerHistory = WorkerHistory.fromJson(
            json.decode(response.response!.body)["data"]);
        return ResponseModel(
            error: false, errorMessage: null, response: workerHistory);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: null);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // get payroll history
  Future<ResponseModel<PayrollHistory>> getPayrollsHistories(
      {required String endPoint, required dynamic body}) async {
    try {
      var response = await _apiHandler.postRequestMethod(
          headers: await headerDetails(), body: body, endPoint: endPoint);

      if (!response.error) {
        PayrollHistory payrolls =
            PayrollHistory.fromJson(json.decode(response.response!.body));
        return ResponseModel(
            error: false, errorMessage: null, response: payrolls);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: null);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // get worker profile info
  Future<ResponseModel<WorkerProfile>> getWorkerProfileInfo(
      {required String endPoint}) async {
    try {
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        WorkerProfile workerProfileInfo = WorkerProfile.fromJson(
            json.decode(response.response!.body)["data"]);
        return ResponseModel(
            error: false, errorMessage: null, response: workerProfileInfo);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: null);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // get assessments
  Future<ResponseModel<List<Assessment>>> getAssessments(
      {required String endPoint}) async {
    try {
      List<Assessment> assessments = [];
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        List jsonResponse = json.decode(response.response!.body);
        assessments = jsonResponse
            .map((assessment) => Assessment.fromJson(assessment))
            .toList();
        return ResponseModel(
            error: false, errorMessage: null, response: assessments);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: assessments);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }

  // get deductions types
  Future<ResponseModel<List<DeductionTypes>>> getDeductionsTypes(
      {required String endPoint}) async {
    try {
      List<DeductionTypes> deductionsTypes = [];
      var response = await _apiHandler.getRequestMethod(
          headers: await headerDetails(), endPoint: endPoint);

      if (!response.error) {
        List jsonResponse = json.decode(response.response!.body);
        deductionsTypes = jsonResponse
            .map((deductionsType) => DeductionTypes.fromJson(deductionsType))
            .toList();
        return ResponseModel(
            error: false, errorMessage: null, response: deductionsTypes);
      } else {
        return ResponseModel(
            error: true,
            errorMessage: "${response.errorMessage}",
            response: deductionsTypes);
      }
    } catch (e) {
      return ResponseModel(
          error: true, errorMessage: e.toString(), response: null);
    }
  }
}
