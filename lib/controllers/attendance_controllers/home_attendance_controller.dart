import 'package:fixa/fixa_main_routes.dart';
import 'package:intl/intl.dart';

class HomeAttendanceController extends GetxController {
  final MainController mainController = Get.find();

  final _dataProvider = DataProvider();
  final _apiHandler = ApiHandler();
  RxList<Project> projects = <Project>[].obs;
  // RxList<WorkerAttendance> attendances = <WorkerAttendance>[].obs;
  // RxList<WorkerAttendance> allAttendances = <WorkerAttendance>[].obs;
  // RxList<WorkerAttendance> allServicesAttendances = <WorkerAttendance>[].obs;
  RxList<Widget> serviceWidgets = <Widget>[].obs;
  RxList<Services> allServices = <Services>[].obs;
  Rx<TextEditingController> sms = TextEditingController().obs;
  // RxBool shift = false.obs;
  RxBool isAddingDeduction = false.obs;
  RxBool isAddingBulkDeduction = false.obs;
  RxBool isgettingDeduction = false.obs;
  // RxInt selectedService = 0.obs;
  RxBool isSearching = false.obs;
  RxList<WorkerAttendance> selectedWorkerData = <WorkerAttendance>[].obs;
  RxList<Deductions> deductions = <Deductions>[].obs;
  RxList<DeductionTypes> deductionsTypes = <DeductionTypes>[].obs;
  // List<int> workersAttendandedIds = [];
  RxBool issmsLoading = false.obs;
  // table calendar values
  // Rx<DateTime> dateTme = DateTime.now().obs;
  Rx<DateTime> firstDay =
      DateTime.now().subtract(const Duration(days: 1000)).obs;
  Rx<DateTime> lastDay = DateTime.now().obs;
  Rx<CalendarFormat> formatClendar = CalendarFormat.month.obs;
  RxList<DeductionControllers> deductionsControllers =
      <DeductionControllers>[].obs;
  RxMap<String, dynamic> selectedReason =
      <String, dynamic>{"id": 0, "name": "none"}.obs;
  Rx<TextEditingController> amountBulkDeduction = TextEditingController().obs;
  RxInt typeIdBulkDeduction = 0.obs;

  RxList<Map<String, dynamic>> reasons = <Map<String, dynamic>>[
    {
      "id": 1,
      "name": "Misconduct",
    },
    {
      "id": 2,
      "name": "Poor performance",
    },
    {
      "id": 3,
      "name": "Accident",
    },
    {
      "id": 4,
      "name": "No longer needed",
    },
    {
      "id": 5,
      "name": "Weather",
    },
  ].obs;
  //   List<String> userAllowedToUpdateAttendance = [
  //   "willy@fixarwanda.com",
  //   "tafara@fixarwanda.com",
  //   "stacy@fixarwanda.com",
  //   "linda@fixarwanda.com"
  // ];

  // void set reason
  void setReason({required Map<String, dynamic> setReason}) {
    selectedReason.value = setReason;
  }

  // add service
  void addDeduction() {
    deductionsControllers
        .add(DeductionControllers(0, 0, TextEditingController(), false));
    // serviceWidgets.add(widget);
  }

  // add service
  void removeDeduction({required DeductionControllers deductionController}) {
    deductionsControllers.remove(deductionController);
  }

  // search worker
  bool searchByConcatenation(
      {required String firstNamee,
      required String lastNamee,
      required String dataName}) {
    var newDataName = dataName.replaceAll(' ', '');

    // print("new data :: $newDataName");
    var firstnameLastNamee =
        "${firstNamee.toLowerCase()}${lastNamee.toLowerCase()}";
    var statusNameConcatenation = false;
    if (firstnameLastNamee.contains(newDataName.toLowerCase())) {
      statusNameConcatenation = true;
    }

    return statusNameConcatenation;
  }

