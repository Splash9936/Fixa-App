import 'package:fixa/fixa_main_routes.dart';
import 'package:intl/intl.dart';

class HomePayrollController extends GetxController {
  final MainController mainController = Get.find();
  final _dataProvider = DataProvider();
  RxList<Project> projects = <Project>[].obs;
  RxList<PayrollWorkers> allPayrollWorkers = <PayrollWorkers>[].obs;
  RxList<PayrollWorkers> payrollWorkers = <PayrollWorkers>[].obs;
  RxList<PayrollRangeFrame> payrollFrames = <PayrollRangeFrame>[].obs;
  RxList<Services> allServices = <Services>[].obs;
  Rx<PayrollFrame> dataPayroll = PayrollFrame(dateStart: "", dateEnd: "").obs;
  RxInt selectedCurrentPayrollIndex = 0.obs;
  RxInt firstDateIndex = 0.obs;
  RxInt totalDeductions = 0.obs;
  RxInt lastDateIndex = 0.obs;
  RxInt selectedService = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingDeduction = false.obs;
  RxBool isSearching = false.obs;
  // ******************************************
  RxInt selectedPaymentType = 0.obs;
  RxBool isLoadingPayments = false.obs;
  RxList<PaymentsType> paymentTypes = <PaymentsType>[].obs;
  RxList<Payments> payments = <Payments>[].obs;
  List<Payments> allPayments = [];
  RxInt yearSeleted = DateTime.now().year.obs;
  RxInt monthSelected = DateTime.now().month.obs;
  List<Map<String, dynamic>> monthData = [
    {"id": 1, "month_name": "January"},
    {"id": 2, "month_name": "February"},
    {"id": 3, "month_name": "March"},
    {"id": 4, "month_name": "April"},
    {"id": 5, "month_name": "May"},
    {"id": 6, "month_name": "June"},
    {"id": 7, "month_name": "July"},
    {"id": 8, "month_name": "August"},
    {"id": 9, "month_name": "September"},
    {"id": 10, "month_name": "October"},
    {"id": 11, "month_name": "November"},
    {"id": 12, "month_name": "December"}
  ];

  getAttendanceRange({required int projectId}) async {}

  formatDate({required DateTime dateToFormat}) {
    String dateFormated = "";
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    dateFormated = formatter.format(dateToFormat);
    return dateFormated;
  }

  List<PayrollFrame> arrangeTimeFrame(
      {required int monthIndex, required int yearIndex}) {
    List<PayrollFrame> timefrms = [];
    var nextMonth = monthIndex + 1;
    var startDate = DateTime(yearIndex, monthIndex, 1);
    var endDate = DateTime(yearIndex, nextMonth, 0);
    timefrms.add(PayrollFrame(
        dateEnd: formatDate(
            dateToFormat: DateTime(startDate.year, startDate.month, 15)),
        dateStart: formatDate(dateToFormat: startDate)));
    timefrms.add(PayrollFrame(
        dateEnd: formatDate(dateToFormat: endDate),
        dateStart: formatDate(
            dateToFormat: DateTime(endDate.year, endDate.month, 16))));

    return timefrms;
  }

  // ***********************************
  void changePaymentType({required int paymentTypeValue}) {
    selectedPaymentType.value = paymentTypeValue;
    if (paymentTypeValue == 0) {
      payments.value = allPayments;
    } else {
      var selectedPayments = allPayments
          .where((item) => item.paymentTypesId == paymentTypeValue.toString())
          .toList();
      payments.value = selectedPayments;
    }
  }

  void changeYear({required int dateValue}) {
    yearSeleted.value = dateValue;
    monthSelected.value = 0;
  }

  void changeMonth({required int monthValue, required int projectIdValue}) {
    monthSelected.value = monthValue;
    getPaymentData(projectIdValue: projectIdValue);
    Get.back();
  }

  getPaymentTypes() async {
    var responsePaymentTypes = await _dataProvider.getPaymentTypes(
        endPoint: "${Enpoints.paymentTypeEndpoint}?_limit=-1");
    if (responsePaymentTypes.error) {
      negativeMessage(message: responsePaymentTypes.errorMessage!);
    } else {
      paymentTypes.value = [
        PaymentsType(id: 0, typeName: 'All', description: 'All Payments'),
        ...responsePaymentTypes.response!
      ];
      // get payment
    }
  }

