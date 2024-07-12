import 'package:fixa/fixa_main_routes.dart';

class HomePayrollDetailsController extends GetxController {
  final MainController mainController = Get.find();
  final _apiHandler = ApiHandler();
  final _dataProvider = DataProvider();
  RxBool isLoadingTransactions = false.obs;
  RxBool isSearching = false.obs;
  RxBool isAddingDeduction = false.obs;
  RxBool isgettingDeduction = false.obs;
  RxBool isSearchingWorkerInfo = false.obs;
  RxInt selectedService = 0.obs;
  RxList<Services> allServices = <Services>[].obs;
  List<PayrollTransactions> allPayrollTRansactions = [];
  RxList<DeductionTypes> deductionsTypes = <DeductionTypes>[].obs;
  RxList<PayrollTransactions> payrollTRansactions = <PayrollTransactions>[].obs;
  RxList<PayrollAttendance> payrollAttendance = <PayrollAttendance>[].obs;
  List<PayoutTransactions> allPayoutTRansactions = [];
  RxList<PayoutTransactions> payoutTRansactions = <PayoutTransactions>[].obs;
  RxList<Map<String, dynamic>> attendanceInfo = <Map<String, dynamic>>[].obs;
  RxList<DeductionControllers> deductionsControllers =
      <DeductionControllers>[].obs;
  RxList<Deductions> deductions = <Deductions>[].obs;

  // change service
  void changeService({required Services service}) {
    selectedService.value = service.id!;
    if (service.id == 0) {
      payrollTRansactions.value = allPayrollTRansactions;
    } else {
      payrollTRansactions.value = allPayrollTRansactions
          .where((item) =>
              item.serviceName!.toLowerCase() == service.name!.toLowerCase())
          .toList();
    }
  }

  getDeductionTypes() async {
    var response = await _dataProvider.getDeductionsTypes(
        endPoint:
            "${Enpoints.deductionTYpes}?is_external=false&is_available=true");
    if (!response.error) {
      deductionsTypes.value = response.response!;
      // print("Deduction -types :: ${deductionsTypes.length}");
    }
  }

  // get payroll transactions per payment_id
  getPayrollTransactions(
      {required int paymentId,
      required Project project,
      required String paymentType}) async {
    if (paymentType == 'payout') {
      isLoadingTransactions.value = true;
      var response = await _dataProvider.getPayoutTransactions(
          endPoint:
              "${Enpoints.payoutTransactionsEndpoint}?payment_id=$paymentId&_limit=-1");
      if (response.error) {
        negativeMessage(message: "${response.errorMessage}");
      } else {
        allPayoutTRansactions = response.response!;
        payoutTRansactions.value = response.response!;
      }
      isLoadingTransactions.value = false;
    } else {
      isLoadingTransactions.value = true;
      var newService = Services(id: 0, name: 'All');
      allServices.value = [newService, ...project.services!];
      var response = await _dataProvider.getPayrollTransactions(
          endPoint:
              "${Enpoints.payrollTransactionsEndpoint}?payment_id=$paymentId&_limit=-1");
      if (response.error) {
        negativeMessage(message: "${response.errorMessage}");
      } else {
        allPayrollTRansactions = response.response!;
        payrollTRansactions.value = response.response!;
        await getDeductionTypes();
      }
      isLoadingTransactions.value = false;
    }
  }

  // add service
  void removeDeduction({required DeductionControllers deductionController}) {
    deductionsControllers.remove(deductionController);
  }

  // add service
  void addDeduction() {
    deductionsControllers
        .add(DeductionControllers(0, 0, TextEditingController(), false));
    // serviceWidgets.add(widget);
  }

  void setIsSearching({required bool status}) {
    selectedService.value = 0;
    isSearching.value = !status;
    payrollTRansactions.value = allPayrollTRansactions;
    payoutTRansactions.value = allPayoutTRansactions;
  }

  void searchPaymentTRansactions(
      {required String data, required bool isEmpty, required isPayout}) {
    if (isPayout) {
      List<PayoutTransactions> allPayoutTRansactionsFounds = [];
      if (isEmpty) {
        payoutTRansactions.value = allPayoutTRansactions;
      } else {
        for (var item in allPayoutTRansactions) {
          if (item.payeeName!.toLowerCase().contains(data.toLowerCase()) ||
              item.phoneNumber!.contains(data)) {
            allPayoutTRansactionsFounds.add(item);
          }
        }
      }
      payoutTRansactions.value = allPayoutTRansactionsFounds;
    } else {
      List<PayrollTransactions> allPayrollTRansactionsFounds = [];
      if (isEmpty) {
        payrollTRansactions.value = allPayrollTRansactions;
      } else {
        for (var item in allPayrollTRansactions) {
          if (item.workerName!.toLowerCase().contains(data.toLowerCase())) {
            allPayrollTRansactionsFounds.add(item);
          }
        }
      }
      payrollTRansactions.value = allPayrollTRansactionsFounds;
    }
  }