  Future<AssignedWorkers> getAssignedWorker(
      {required int projectId, required int assignedWorkerId}) async {
    AssignedWorkers assignedWorker = AssignedWorkers();
    // var responseWorker = await DatabaseService.instance
    //     .getAllAssingedWorkerSaved(projectId: projectId);
    // var newResponse = responseWorker
    //     .where((item) =>
    //         item.assignedWorkerId == assignedWorkerId &&
    //         item.projectId == projectId)
    //     .toList();
    var response = await DatabaseService.instance
        .getAssingedWorkerProjectIdSaved(
            projectId: projectId, assignedWorkerId: assignedWorkerId);
    if (response.isNotEmpty) {
      assignedWorker = response[0];
    }
    return assignedWorker;
  }

  void searchWorkers({required String data, required bool isEmpty}) {
    mainController.selectedService.value = 0;
    List<WorkerAttendance> newWorkers = [];
    if (isEmpty) {
      if (mainController.shift.value) {
        newWorkers = mainController.allAttendances
            .where((item) => item.shiftName == 'night')
            .toList();
      } else {
        newWorkers = mainController.allAttendances
            .where((item) => item.shiftName == 'day')
            .toList();
      }
    } else {
      if (data.split(' ').length == 1) {
        for (var item in mainController.allAttendances) {
          searchByConcatenation(
              dataName: data.toLowerCase(),
              firstNamee: item.firstname!.toLowerCase(),
              lastNamee: item.lastname!.toLowerCase());
          if (item.firstname!.toLowerCase().contains(data) ||
              item.lastname!.toLowerCase().contains(data) ||
              item.phone!.contains(data) ||
              item.idNumber!.contains(data) ||
              searchByConcatenation(
                      dataName: data.toLowerCase(),
                      firstNamee: item.firstname!.toLowerCase(),
                      lastNamee: item.lastname!.toLowerCase()) ==
                  true) {
            newWorkers.add(item);
          }
        }
      } else if (data.split(' ').length > 1) {
        for (var item in mainController.allAttendances) {
          if (searchByConcatenation(
              dataName: data.toLowerCase(),
              firstNamee: item.firstname!.toLowerCase(),
              lastNamee: item.lastname!.toLowerCase())) {
            newWorkers.add(item);
          }
        }
      }
    }
    if (mainController.shift.value) {
      mainController.attendances.value =
          newWorkers.where((item) => item.shiftName == 'night').toList();
    } else {
      mainController.attendances.value =
          newWorkers.where((item) => item.shiftName == 'day').toList();
    }
  }

  // change service
  void changeService({required int id, required String serviceName}) {
    mainController.selectedService.value = id;
    if (id == 0) {
      // get all workers on the current shift
      if (mainController.shift.value) {
        // night
        mainController.attendances.value = mainController.allAttendances
            .where((item) => item.shiftName == "night")
            .toList();
      } else {
        // day
        mainController.attendances.value = mainController.allAttendances
            .where((item) => item.shiftName == "day")
            .toList();
      }
    } else {
      // get worker on a specific service on the current shift
      if (mainController.shift.value) {
        // night
        mainController.attendances.value = mainController.allAttendances
            .where((item) =>
                item.shiftName == "night" &&
                item.service != null &&
                item.service!.toLowerCase() == serviceName)
            .toList();
      } else {
        // day
        mainController.attendances.value = mainController.allAttendances
            .where((item) =>
                item.shiftName == "day" &&
                item.service != null &&
                item.service!.toLowerCase() == serviceName)
            .toList();
      }
    }
  }

  void changeDate({required DateTime time, required int projectId}) {
    mainController.dateTme.value = time;

    mainController.getAttendances(projectId: projectId, time: time);
  }

  void toggleShifts({required bool status}) {
    mainController.selectedService.value = 0;
    mainController.shift.value = !status;
    if (mainController.shift.value) {
      mainController.attendances.value = mainController.allAttendances
          .where((item) => item.shiftName == "night")
          .toList();
    } else {
      mainController.attendances.value = mainController.allAttendances
          .where((item) => item.shiftName == "day")
          .toList();
    }
  }

  void addWorker({required WorkerAttendance toAdd}) {
    if (selectedWorkerData.contains(toAdd)) {
      var index = mainController.attendances.length;
      selectedWorkerData.remove(toAdd);
      mainController.attendances.remove(toAdd);
      mainController.allAttendances.remove(toAdd);
      mainController.attendances.insert(index - 1, toAdd);
      mainController.allAttendances.insert(index - 1, toAdd);
    } else {
      selectedWorkerData.add(toAdd);
      mainController.attendances.remove(toAdd);
      mainController.allAttendances.remove(toAdd);
      mainController.attendances.insert(0, toAdd);
      mainController.allAttendances.insert(0, toAdd);
    }
  }