  getPaymentData({required int projectIdValue}) async {
    isLoadingPayments.value = true;
    selectedPaymentType.value = 0;
    payments.value = [];
    allPayments = [];
    update();
    DateTime startDatePayment =
        DateTime.utc(yearSeleted.value, monthSelected.value);
    DateTime endDatePayment =
        DateTime.utc(yearSeleted.value, monthSelected.value + 1, 0);

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    var startDateStringPayment = formatter.format(startDatePayment);
    var endDateStringPayment = formatter.format(endDatePayment);

    var responsePayment = await _dataProvider.getPayments(
        endPoint:
            "${Enpoints.paymentEndpoint}?_sort=added_on:DESC&_limit=-1&project_id=$projectIdValue&end_date_lte=$endDateStringPayment&start_date_gte=$startDateStringPayment");
    if (responsePayment.error) {
      negativeMessage(message: "${responsePayment.errorMessage}");
      isLoadingPayments.value = false;
    } else {
      allPayments = responsePayment.response!;
      payments.value = responsePayment.response!;
      isLoadingPayments.value = false;
    }
    isLoadingPayments.value = false;
    update();
  }

  getPaymentInfoData({required int projectIdValue}) async {
    await getPaymentTypes();
    await getPaymentData(projectIdValue: projectIdValue);
  }

  void searchPayment({required String dataValue, required bool isEmpty}) {
    List<Payments> searchPaymentsresults = [];
    selectedPaymentType.value = 0;
    if (isEmpty) {
      payments.value = allPayments;
    } else {
      for (var item in allPayments) {
        if (item.title!.contains(dataValue) || item.title == dataValue) {
          searchPaymentsresults.add(item);
        }
      }
      payments.value = searchPaymentsresults;
    }
  }

  // ***********************************

  // get payroll_range
  void getPayrollRange({required DateTime dateTimePayroll}) {
    var timePayroll = dateTimePayroll;
    var monthsPayroll = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    for (var item in monthsPayroll) {
      var newTimePayroll =
          DateTime(dateTimePayroll.year, item, dateTimePayroll.day);

      // List<PayrollFrame> payrollFrms = [];

      var responsePayrollFrames =
          arrangeTimeFrame(monthIndex: item, yearIndex: timePayroll.year);
      // payrollFrms.add(PayrollFrame(
      //     dateEnd: responsePayrollFrames[0],
      //     dateStart: responsePayrollFrames[1]));
      payrollFrames.add(PayrollRangeFrame(
          date: formatDate(dateToFormat: newTimePayroll),
          payrollFrames: responsePayrollFrames));
      // payrollFrames.add(responsePayrollFrames[1]);
    }
    // set current time_frame
    for (var i = 0; i < payrollFrames.length; i++) {
      // var payrollTimeFormatted = DateTime.parse(payrollFrames[i].date!);
      List<PayrollFrame> payrollFrmsTms = [...payrollFrames[i].payrollFrames!];
      for (var index = 0; index < payrollFrmsTms.length; index++) {
        var currentStartTime = DateTime.parse(payrollFrmsTms[index].dateStart);
        var currentEndTime = DateTime.parse(payrollFrmsTms[index].dateEnd);
        var currentTimePayroll =
            DateTime(timePayroll.year, timePayroll.month, timePayroll.day);
        var currentTimePayrollStart = DateTime(currentStartTime.year,
            currentStartTime.month, currentStartTime.day);
        var currentTimePayrollEnd = DateTime(
            currentEndTime.year, currentEndTime.month, currentEndTime.day);
        if ((currentTimePayroll.isAfter(currentTimePayrollStart) &&
                currentTimePayroll.isBefore(currentTimePayrollEnd)) ||
            (currentTimePayroll.isAtSameMomentAs(currentTimePayrollStart) ||
                currentTimePayroll.isAtSameMomentAs(currentTimePayrollEnd))) {
          // print("founddddddddddddd");
          // print(payrollFrmsTms[index]);
          dataPayroll.value = payrollFrmsTms[index];
          selectedCurrentPayrollIndex.value = i;
          // setDateIndex(index: i);
        }
      }
    }
  }

