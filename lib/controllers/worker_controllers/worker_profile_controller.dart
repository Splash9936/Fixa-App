import 'package:fixa/fixa_main_routes.dart';
import 'package:intl/intl.dart';

class WorkerProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _dataProvider = DataProvider();
  final MainController mainController = Get.find();
  RxList<DeductionTypes> deductionsTypes = <DeductionTypes>[].obs;
  RxList<Deductions> deductions = <Deductions>[].obs;
  TabController? tabController;
  RxInt firstDateIndex = 0.obs;
  RxInt lastDateIndex = 0.obs;
  RxList<PayrollFrame> payrollFrames = <PayrollFrame>[].obs;
  RxList<PayrollFrame> payrollFrameSelected = <PayrollFrame>[].obs;
  Rx<WorkerProfile> workerProfile = WorkerProfile().obs;
  Rx<WorkerHistory> workerHistories = WorkerHistory().obs;
  RxList<WorkerPayroll> workerPayrollHistories = <WorkerPayroll>[].obs;
  RxList<WorkerPayroll> allWorkerPayrollHistories = <WorkerPayroll>[].obs;
  bool isLoading = false;
  RxBool isgettingDeduction = false.obs;
  RxBool isgettingWorkerHistory = false.obs;
  RxBool isAddingDeduction = false.obs;
  final _apiHandler = ApiHandler();
  List<Map<String, dynamic>> tabs = [
    {"tab_id": 0, "tab_name": "Details"},
    {"tab_id": 1, "tab_name": "Shifts"}
  ];
  List<String> levels = ["Level 1"];
  RxList<DeductionControllers> deductionsControllers =
      <DeductionControllers>[].obs;
  RxList<Widget> serviceWidgets = <Widget>[].obs;
  int selectedTab = 0;
  // *********************** payroll data *****************
  RxList<Map<String, dynamic>> dataPayrolls = <Map<String, dynamic>>[].obs;
  Rx<PayrollFrame> dataPayroll = PayrollFrame(dateStart: "", dateEnd: "").obs;
  RxInt selectedCurrentPayrollIndex = 0.obs;

  RxList<Map<String, dynamic>> dataMonths = <Map<String, dynamic>>[
    {
      "month_name": "January",
      "month_code": "01",
      "month_year": DateTime.now().year
    },
    {
      "month_name": "February",
      "month_code": "02",
      "month_year": DateTime.now().year
    },
    {
      "month_name": "March",
      "month_code": "03",
      "month_year": DateTime.now().year
    },
    {
      "month_name": "April",
      "month_code": "04",
      "month_year": DateTime.now().year
    },
    {
      "month_name": "May",
      "month_code": "05",
      "month_year": DateTime.now().year
    },
    {
      "month_name": "June",
      "month_code": "06",
      "month_year": DateTime.now().year
    },
    {
      "month_name": "July",
      "month_code": "07",
      "month_year": DateTime.now().year
    },
    {
      "month_name": "August",
      "month_code": "08",
      "month_year": DateTime.now().year
    },
    {
      "month_name": "September",
      "month_code": "09",
      "month_year": DateTime.now().year
    },
    {
      "month_name": "October",
      "month_code": "10",
      "month_year": DateTime.now().year
    },
    {
      "month_name": "November",
      "month_code": "11",
      "month_year": DateTime.now().year
    },
    {
      "month_name": "December",
      "month_code": "12",
      "month_year": DateTime.now().year
    },
  ].obs;

  // verify worker
  verifyWorker(
      {required int projectId,
      required int assignWorkerId,
      required int workerId}) async {
    var response = await _apiHandler.postRequestMethod(
        headers: await _dataProvider.headerDetails(),
        body: {"worker_id": workerId, "is_verified": true},
        endPoint: Enpoints.verifyWorkerEnpoint);
    if (response.error) {
      negativeMessage(message: "An error happened");
    } else {
      // get and update worker
      var workerToUpdate =
          await DatabaseService.instance.getAssingedWorkerProjectIdSaved(
        assignedWorkerId: assignWorkerId,
        projectId: projectId,
      );
      if (workerToUpdate.isNotEmpty) {
        await DatabaseService.instance.updateWorker(
            id: workerToUpdate[0].id!,
            worker: AssignedWorkers(
              id: workerToUpdate[0].id,
              assignedWorkerId: workerToUpdate[0].assignedWorkerId,
              workerId: workerToUpdate[0].workerId,
              projectId: workerToUpdate[0].projectId,
              firstName: workerToUpdate[0].firstName,
              isVerified: 'true',
              district: workerToUpdate[0].district,
              lastName: workerToUpdate[0].lastName,
              phoneNumber: workerToUpdate[0].phoneNumber,
              nidNumber: workerToUpdate[0].nidNumber,
              rates: workerToUpdate[0].rates,
              services: workerToUpdate[0].services,
            ));
      }
      await getWorkerProfileInfo(
          assignedWorkerId: assignWorkerId,
          workerId: workerId,
          workerProjectId: projectId);
      await mainController.getAttendances(
          time: mainController.dateTme.value, projectId: projectId);
      await mainController.getWorkersFromProject(projectId: projectId);
      positiveMessage(message: "Worker verified Succesfully");
    }
  }

  // void getPayrollByTime({required Map<String, dynamic> timeFrame}) {
  //   var startTime = DateTime.parse(timeFrame["start-date"]);
  //   var endTime = DateTime.parse(timeFrame["end-date"]);
  //   List<WorkerPayroll> allWorkerPayroll = [];
  //   for (var item in allWorkerPayrollHistories) {
  //     var payrollTime = DateTime.parse(item.attendanceDate!);
  //     if (payrollTime.isAfter(startTime) && payrollTime.isBefore(endTime)) {
  //       allWorkerPayroll.add(item);
  //     }
  //   }
  //   workerPayrollHistories.value = allWorkerPayroll;
  // }

  void changeTabIndex({required int indexTab}) {
    selectedTab = indexTab;
    update();
  }

  void setPayrollTimeFrame(
      {required PayrollFrame timeFrame, required int workerId}) {
    dataPayroll.value = timeFrame;
    // print("time frame :: ${timeFrame}");
    getWorkerHistory(workerId: workerId, timeFrame: timeFrame);
    // getPayrollByTime(timeFrame: timeFrame);
    // getAllWorkersPayrollSummary();
  }

  List<Map<String, dynamic>> arrangeTimeFrames({required List<Payroll> items}) {
    List<Map<String, dynamic>> dataArranged = [];
    for (var item in items) {
      dataArranged.add({
        "id": item.id,
        "date_range": item.dateRange,
        "start-date": item.startDate,
        "end-date": item.endDate
      });
    }

    return dataArranged;
  }

  // Payroll getPayroll()

  void constructPayrolls({required List<Payroll> payrollItems}) {
    for (var item in dataMonths) {
      var payrollResponse = payrollItems
          .where((pyrll) => pyrll.dateRange!.contains(item["month_code"]))
          .toList();
      dataPayrolls.add({
        "month_name": item["month_name"],
        "month_code": item["month_code"],
        "month_year": item["month_year"],
        "payrolls": arrangeTimeFrames(items: payrollResponse)
      });
    }
  }

  // void getcurrentPayroll({required DateTime time}) {
  //   for (var i = 0; i < dataPayrolls.length; i++) {
  //     if (int.parse(dataPayrolls[i]["month_code"]) == time.month) {
  //       selectedCurrentPayrollIndex.value = i;

  //       setPayrollTimeFrame(timeFrame: dataPayrolls[i]["payrolls"][0]);
  //     }
  //   }
  // }

  void getNextPayroll({required int currentPayrollIndex}) {
    dataPayroll.value = payrollFrames[currentPayrollIndex];
    selectedCurrentPayrollIndex.value = currentPayrollIndex;
    // selectedCurrentPayrollIndex.value = currentPayrollIndex;
    setDateIndex(index: currentPayrollIndex);
    // print("indexxx :: $currentPayrollIndex");
  }

  void changeYear({required int currentPayrollIndex,required int yearr}) {
    if(yearr <= DateTime.now().year){
     getPayrollRange(datePayrll:DateTime(yearr));
    dataPayroll.value = payrollFrames[currentPayrollIndex];
    selectedCurrentPayrollIndex.value = currentPayrollIndex;
    setDateIndex(index: currentPayrollIndex);
    }
  }

  

  // getPayroll({required DateTime time, required int projectId}) async {
  //   var response = await _dataProvider.getPayrolls(
  //       endPoint:
  //           "${Enpoints.payrollEnpoint}?project_id=$projectId&year=${time.year}");
  //   if (response.error) {
  //     negativeMessage(message: response.errorMessage!);
  //   } else {
  //     constructPayrolls(payrollItems: response.response!);
  //     getcurrentPayroll(time: time);
  //   }
  // }

  // *********************** payroll data *****************

  // get worker payroll history
  // getWorkerPayrollHistory({required int workerId}) async {
  //   var response = await _dataProvider.getWorkerPayrollHistory(
  //       endPoint:
  //           "${Enpoints.workerHistoryPayrollEnpoint}?worker_id=$workerId");
  //   if (response.error) {
  //     negativeMessage(message: response.errorMessage!);
  //   } else {
  //     workerPayrollHistories.value = response.response!;
  //     allWorkerPayrollHistories.value = response.response!;
  //   }
  // }

  // // add service
  void addDeduction() {
    deductionsControllers
        .add(DeductionControllers(0, 0, TextEditingController(), false));
    // serviceWidgets.add(widget);
  }

  // add service
  void removeDeduction({required DeductionControllers deductionController}) {
    deductionsControllers.remove(deductionController);
  }

  // get worker profile info
  getWorkerProfileInfo(
      {required int workerProjectId,
      required int workerId,
      required int assignedWorkerId}) async {
    isLoading = true;
    update();
    var response = await _dataProvider.getWorkerProfileInfo(
        endPoint:
            "${Enpoints.workerProfileInfoEnpoint}/$workerId?project_id=$workerProjectId");
    if (!response.error) {
      isLoading = false;
      workerProfile.value = response.response!;
      update();
    } else {
      isLoading = false;
      negativeMessage(message: response.errorMessage!);
      update();
    }
    isLoading = false;

    getDeductionTypes(projectId: workerProjectId);
    getPayrollRange(datePayrll:DateTime.now());
    // await getWorkerPayrollHistory(workerId: workerId);
    await getWorkerHistory(workerId: workerId, timeFrame: dataPayroll.value);
    await getWorkerDeductions(
        time: DateTime.now(),
        projectId: workerProjectId,
        assignedWorkerId: assignedWorkerId);
    // await getPayroll(time: DateTime.now(), projectId: workerProjectId);
    update();
  }

  void getDeductionTypes({required int projectId}) async {
    var response = await _dataProvider.getDeductionsTypes(
        endPoint:
            "${Enpoints.deductionTYpes}?project_id=$projectId&is_available=true");
    if (!response.error) {
      deductionsTypes.value = response.response!;
    }
  }

  // get payroll time range
  // check date range
  checkDateRange({required DateTime time}) {
    String dateRange = "";

    // final now = DateTime.now();
    var date = DateTime(time.year, time.month + 1, 0).toString();
    var dateParse = DateTime.parse(date);

    // var today = DateTime.now();
    var day1 = DateTime(time.year, time.month, 1);
    var day15 = DateTime(time.year, time.month, 15);
    var day16 = DateTime(time.year, time.month, 16);
    var lastDay = DateTime(time.year, time.month, dateParse.day);

    var dateMonth1 = day1.month <= 9 ? "0${day1.month}" : day1.month;
    var dateMonth15 = day15.month <= 9 ? "0${day15.month}" : day15.month;
    var dateMonth16 = day16.month <= 9 ? "0${day16.month}" : day16.month;
    var dateMonthlast =
        lastDay.month <= 9 ? "0${lastDay.month}" : lastDay.month;

    if (time.day >= day1.day && time.day <= day15.day) {
      dateRange = "${day1.day}/$dateMonth1 - ${day15.day}/$dateMonth15";
    } else if (time.day >= day16.day && time.day <= lastDay.day) {
      dateRange = "${day16.day}/$dateMonth16 - ${lastDay.day}/$dateMonthlast";
    }

    return dateRange;
  }

  List<Map<String, dynamic>> getDeductionBody() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(DateTime.now());
    List<Map<String, dynamic>> deductionBody = [];
    for (var item in deductionsControllers) {
      deductionBody.add({
        "type_id": item.deductionTypeId,
        "date": formattedDate,
        "deduction_id": item.deductionId,
        "amount": item.deductedAmount.text
      });
    }
    return deductionBody;
  }

  // remove worker deduction by id
  // removeWorkerDeduction(
  //     {required int projectId,
  //     required int deductionId,
  //     required int assignedWorkerId,
  //     required DateTime time}) async {
  //   isAddingDeduction.value = true;
  //   var responseRemoveDeduction = await _apiHandler.deleteRequestMethod(
  //       headers: await _dataProvider.headerDetails(),
  //       endPoint: "${Enpoints.deductionUrl}/$deductionId");
  //   if (responseRemoveDeduction.error) {
  //     negativeMessage(message: "${responseRemoveDeduction.errorMessage}");
  //     await getWorkerDeductions(
  //         projectId: projectId, assignedWorkerId: assignedWorkerId, time: time);
  //     isAddingDeduction.value = false;
  //   } else {
  //     deductionsControllers.value = [];
  //     positiveMessage(message: "successfully, dedution removed");
  //     isAddingDeduction.value = false;
  //   }
  // }

  // void saveDeductions(
  //     {required Project project,
  //     required int workerAssignedId,
  //     required BuildContext context}) async {
  //   isAddingDeduction.value = true;
  //   // get payroll
  //   // var rangeTime = checkDateRange(time: DateTime.now());
  //   // var payrollEnpoint =
  //   //     "${Enpoints.payrollEnpoint}?date_range=$rangeTime&project_id=${project.projectId}&year=${DateTime.now().year}";

  //   // var response = await _dataProvider.getPayrolls(endPoint: payrollEnpoint);
  //   // if (!response.error) {
  //   var payload = {
  //     "project_id": project.projectId,
  //     "payroll_id": 0,
  //     "assigned_worker_id": workerAssignedId,
  //     "deductions": getDeductionBody(),
  //   };
  //   var responseDeduction = await _apiHandler.postRequestMethod(
  //       headers: await _dataProvider.headerDetails(),
  //       body: payload,
  //       endPoint: Enpoints.deductionEnpoint);
  //   if (responseDeduction.error) {
  //     negativeMessage(message: "${responseDeduction.errorMessage}");
  //     isAddingDeduction.value = false;
  //   } else {
  //     deductionsControllers.value = [];
  //     positiveMessage(message: "Deduction successfully applied");
  //     Navigator.pop(context);
  //     isAddingDeduction.value = false;
  //   }
  //   // } else {
  //   //   negativeMessage(message: "${response.errorMessage}");
  //   //   isAddingDeduction.value = false;
  //   // }

  //   isAddingDeduction.value = false;
  // }

  // get worker deductions
  getWorkerDeductions(
      {required int projectId,
      required DateTime time,
      required int assignedWorkerId}) async {
    isgettingDeduction.value = true;
    deductionsControllers.value = [];
    // get payroll
    // var rangeTime = checkDateRange(time: time);
    // var payrollEnpoint =
    //     "${Enpoints.payrollEnpoint}?date_range=$rangeTime&project_id=$projectId&year=${time.year}";

    // var response = await _dataProvider.getPayrolls(endPoint: payrollEnpoint);
    // if (!response.error) {
    // var dedutionEndPoint =
    //     "${Enpoints.getDeductionEnpoint}?project_id=$projectId&assigned_worker_id=$assignedWorkerId&_sort=id:DESC";
    // var deductionsResponse =
    //     await _dataProvider.getWorkerDeductions(endPoint: dedutionEndPoint);
    // if (!deductionsResponse.error) {
    //   deductions.value = deductionsResponse.response!;
    //   for (var item in deductionsResponse.response!) {
    //     deductionsControllers.add(DeductionControllers(
    //         item.id!,
    //         item.deductionTypeId!,
    //         TextEditingController(text: item.deductionAmount.toString())));
    //   }
    // } else {
    //   negativeMessage(message: "${deductionsResponse.errorMessage}");
    //   isgettingDeduction.value = false;
    // }
    // } else {
    //   negativeMessage(message: "${response.errorMessage}");
    // }

    isgettingDeduction.value = false;
  }

  formatDate({required DateTime dateToFormat}) {
    String dateFormated = "";
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    dateFormated = formatter.format(dateToFormat);
    return dateFormated;
  }

  arrangeTimeFrame({required int monthIndex, required int yearIndex}) {
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

  void setDateIndex({required int index}) {
    // print("indexx inside :: $index");
    switch (index) {
      case 0:
        firstDateIndex.value = 0;
        lastDateIndex.value = 1;
        break;
      case 1:
        firstDateIndex.value = 0;
        lastDateIndex.value = 1;
        break;
      case 2:
        firstDateIndex.value = 2;
        lastDateIndex.value = 3;
        break;
      case 3:
        firstDateIndex.value = 2;
        lastDateIndex.value = 3;
        break;
      case 4:
        firstDateIndex.value = 4;
        lastDateIndex.value = 5;
        break;
      case 5:
        firstDateIndex.value = 4;
        lastDateIndex.value = 5;
        break;
      case 6:
        firstDateIndex.value = 6;
        lastDateIndex.value = 7;
        break;
      case 7:
        firstDateIndex.value = 6;
        lastDateIndex.value = 7;
        break;
      case 8:
        firstDateIndex.value = 8;
        lastDateIndex.value = 9;
        break;
      case 9:
        firstDateIndex.value = 8;
        lastDateIndex.value = 9;
        break;
      case 10:
        firstDateIndex.value = 10;
        lastDateIndex.value = 11;
        break;
      case 11:
        firstDateIndex.value = 10;
        lastDateIndex.value = 11;
        break;
      case 12:
        firstDateIndex.value = 12;
        lastDateIndex.value = 13;
        break;
      case 13:
        firstDateIndex.value = 12;
        lastDateIndex.value = 13;
        break;
      case 14:
        firstDateIndex.value = 14;
        lastDateIndex.value = 15;
        break;
      case 15:
        firstDateIndex.value = 14;
        lastDateIndex.value = 15;
        break;
      case 16:
        firstDateIndex.value = 16;
        lastDateIndex.value = 17;
        break;
      case 17:
        firstDateIndex.value = 16;
        lastDateIndex.value = 17;
        break;
      case 18:
        firstDateIndex.value = 18;
        lastDateIndex.value = 19;
        break;
      case 19:
        firstDateIndex.value = 18;
        lastDateIndex.value = 19;
        break;
      case 20:
        firstDateIndex.value = 20;
        lastDateIndex.value = 21;
        break;
      case 21:
        firstDateIndex.value = 20;
        lastDateIndex.value = 21;
        break;
      case 22:
        firstDateIndex.value = 22;
        lastDateIndex.value = 23;
        break;
      case 23:
        firstDateIndex.value = 22;
        lastDateIndex.value = 23;
        break;
      default:
        firstDateIndex.value = 0;
        lastDateIndex.value = 1;
        break;
    }
    // print(
    //     "length ${payrollFrames.length} ::  start :: ${payrollFrames[index].dateStart} end :: ${payrollFrames[index].dateEnd}");
  }

  // get payroll_range
  void getPayrollRange({required DateTime datePayrll}) {
    var timePayroll = datePayrll;
    var monthsPayroll = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    payrollFrames.value =[];
    for (var item in monthsPayroll) {
      var responsePayrollFrames =
          arrangeTimeFrame(monthIndex: item, yearIndex: timePayroll.year);
      payrollFrames.add(responsePayrollFrames[0]);
      payrollFrames.add(responsePayrollFrames[1]);
    }
    // set current time_frame
    for (var i = 0; i < payrollFrames.length; i++) {
      var currentStartTime = DateTime.parse(payrollFrames[i].dateStart);
      var currentEndTime = DateTime.parse(payrollFrames[i].dateEnd);
      var currentTimePayroll =
          DateTime(timePayroll.year, timePayroll.month, timePayroll.day);
      var currentTimePayrollStart = DateTime(
          currentStartTime.year, currentStartTime.month, currentStartTime.day);
      var currentTimePayrollEnd = DateTime(
          currentEndTime.year, currentEndTime.month, currentEndTime.day);
      // print(
      //     "converted date :: $convertedTimePayroll loop :: ${payrollFrames[i].dateStart} - ${payrollFrames[i].dateEnd}");
      if ((currentTimePayroll.isAfter(currentTimePayrollStart) &&
              currentTimePayroll.isBefore(currentTimePayrollEnd)) ||
          (currentTimePayroll.isAtSameMomentAs(currentTimePayrollStart) ||
              currentTimePayroll.isAtSameMomentAs(currentTimePayrollEnd))) {
        // print("foundddd");
        dataPayroll.value = payrollFrames[i];
        selectedCurrentPayrollIndex.value = i;
        setDateIndex(index: i);
      }
    }
    // for (var item in payrollFrames) {
    //   print("start :: ${item.dateStart} end :: ${item.dateEnd}");
    // }
  }

  getWorkerHistory(
      {required int workerId, required PayrollFrame timeFrame}) async {
    // print(
    //     "urllll ::> ${Enpoints.workerHistoryEnpoint}/$workerId?working_date_gte=${timeFrame.dateStart}&working_date_lte=${timeFrame.dateEnd}");
    isgettingWorkerHistory.value = true;
    var response = await _dataProvider.getWorkerHistories(
        endPoint:
            "${Enpoints.workerHistoryEnpoint}/$workerId?working_date_gte=${timeFrame.dateStart}&working_date_lte=${timeFrame.dateEnd}");
    if (response.error) {
      negativeMessage(message: response.errorMessage!);
      isgettingWorkerHistory.value = false;
    } else {
      workerHistories.value = response.response!;
      isgettingWorkerHistory.value = false;
    }
    isgettingWorkerHistory.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    // getAttendancesByFlavor();
    tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void onClose() {
    tabController!.dispose();
    super.onClose();
  }
}