  void setIsSearching({required bool status}) {
    isSearching.value = !status;
  }

  List<Map<String, dynamic>> getWorkersAttendedIds(
      {required int typeId,
      required int deductionAmountP,
      required List<WorkerAttendance> worrkers}) {
    List<Map<String, dynamic>> dataIDeductions = [];
    for (var item in worrkers) {
      dataIDeductions.add({
        "type_id": typeId,
        "amount": deductionAmountP,
        "assigned_worker_id": item.assignedWorkerId
      });
    }
    return dataIDeductions;
  }

  // get attendance by shift
  List<WorkerAttendance> getAttendanceByShift(
      {required List<WorkerAttendance> workersAttendance}) {
    List<WorkerAttendance> responseAttendance = [];
    if (mainController.shift.value) {
      responseAttendance = workersAttendance
          .where((item) => item.shiftName!.toLowerCase() == "night")
          .toList();
    } else {
      responseAttendance = workersAttendance
          .where((item) => item.shiftName!.toLowerCase() == "day")
          .toList();
    }

    return responseAttendance;
  }

  // getAttendances({required DateTime time, required int projectId}) async {
  //   isLoading.value = true;
  //   selectedService.value = 0;
  //   workersAttendandedIds = [];
  //   final DateFormat formatter = DateFormat('yyyy-MM-dd');
  //   final String formattedDate = formatter.format(time);
  //   var response = await _dataProvider.getAttendance(
  //       endPoint:
  //           "${Enpoints.viewAttendanceEnpoint}?attendance_date=$formattedDate&project_id=$projectId");
  //   if (!response.error) {
  //     allAttendances.value = response.response!;
  //     attendances.value =
  //         getAttendanceByShift(workersAttendance: response.response!);
  //     allServicesAttendances.value = response.response!;
  //     workersAttendandedIds =
  //         getWorkersAttendedIds(worrkers: response.response!);
  //     isLoading.value = false;
  //   } else {
  //     negativeMessage(message: response.errorMessage!);
  //     isLoading.value = false;
  //   }
  // }

  void addAllService({required Project project}) {
    var projectServices = project.services!;
    var newService = Services(id: 0, name: 'All');
    allServices.value = [newService, ...projectServices];
  }

  void getDeductionTypes({required Project project}) async {
    var response = await _dataProvider.getDeductionsTypes(
        endPoint:
            "${Enpoints.deductionTYpes}?is_external=false&is_available=true");
    if (!response.error) {
      deductionsTypes.value = response.response!;
    }
  }

  void getData({required Project project, required DateTime time}) {
    addAllService(project: project);
    mainController.getAttendances(projectId: project.projectId!, time: time);
    getDeductionTypes(project: project);
  }

  List<String> workerPhoneNumbers({required List<WorkerAttendance> workers}) {
    List<String> workersPhones = [];
    for (var item in workers) {
      if (item.phone != null && item.phone!.length == 10) {
        var newWorkerPhone = item.phone!.replaceAll("07", "+2507");
        workersPhones.add(newWorkerPhone);
      }
    }
    return workersPhones;
  }

  List<int> workerIds({required List<WorkerAttendance> workers}) {
    List<int> idsWorkers = [];
    for (var item in workers) {
      if (item.assignedWorkerId != null) {
        idsWorkers.add(item.assignedWorkerId!);
      }
    }
    return idsWorkers;
  }