  getPayrollWorkerHistory(
      {required PayrollFrame payrollFrame, required int projectiD}) async {
    isLoading.value = true;
    var response = await _dataProvider.getPayrollWorkersHistory(
        endPoint:
            "${Enpoints.payrollWorkersEnpoint}?date_gte=${payrollFrame.dateStart}&date_lte=${payrollFrame.dateEnd}&_limit=-1&project_id=$projectiD");
    if (response.error) {
      negativeMessage(message: "${response.errorMessage}");
    } else {
      allPayrollWorkers.value = response.response!;
      payrollWorkers.value = response.response!;
      // print("workers length :: ${response.response!.length}");
    }
    isLoading.value = false;
  }

  void getData({required Project project, required DateTime timeNow}) async {
    var newService = Services(id: 0, name: 'All');
    allServices.value = [newService, ...project.services!];
    getPayrollRange(dateTimePayroll: timeNow);
    await getPayrollWorkerHistory(
        payrollFrame: dataPayroll.value, projectiD: project.projectId!);
    selectedService.value = 0;
  }

  getDeductionWorkerRange(
      {required int workerId, required PayrollFrame timeFrame}) async {
    // isLoadingDeduction.value = true;
    // var endPoint =
    //     "${Enpoints.deductionWorkerRangeEnpoint}/$workerId?start_date=${timeFrame.dateStart}&end_date=${timeFrame.dateEnd}";
    // var response = await _dataProvider.deductionRange(endPoint: endPoint);
    // if (response.error) {
    //   negativeMessage(message: response.errorMessage!);
    //   isLoadingDeduction.value = false;
    // } else {
    //   totalDeductions.value = response.response!;
    //   isLoadingDeduction.value = false;
    // }
    // isLoadingDeduction.value = false;
  }

  void getProjects() {
    projects.value = mainController.projects;
  }

  void setPayrollTimeFrame(
      {required PayrollFrame timeFrame, required int projectId}) {
    dataPayroll.value = timeFrame;
    getPayrollWorkerHistory(payrollFrame: timeFrame, projectiD: projectId);
  }

  // change service
  void changeService(
      {required int id,
      required String serviceName,
      required Services service}) {
    selectedService.value = id;
    if (id == 0) {
      payrollWorkers.value = allPayrollWorkers;
    } else {
      payrollWorkers.value =
          allPayrollWorkers.where((item) => item.serviceId == id).toList();
    }
  }

  void setIsSearching({required bool status}) {
    selectedService.value = 0;
    isSearching.value = !status;
    payrollWorkers.value = allPayrollWorkers;
  }

  void searchWorkers({required String data, required bool isEmpty}) {
    List<PayrollWorkers> workersTable = [];
    if (isEmpty) {
      payrollWorkers.value = allPayrollWorkers;
    } else {
      for (var item in allPayrollWorkers) {
        var workerName = "${item.firstName} ${item.lastName}";
        if (workerName.trim().toLowerCase().contains(data) ||
            workerName.trim().toLowerCase() == data ||
            item.phoneNumber!.contains(data)) {
          workersTable.add(item);
        }
      }
    }
    payrollWorkers.value = workersTable;
  }

  @override
  void onInit() {
    getProjects();
    super.onInit();
  }
}

// class HomePayrollController extends GetxController {
//   final MainController mainController = Get.find();
//   RxBool isLoading = false.obs;
//   final _dataProvider = DataProvider();
//   RxList<Payroll> payrolls = <Payroll>[].obs;
//   RxList<Project> projects = <Project>[].obs;
//   RxList<TablePayroll> workerTablePayroll = <TablePayroll>[].obs;
//   Rx<PayrollHistory> allPayrollsHistories = PayrollHistory().obs;
//   Rx<PayrollHistory> allDataPayrollsHistories = PayrollHistory().obs;
//   RxList<Services> allServices = <Services>[].obs;
//   RxInt selectedCurrentPayrollIndex = 0.obs;
//   RxInt selectedService = 0.obs;

