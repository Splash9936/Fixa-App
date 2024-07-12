import 'package:fixa/fixa_main_routes.dart';

class HomeWorkerPayrollController extends GetxController {
  final _dataProvider = DataProvider();
  bool isLoading = false;
  RxList<PayrollAttendance> payrollAttendance = <PayrollAttendance>[].obs;

  getData({required int payrollTransactionId}) async {
    isLoading = true;
    update();
    var response = await _dataProvider.getPayrollAttendance(
        endPoint:
            "${Enpoints.payrollTransactionsShiftsEndpoint}/$payrollTransactionId");
    if (response.error) {
      negativeMessage(message: "${response.errorMessage}");
    } else {
      payrollAttendance.value = response.response!;
    }
    isLoading = false;
    update();
  }
}