  // send message
  void sendMessage() async {
    issmsLoading.value = true;
    var workersPhoneNumbers = workerPhoneNumbers(workers: selectedWorkerData);
    if (workersPhoneNumbers.isNotEmpty && sms.value.text.isNotEmpty) {
      var payload = {
        "worker_phones": workersPhoneNumbers,
        "message": sms.value.text
      };
      var response = await _apiHandler.postRequestMethod(
          headers: await _dataProvider.headerDetails(),
          body: payload,
          endPoint: Enpoints.sendSmsEnpoint);
      if (response.error) {
        negativeMessage(message: response.errorMessage!);
      } else {
        positiveMessage(message: "Message sent successfully");
        sms.value.clear();
        selectedWorkerData.value = [];
      }
      issmsLoading.value = false;
    } else {
      negativeMessage(
          message: "Workers with incomplete phone numbers ,please check");
      issmsLoading.value = false;
    }
    issmsLoading.value = false;
  }

  // remove worker(s) from attendance
  void removeWorkerFromAttendance(
      {required int projectId, required DateTime time}) async {
    if (mainController.attendances[0].attendanceStatus != "approved") {
      if (mainController.attendances.isNotEmpty) {
        var payload = {
          "attendance_id": mainController.attendances[0].attendanceId,
          "workers_assigned": workerIds(workers: selectedWorkerData),
        };
        var response = await _apiHandler.postRequestMethod(
            headers: await _dataProvider.headerDetails(),
            body: payload,
            endPoint: Enpoints.removeAttendanceEnpoint);
        if (response.error) {
          negativeMessage(message: response.errorMessage!);
        } else {
          positiveMessage(
              message: "You have removed ${selectedWorkerData.length} workers");
          selectedReason.value = {"id": 0, "name": "none"};
          selectedWorkerData.value = [];
          mainController.getAttendances(projectId: projectId, time: time);
        }
      } else {
        negativeMessage(message: "no attendance to update");
      }
    } else {
      warningMessage(
          message: "Attendance approved; Worker(s) can not be removed");
    }
  }

  // remove worker(s) from attendance
  void removeOneWorkerFromAttendance(
      {required int workerId,
      required int projectId,
      required DateTime time}) async {
    if (mainController.attendances[0].attendanceStatus != "approved") {
      if (mainController.attendances.isNotEmpty) {
        var payload = {
          "attendance_id": mainController.attendances[0].attendanceId,
          "workers_assigned": [workerId],
        };
        var response = await _apiHandler.postRequestMethod(
            headers: await _dataProvider.headerDetails(),
            body: payload,
            endPoint: Enpoints.removeAttendanceEnpoint);
        if (response.error) {
          negativeMessage(message: response.errorMessage!);
        } else {
          positiveMessage(message: "success,worker removed");
          selectedReason.value = {"id": 0, "name": "none"};
          mainController.getAttendances(projectId: projectId, time: time);
        }
      } else {
        negativeMessage(message: "no attendance to update");
      }
    } else {
      warningMessage(
          message: "Attendance approved; Worker(s) can not be removed");
    }
  }

  // apply half-shift on worker(s) from attendance
  void applyHalfShiftWorkers(
      {required int projectId, required DateTime time}) async {
    if (mainController.attendances[0].attendanceStatus != "approved") {
      if (mainController.attendances.isNotEmpty) {
        var payload = {
          "attendance_id": mainController.attendances[0].attendanceId,
          "workers_assigned": workerIds(workers: selectedWorkerData),
        };
        var response = await _apiHandler.postRequestMethod(
            headers: await _dataProvider.headerDetails(),
            body: payload,
            endPoint: Enpoints.halfShiftAttendanceEnpoint);
        if (response.error) {
          negativeMessage(message: response.errorMessage!);
        } else {
          positiveMessage(
              message:
                  "You have applied half shift on ${selectedWorkerData.length} workers successfully");
          selectedReason.value = {"id": 0, "name": "none"};
          selectedWorkerData.value = [];
          mainController.getAttendances(projectId: projectId, time: time);
        }
      } else {
        negativeMessage(message: "no attendance to update");
      }
    } else {
      warningMessage(message: "Attendance approved; can not apply half-shift");
    }
  }