//   bool getExtra({required TablePayroll tablePayroll, required int serviceId}) {
//     bool status = false;
//     for (var item in tablePayroll.extra!) {
//       if (item.level == serviceId) {
//         status = true;
//       }
//     }

//     return status;
//   }

//   void getPayrollHistoryPerService({required Services service}) {
//     if (service.id == 0) {
//       // payrollsHistories.value = allPayrollsHistories.value;
//       workerTablePayroll.value = allPayrollsHistories.value.table!;
//     } else {
//       // PayrollHistory extra = PayrollHistory();
//       List<TablePayroll> tablePayroll = [];
//       for (var item in allPayrollsHistories.value.table!) {
//         if (getExtra(tablePayroll: item, serviceId: service.id!)) {
//           tablePayroll.add(item);
//         }
//       }
//       // extra = PayrollHistory(
//       //     payrollId: allPayrollsHistories.value.payrollId,
//       //     meta: allPayrollsHistories.value.meta,
//       //     table: tablePayroll);
//       workerTablePayroll.value = tablePayroll;
//     }
//   }

//   void getProjects() {
//     projects.value = mainController.projects;
//   }

//   RxBool isSearching = false.obs;
//   // RxList<String> tabs = ["All", "Helpers", "Carpentry", "Mason"].obs;
//   RxList<Map<String, dynamic>> dataPayrolls = <Map<String, dynamic>>[].obs;
//   RxMap<String, dynamic> dataPayroll = <String, dynamic>{}.obs;
//   RxList<Map<String, dynamic>> dataMonths = <Map<String, dynamic>>[
//     {
//       "month_name": "January",
//       "month_code": "01",
//       "month_year": DateTime.now().year
//     },
//     {
//       "month_name": "February",
//       "month_code": "02",
//       "month_year": DateTime.now().year
//     },
//     {
//       "month_name": "March",
//       "month_code": "03",
//       "month_year": DateTime.now().year
//     },
//     {
//       "month_name": "April",
//       "month_code": "04",
//       "month_year": DateTime.now().year
//     },
//     {
//       "month_name": "May",
//       "month_code": "05",
//       "month_year": DateTime.now().year
//     },
//     {
//       "month_name": "June",
//       "month_code": "06",
//       "month_year": DateTime.now().year
//     },
//     {
//       "month_name": "July",
//       "month_code": "07",
//       "month_year": DateTime.now().year
//     },
//     {
//       "month_name": "August",
//       "month_code": "08",
//       "month_year": DateTime.now().year
//     },
//     {
//       "month_name": "September",
//       "month_code": "09",
//       "month_year": DateTime.now().year
//     },
//     {
//       "month_name": "October",
//       "month_code": "10",
//       "month_year": DateTime.now().year
//     },
//     {
//       "month_name": "November",
//       "month_code": "11",
//       "month_year": DateTime.now().year
//     },
//     {
//       "month_name": "December",
//       "month_code": "12",
//       "month_year": DateTime.now().year
//     },
//   ].obs;

//   void setPayrollTimeFrame({required Map<String, dynamic> timeFrame}) {
//     dataPayroll.value = timeFrame;
//     getAllWorkersPayrollSummary();
//   }

//   List<Map<String, dynamic>> arrangeTimeFrames({required List<Payroll> items}) {
//     List<Map<String, dynamic>> dataArranged = [];
//     for (var item in items) {
//       dataArranged.add({
//         "id": item.id,
//         "date_range": item.dateRange,
//         "start-date": item.startDate,
//         "end-date": item.endDate
//       });
//     }

//     return dataArranged;
//   }

//   // Payroll getPayroll()

//   void constructPayrolls({required List<Payroll> payrollItems}) {
//     for (var item in dataMonths) {
//       var payrollResponse = payrollItems
//           .where((pyrll) => pyrll.dateRange!.contains(item["month_code"]))
//           .toList();
//       dataPayrolls.add({
//         "month_name": item["month_name"],
//         "month_code": item["month_code"],
//         "month_year": item["month_year"],
//         "payrolls": arrangeTimeFrames(items: payrollResponse)
//       });
//     }
//   }

//   void setIsSearching({required bool status}) {
//     selectedService.value = 0;
//     isSearching.value = !status;
//     workerTablePayroll.value = allPayrollsHistories.value.table!;
//   }