  // get attendance info
  getAttendanceInfo({required List<PayrollAttendance> workerAttendance}) {
    List<Map<String, dynamic>> dataResponse = [];
    for (var item in workerAttendance) {
      var isServiceExistedInData = dataResponse
          .where((element) =>
              element["service_name"].toString() == item.serviceName.toString())
          .toList();
      if (isServiceExistedInData.isEmpty || dataResponse.isEmpty) {
        var attendanceDay = workerAttendance
            .where((element) =>
                element.serviceName == item.serviceName &&
                element.shiftName.toString() == 'day')
            .toList();
        var attendanceNight = workerAttendance
            .where((element) =>
                element.serviceName == item.serviceName &&
                element.shiftName.toString() == 'night')
            .toList();
        var body = {
          "service_name": item.serviceName,
          "total_shift_days": attendanceDay.length,
          "shift_day_value": attendanceDay.isEmpty ? 0 : attendanceDay[0].value,
          "total_day_value": attendanceDay.isEmpty
              ? 0
              : attendanceDay.length * attendanceDay[0].value!,
          "total_shift_nights": attendanceNight.length,
          "shift_night_value":
              attendanceNight.isEmpty ? 0 : attendanceNight[0].value,
          "total_night_value": attendanceNight.isEmpty
              ? 0
              : attendanceNight.length * attendanceNight[0].value!,
        };
        dataResponse.add(body);
      }
    }

    return dataResponse;
  }

  // get deduction and attendance info
  getWorkerInformation({required int payrollTransactionId}) async {
    isSearchingWorkerInfo.value = true;
    var response = await _dataProvider.getPayrollAttendance(
        endPoint:
            "${Enpoints.payrollTransactionsShiftsEndpoint}/$payrollTransactionId");
    if (response.error) {
      negativeMessage(message: "${response.errorMessage}");
    } else {
      payrollAttendance.value = response.response!;
      attendanceInfo.value =
          getAttendanceInfo(workerAttendance: payrollAttendance);
    }
    isSearchingWorkerInfo.value = false;
  }

// get deduction of a worker
  getWorkerDeductions(
      {required int projectId,
      required DateTime time,
      required int payrollId}) async {
    isgettingDeduction.value = true;
    deductionsControllers.value = [];

    var dedutionEndPoint = "${Enpoints.getPayrollDeduction}/$payrollId";
    var deductionsResponse = await _dataProvider.getWorkerDeductions(
        endPoint: dedutionEndPoint, status: true);
    if (!deductionsResponse.error) {
      deductions.value = deductionsResponse.response!;
      for (var item in deductionsResponse.response!) {
        deductionsControllers.add(DeductionControllers(
            item.id!,
            item.deductionTypeId!,
            TextEditingController(text: item.deductionAmount.toString()),
            true));
      }
    } else {
      negativeMessage(message: "${deductionsResponse.errorMessage}");
      isgettingDeduction.value = false;
    }

    isgettingDeduction.value = false;
  }

  List<Map<String, dynamic>> getDeductionBody() {
    List<Map<String, dynamic>> deductionBody = [];
    for (var item in deductionsControllers) {
      if (item.isApplied == false) {
        var newdeductionBody = {
          "type_id": item.deductionTypeId,
          "amount": int.parse(item.deductedAmount.text)
        };
        deductionBody.add(newdeductionBody);
      }
    }
    return deductionBody;
  }

  // remove worker deduction by id
  removeWorkerDeduction(
      {required Project project,
      required int paymentId,
      required int deductionId,
      required int payrollId,
      required DateTime time}) async {
    isAddingDeduction.value = true;
    var responseRemoveDeduction = await _apiHandler.deleteRequestMethod(
        headers: await _dataProvider.headerDetails(),
        endPoint: "${Enpoints.deductionUrl}/$deductionId");
    // print("response === > ${responseRemoveDeduction.response!.body}");
    if (responseRemoveDeduction.error) {
      negativeMessage(message: "${responseRemoveDeduction.errorMessage}");
      await getWorkerDeductions(
          projectId: project.projectId!, payrollId: payrollId, time: time);
      isAddingDeduction.value = false;
    } else {
      deductionsControllers.value = [];
      await getPayrollTransactions(
          paymentId: paymentId, paymentType: 'payroll', project: project);
      positiveMessage(message: "successfully, dedution removed");
      isAddingDeduction.value = false;
    }
  }

  saveDeductions(
      {required Project project,
      required int payrollId,
      required int paymentId,
      required int workerAssignedId,
      required DateTime deductionDate}) async {
    isAddingDeduction.value = true;
    var payload = {
      "project_id": project.projectId,
      "payroll_transaction_id": payrollId,
      "assigned_worker_id": workerAssignedId,
      "deductions": getDeductionBody(),
    };
    var responseDeduction = await _apiHandler.postRequestMethod(
        headers: await _dataProvider.headerDetails(),
        body: payload,
        endPoint: Enpoints.deductionInternalPayroll);
    if (responseDeduction.error) {
      negativeMessage(message: "${responseDeduction.errorMessage}");
      isAddingDeduction.value = false;
    } else {
      deductionsControllers.value = [];
      await getPayrollTransactions(
          paymentId: paymentId, paymentType: 'payroll', project: project);
      positiveMessage(message: "successfully, dedution applied");

      isAddingDeduction.value = false;
    }
    isAddingDeduction.value = false;
  }
}