  // apply half-shift on worker(s) from attendance
  void applyHalfShiftWorker(
      {required int workerId,
      required int projectId,
      required DateTime time}) async {
    if (mainController.attendances[0].attendanceStatus != "approved") {
      if (mainController.attendances.isNotEmpty) {
        var payload = {
          "attendance_id": mainController.attendances[0].attendanceId,
          "workers_assigned": [workerId],
        };
        var response = await _apiHandler.postRequestMethod(
            headers: await _dataProvider.headerDetails(),
            body: payload,
            endPoint: Enpoints.halfShiftAttendanceEnpoint);
        if (response.error) {
          negativeMessage(message: response.errorMessage!);
        } else {
          positiveMessage(message: "Half shift has been successfully applied");
          selectedReason.value = {"id": 0, "name": "none"};
          mainController.getAttendances(projectId: projectId, time: time);
        }
      } else {
        negativeMessage(message: "no attendance to update");
      }
    } else {
      warningMessage(message: "Attendance approved; can not apply half-shift");
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

  saveBulkDeductions({required Project project}) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(mainController.dateTme.value);
    isAddingBulkDeduction.value = true;
    var payload = {
      "date": formattedDate,
      "deductions": getWorkersAttendedIds(
          deductionAmountP: int.parse(amountBulkDeduction.value.text),
          typeId: typeIdBulkDeduction.value,
          worrkers:
              selectedWorkerData), // deductions: [ {"type_id":0,"amount":0,"assigned_worker_id":0}]
      "project_id": project.projectId
    };
    var responseDeductions = await _apiHandler.postRequestMethod(
        headers: await _dataProvider.headerDetails(),
        body: payload,
        endPoint: Enpoints.deductionManyEnpoint);
    if (responseDeductions.error) {
      negativeMessage(message: "${responseDeductions.errorMessage}");
      isAddingDeduction.value = false;
    } else {
      deductionsControllers.value = [];
      positiveMessage(message: "successfully, dedution applied");
      isAddingDeduction.value = false;
    }
    // } else {
    //   negativeMessage(message: "${response.errorMessage}");
    //   isAddingBulkDeduction.value = false;
    // }

    isAddingBulkDeduction.value = false;
  }

  // remove worker deduction by id
  removeWorkerDeduction(
      {required int projectId,
      required int deductionId,
      required int assignedWorkerId,
      required DateTime time}) async {
    isAddingDeduction.value = true;
    var responseRemoveDeduction = await _apiHandler.deleteRequestMethod(
        headers: await _dataProvider.headerDetails(),
        endPoint: "${Enpoints.deductionUrl}/$deductionId");
    // print("response === > ${Response }")
    if (responseRemoveDeduction.error) {
      negativeMessage(message: "${responseRemoveDeduction.errorMessage}");
      await getWorkerDeductions(
          projectId: projectId, assignedWorkerId: assignedWorkerId, time: time);
      isAddingDeduction.value = false;
    } else {
      deductionsControllers.value = [];
      positiveMessage(message: "successfully, dedution removed");
      isAddingDeduction.value = false;
    }
  }

  saveDeductions(
      {required Project project,
      required int workerAssignedId,
      required DateTime deductionDate}) async {
    isAddingDeduction.value = true;
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(deductionDate);
    var payload = {
      "project_id": project.projectId,
      "date": formattedDate,
      "assigned_worker_id": workerAssignedId,
      "deductions": getDeductionBody(),
    };
    var responseDeduction = await _apiHandler.postRequestMethod(
        headers: await _dataProvider.headerDetails(),
        body: payload,
        endPoint: Enpoints.deductionInternalAttendance);

    if (responseDeduction.error) {
      negativeMessage(message: "${responseDeduction.errorMessage}");
      isAddingDeduction.value = false;
    } else {
      deductionsControllers.value = [];
      positiveMessage(message: "successfully, dedution applied");
      isAddingDeduction.value = false;
    }
    isAddingDeduction.value = false;
  }

  // get worker deductions
  getWorkerDeductions(
      {required int projectId,
      required DateTime time,
      required int assignedWorkerId}) async {
    isgettingDeduction.value = true;
    deductionsControllers.value = [];

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(time);

    var dedutionEndPoint =
        "${Enpoints.getAttendanceDeduction}/$assignedWorkerId/$formattedDate";
    var deductionsResponse =
        await _dataProvider.getWorkerDeductions(endPoint: dedutionEndPoint);
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

  @override
  void onInit() {
    projects.value = mainController.projects;
    super.onInit();
  }
}