//   void getcurrentPayroll({required DateTime time}) {
//     for (var i = 0; i < dataPayrolls.length; i++) {
//       if (int.parse(dataPayrolls[i]["month_code"]) == time.month) {
//         selectedCurrentPayrollIndex.value = i;

//         setPayrollTimeFrame(timeFrame: dataPayrolls[i]["payrolls"][0]);
//       }
//     }
//   }

//   void getNextPayroll({required int currentPayrollIndex}) {
//     selectedCurrentPayrollIndex.value = currentPayrollIndex;
//   }

//   getPayroll({required DateTime time, required Project project}) async {
//     var response = await _dataProvider.getPayrolls(
//         endPoint:
//             "${Enpoints.payrollEnpoint}?project_id=${project.projectId}&year=${time.year}");
//     if (response.error) {
//       negativeMessage(message: response.errorMessage!);
//     } else {
//       constructPayrolls(payrollItems: response.response!);
//       getcurrentPayroll(time: time);
//     }
//   }

//   getAllWorkersPayrollSummary() async {
//     isLoading.value = true;
//     var response = await _dataProvider.getPayrollsHistories(
//         endPoint: Enpoints.payrollSummaryEnpoint,
//         body: {"payroll_id": dataPayroll["id"]});
//     if (response.error) {
//       negativeMessage(message: response.errorMessage!);
//     } else {
//       allDataPayrollsHistories.value = response.response!;
//       allPayrollsHistories.value = response.response!;
//       workerTablePayroll.value = response.response!.table!;
//       isLoading.value = false;
//       // payrollsHistories.value = response.response!;
//     }
//   }

//   // change service
//   void changeService(
//       {required int id,
//       required String serviceName,
//       required Services service}) {
//     selectedService.value = id;
//     getPayrollHistoryPerService(service: service);
//   }

//   void getData({required DateTime time, required Project project}) async {
//     isLoading.value = true;
//     var newService = Services(id: 0, name: 'All');
//     allServices.value = [newService, ...project.services!];
//     await getPayroll(project: project, time: time);
//     // get all workers payroll history
//     await getAllWorkersPayrollSummary();
//     isLoading.value = false;
//   }

//   // search worker
//   bool searchByConcatenation({required String workerName, required dataName}) {
//     var firstnameLastNamee = workerName;
//     var statusNameConcatenation = false;
//     if (firstnameLastNamee == dataName) {
//       statusNameConcatenation = true;
//     }

//     return statusNameConcatenation;
//   }

//   void searchWorkers({required String data, required bool isEmpty}) {
//     List<TablePayroll> workersTable = [];
//     if (isEmpty) {
//       workerTablePayroll.value = allDataPayrollsHistories.value.table!;
//     } else {
//       for (var item in allPayrollsHistories.value.table!) {
//         if (item.workerName != null) {
//           if (item.workerName!.trim().toLowerCase().contains(data) ||
//               item.workerName!.trim().toLowerCase() == data) {
//             workersTable.add(item);
//           }
//         }
//       }
//     }
//     workerTablePayroll.value = workersTable;
//   }

//   // void searchWorkers({required String data, required bool isEmpty}) {
//   //   print(
//   //       "data :: ${allPayrollsHistories.value.table!.length} :: ${payrollsHistories.value.table!.length}");
//   //   selectedService.value = 0;
//   //   PayrollHistory newWorkers = PayrollHistory();
//   //   List<TablePayroll> tableWorkers = [];
//   //   if (isEmpty) {
//   //     newWorkers = allPayrollsHistories.value;
//   //   } else {
//   //     for (var item in allPayrollsHistories.value.table!) {
//   //       if (item.workerName!.contains(data)) {
//   //         tableWorkers.add(item);
//   //       }
//   //     }
//   //     newWorkers = PayrollHistory(
//   //         meta: allPayrollsHistories.value.meta,
//   //         payrollId: allPayrollsHistories.value.payrollId,
//   //         table: tableWorkers);
//   //   }
//   //   payrollsHistories.value = newWorkers;
//   // }

//   @override
//   void onInit() {
//     getProjects();
//     super.onInit();
//   }
// }
