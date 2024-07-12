import 'dart:io';

import 'package:fixa/fixa_main_routes.dart';
import 'package:intl/intl.dart';

class HomeRecordAttendanceController extends GetxController {
  final NetworkController _networkController = Get.find();
  final MainController mainController = Get.find();
  // final HomePageController _homePageController = Get.find();
  final _dataProvider = DataProvider();
  final _apiHandler = ApiHandler();
  RxList<AssignedWorkers> assignedWorkers = <AssignedWorkers>[].obs;
  List<AssignedWorkers> allAssignedWorkers = [];
  RxList<AssignedWorkers> selectedAssignedWorkers = <AssignedWorkers>[].obs;
  List<AttendanceRecordedWorkers> allAttendanceWorkerSaved = [];
  RxList<AssignedWorkers> selectedAssignedWorkersAttedance =
      <AssignedWorkers>[].obs;
  RxList<AssignedWorkers> workersArrangedPreviousAttendance =
      <AssignedWorkers>[].obs;
  RxList<AttendanceRecordedWorkers> attendedWorkersSaved =
      <AttendanceRecordedWorkers>[].obs;
  List<AssignedWorkers> newRegisteredWorkers = [];
  RxBool isLoading = false.obs;
  RxBool isSubmit = false.obs;
  RxBool isWorkerSearching = false.obs;
  Rx<DateTime> dateTme = DateTime.now().obs;
  RxString shiftName = 'day'.obs;
  // List<String> userAllowedToUpdateAttendance = [
  //   "willy@fixarwanda.com",
  //   "tafara@fixarwanda.com",
  //   "stacy@fixarwanda.com",
  //   "linda@fixarwanda.com"
  // ];

  removeAllWorkersSelected(
      {required int projectId, required int serviceId}) async {
    await DatabaseService.instance
        .deleteByServiceId(tableName: 'newworkers', serviceId: serviceId);
    await DatabaseService.instance
        .deleteAttendanceWorkers(projectId: projectId, serviceId: serviceId);
    selectedAssignedWorkers.value = [];
  }

  rearrangeWorkers({required AssignedWorkers toAdd}) {
    for (var i = 0; i < assignedWorkers.length; i++) {
      if (assignedWorkers[i] == toAdd) {
        assignedWorkers.removeAt(i);
        assignedWorkers.insert(0, toAdd);
      }
    }
  }

  rearrangeAllWorkers({required AssignedWorkers toAdd}) {
    for (var i = 0; i < allAssignedWorkers.length; i++) {
      if (allAssignedWorkers[i] == toAdd) {
        allAssignedWorkers.removeAt(i);
        allAssignedWorkers.insert(0, toAdd);
      }
    }
  }

  reverseArrangedWorkers({required AssignedWorkers toAdd}) {
    for (var i = 0; i < assignedWorkers.length; i++) {
      if (assignedWorkers[i] == toAdd) {
        assignedWorkers.removeAt(i);
        assignedWorkers.insert((assignedWorkers.length - 1), toAdd);
      }
    }
  }

  reversedArrangedAllWorkers({required AssignedWorkers toAdd}) {
    for (var i = 0; i < allAssignedWorkers.length; i++) {
      if (allAssignedWorkers[i] == toAdd) {
        allAssignedWorkers.removeAt(i);
        allAssignedWorkers.insert((allAssignedWorkers.length - 1), toAdd);
      }
    }
  }

  addWorker(
      {required AssignedWorkers toAdd,
      required int serviceId,
      required int projectId}) async {
    if (selectedAssignedWorkers.contains(toAdd)) {
      selectedAssignedWorkers.remove(toAdd);
      // remove from saved workers for new registered workers
      if (toAdd.assignedWorkerId == null ||
          toAdd.assignedWorkerId == 0 ||
          toAdd.projectId == null ||
          toAdd.projectId == 0) {
        var newWorkerAttendance = allAttendanceWorkerSaved
            .where((item) =>
                item.nidNumber == toAdd.nidNumber &&
                item.phoneNumber == toAdd.phoneNumber)
            .toList();
        if (newWorkerAttendance.isNotEmpty) {
          reverseArrangedWorkers(toAdd: toAdd);
          reversedArrangedAllWorkers(toAdd: toAdd);
          await DatabaseService.instance
              .removeAttendedWorkerSaved(id: newWorkerAttendance[0].id!);
        }
      } else {
        var newWorkerAttendance = allAttendanceWorkerSaved
            .where((item) => item.assignedWorkerId == toAdd.assignedWorkerId)
            .toList();
        if (newWorkerAttendance.isNotEmpty) {
          reverseArrangedWorkers(toAdd: toAdd);
          reversedArrangedAllWorkers(toAdd: toAdd);
          await DatabaseService.instance
              .removeAttendedWorkerSaved(id: newWorkerAttendance[0].id!);
        }
      }
    } else {
      var worker = AttendanceRecordedWorkers(
          assignedWorkerId: toAdd.assignedWorkerId ?? 0,
          workerId: toAdd.workerId ?? 0,
          firstName: toAdd.firstName,
          lastName: toAdd.lastName,
          phoneNumber: toAdd.phoneNumber,
          district: toAdd.district,
          nidNumber: toAdd.nidNumber,
          rates: toAdd.rates,
          serviceId: serviceId,
          projectId: toAdd.projectId ?? 0);
      rearrangeWorkers(toAdd: toAdd);
      rearrangeAllWorkers(toAdd: toAdd);
      selectedAssignedWorkers.add(toAdd);
      await DatabaseService.instance.addAttendanceWorkers(worker: worker);
      // update saved workers for attendance
      allAttendanceWorkerSaved = await DatabaseService.instance
          .getAllAttendanceWorkerSaved(
              projectId: projectId, serviceId: serviceId);
    }
  }

  // addWorker({required AssignedWorkers toAdd, required int serviceId}) async {
  //   print(
  //       "::=>start here is the legnth small ${assignedWorkers.length} :: All ${allAssignedWorkers.length} ");
  //   if (toAdd.projectId != 0 && toAdd.assignedWorkerId != 0) {
  //     if (selectedAssignedWorkers.contains(toAdd)) {
  //       var index = assignedWorkers.length;
  //       var indexAll = allAssignedWorkers.length;
  //       var workerSavedToRemove = attendedWorkersSaved
  //           .where((element) =>
  //               element.projectId == toAdd.projectId! &&
  //               element.assignedWorkerId == toAdd.assignedWorkerId!)
  //           .toList();
  //       if (workerSavedToRemove.isNotEmpty) {
  //         // remove worker
  //         await DatabaseService.instance
  //             .removeAttendedWorkerSaved(id: workerSavedToRemove[0].id!);
  //         selectedAssignedWorkers.remove(toAdd);
  //         assignedWorkers.remove(toAdd);
  //         allAssignedWorkers.remove(toAdd);
  //         assignedWorkers.insert(index - 1, toAdd);
  //         allAssignedWorkers.insert(indexAll - 1, toAdd);
  //       } else {
  //         selectedAssignedWorkers.remove(toAdd);
  //         assignedWorkers.remove(toAdd);
  //         allAssignedWorkers.remove(toAdd);
  //         assignedWorkers.insert(index - 1, toAdd);
  //         allAssignedWorkers.insert(indexAll - 1, toAdd);
  //       }
  //     } else {
  //       // record worker
  //       await DatabaseService.instance.addAttendanceWorkers(
  //           worker: AttendanceRecordedWorkers(
  //               assignedWorkerId: toAdd.assignedWorkerId,
  //               workerId: toAdd.workerId,
  //               firstName: toAdd.firstName,
  //               lastName: toAdd.lastName,
  //               phoneNumber: toAdd.phoneNumber,
  //               district: toAdd.district,
  //               nidNumber: toAdd.nidNumber,
  //               rates: toAdd.rates,
  //               serviceId: serviceId,
  //               projectId: toAdd.projectId));

  //       selectedAssignedWorkers.add(toAdd);
  //       assignedWorkers.remove(toAdd);
  //       allAssignedWorkers.remove(toAdd);
  //       assignedWorkers.insert(0, toAdd);
  //       allAssignedWorkers.insert(0, toAdd);
  //     }
  //   }
  //   print(
  //       "End ::=> here is the legnth small ${assignedWorkers.length} :: All ${allAssignedWorkers.length} ");
  // }

  selectWorkersRegistered() async {
    // select new workers
    for (var item in assignedWorkers) {
      if (item.projectId == 0 && !selectedAssignedWorkers.contains(item)) {
        selectedAssignedWorkers.add(item);
      }
    }
  }

  List<AssignedWorkers> arrangeRegisteredWorkers(
      {required List<Map<String, dynamic>> workers}) {
    List<AssignedWorkers> newData = [];

    for (var item in workers) {
      var newWorkerRecorded = AssignedWorkers(
          id: item["id"],
          firstName: item["firstname"],
          lastName: item["lastname"],
          phoneNumber: item["phone"],
          district: item["district"],
          gender: item["gender"],
          nidNumber: item["nida"],
          rates: '[${item["daily_rate"]}]',
          services: '[${item["service_id"]}]',
          projectId: 0,
          countryId: item["country_id"],
          phoneNumbers: item["phone_numbers"],
          phoneNumbersMasked: item["phone_numbers_masked"],
          dateOfBirth: item["date_of_birth"]);
      selectedAssignedWorkers.add(newWorkerRecorded);
      newData.add(newWorkerRecorded);
    }

    return newData;
  }

  bool checkREcordedAttendancePreselection(
      {required AssignedWorkers item,
      required List<AttendanceRecordedWorkers> workersAttendances}) {
    bool isPresent = false;
    for (var attendedWorker in workersAttendances) {
      if (attendedWorker.assignedWorkerId == item.assignedWorkerId) {
        isPresent = true;
      }
    }
    return isPresent;
  }

  List<AssignedWorkers> arrangeAttendedRegisteredWorkers(
      {required List<AssignedWorkers> responseWorkes,
      required List<AttendanceRecordedWorkers> workers}) {
    List<AssignedWorkers> workersFromAttendance = [];
    List<AssignedWorkers> workersFromAttendanceFirst = [];
    List<AssignedWorkers> workersFromAttendanceLast = [];
    for (var item in responseWorkes) {
      attendedWorkersSaved.value = workers;
      if (checkREcordedAttendancePreselection(
          item: item, workersAttendances: workers)) {
        selectedAssignedWorkers.add(item);
        workersFromAttendanceFirst.add(item);
      } else {
        workersFromAttendanceLast.add(item);
      }
    }
    workersFromAttendance = [
      ...workersFromAttendanceFirst,
      ...workersFromAttendanceLast
    ];

    return workersFromAttendance;
  }

  bool checkIfContains(
      {required AssignedWorkers item,
      required List<WorkerAttendance> workersAttendances}) {
    bool isStatus = false;
    for (var workerAttended in workersAttendances) {
      if (workerAttended.assignedWorkerId == item.assignedWorkerId) {
        isStatus = true;
      }
    }
    return isStatus;
  }

  List<AssignedWorkers> arrangeWorkes(
      {required List<WorkerAttendance> workersAttendances,
      required List<AssignedWorkers> responseWorkes}) {
    List<AssignedWorkers> workersArranged = [];
    List<AssignedWorkers> workersArrangedAttendance = [];
    List<AssignedWorkers> workersArrangedNoPreviousAttendance = [];

    if (workersAttendances.isNotEmpty) {
      for (var item in responseWorkes) {
        if (checkIfContains(
            item: item, workersAttendances: workersAttendances)) {
          workersArrangedAttendance.add(item);
        } else {
          workersArrangedNoPreviousAttendance.add(item);
        }
      }
      workersArranged = [
        ...workersArrangedAttendance,
        ...workersArrangedNoPreviousAttendance
      ];
      return workersArranged;
    } else {
      return responseWorkes;
    }
  }

  // pre select worker
  bool checkPreselection(
      {required AssignedWorkers item,
      required List<WorkerAttendance> workersAttendances}) {
    bool isPresent = false;
    for (var attendedWorker in workersAttendances) {
      if (attendedWorker.assignedWorkerId == item.assignedWorkerId) {
        isPresent = true;
      }
    }
    return isPresent;
  }

  preSelectWorkers(
      {required List<WorkerAttendance> workersAttendances,
      required List<AssignedWorkers> responseWorkes}) {
    for (var item in responseWorkes) {
      if (checkPreselection(
          item: item, workersAttendances: workersAttendances)) {
        workersArrangedPreviousAttendance.add(item);
        selectedAssignedWorkersAttedance.add(item);
      }
    }
  }

  bool checkIfWorkerHasAttended(
      {required AttendanceRecordedWorkers itemWorker,
      required List<WorkerAttendance> workersRecorded}) {
    bool status = false;
    for (var item in workersRecorded) {
      if (itemWorker.assignedWorkerId != null &&
          item.assignedWorkerId != null &&
          item.assignedWorkerId != 0 &&
          item.assignedWorkerId == itemWorker.assignedWorkerId) {
        status = true;
      }
    }
    return status;
  }

  List<AttendanceRecordedWorkers> workersRecordedForAttendanceList(
      {required List<WorkerAttendance> workersAttendances,
      required List<AttendanceRecordedWorkers> workersRecorded}) {
    List<AttendanceRecordedWorkers> recordedWorkesAttended = [];

    for (var item in workersRecorded) {
      if (!checkIfWorkerHasAttended(
          itemWorker: item, workersRecorded: workersAttendances)) {
        recordedWorkesAttended.add(item);
      }
    }

    return recordedWorkesAttended;
  }

  bool checkWorkerForNightSHift(
      {required AssignedWorkers item,
      required List<WorkerAttendance> workersAttendanceToCheck}) {
    bool status = false;
    for (var itemWorker in workersAttendanceToCheck) {
      if (item.assignedWorkerId == itemWorker.assignedWorkerId) {
        status = true;
      }
    }
    return status;
  }

  List<AssignedWorkers> removeWorkersIfExistedOnShift(
      {required List<AssignedWorkers> workersAssignedToCheck}) {
    List<AssignedWorkers> responseWorkers = [];
    for (var item in workersAssignedToCheck) {
      if (!checkWorkerForNightSHift(
          item: item,
          workersAttendanceToCheck: mainController.allAttendances)) {
        responseWorkers.add(item);
      }
    }
    return responseWorkers;
  }

  getAssignedWorkers(
      {required int projectId,
      required int serviceId,
      required List<WorkerAttendance> workersAttendances,
      required Project project}) async {
    // List<Services> servicesProject = [];
    // servicesProject = project.services ?? [];
    // List<int> servicesProjectIds =
    //     servicesProject.map((item) => item.id ?? 0).toList();
    //  print('data ${servicesProjectIds.toString()} ${servicesProjectIds.length}');

    selectedAssignedWorkers.value = [];
    allAssignedWorkers = [];
    assignedWorkers.value = [];
    allAttendanceWorkerSaved = [];

    dateTme.value = mainController.dateTme.value;
    shiftName.value = mainController.shift.value ? 'Night' : 'Day';

    isLoading.value = true;
    // get workers from attendance and assign them at the top list
    var responseWorkers = await DatabaseService.instance
        .getAllAssingedWorkerSaved(projectId: projectId);

    var response = arrangeWorkes(
        workersAttendances: workersAttendances,
        responseWorkes: responseWorkers);
    preSelectWorkers(
        workersAttendances: workersAttendances,
        responseWorkes: responseWorkers);

    if (serviceId != 0) {
      var workersAssignedList = response.where((item) {
        var newServicesText =
            item.services!.replaceAll('[', '').replaceAll(']', '');

        List<String> services = newServicesText.split(',');
        return services.contains(serviceId.toString());
      }).toList();

      assignedWorkers.value = workersAssignedList;
      allAssignedWorkers = workersAssignedList;

      // check for new registered workers
      var newWorkersResponse = await DatabaseService.instance
          .getAllRegisteredWorkerSavedByServiceId(serviceId: serviceId);
      // get recorded workers for attendances
      var responseWorkesAttended = await DatabaseService.instance
          .getAllAttendanceWorkerSaved(
              projectId: projectId, serviceId: serviceId);
      var recordedWorkesAttended = workersRecordedForAttendanceList(
          workersAttendances: workersAttendances,
          workersRecorded: responseWorkesAttended);
      allAttendanceWorkerSaved = recordedWorkesAttended;

      if (newWorkersResponse.isNotEmpty || recordedWorkesAttended.isNotEmpty) {
        newRegisteredWorkers =
            arrangeRegisteredWorkers(workers: newWorkersResponse);
        assignedWorkers.value = [...newRegisteredWorkers, ...assignedWorkers];
        allAssignedWorkers = [...newRegisteredWorkers, ...allAssignedWorkers];
        var newAssignedWorkersList = arrangeAttendedRegisteredWorkers(
            workers: recordedWorkesAttended,
            responseWorkes: allAssignedWorkers);
        allAssignedWorkers = newAssignedWorkersList;
        assignedWorkers.value = newAssignedWorkersList;
      }
    } else {
      var workersAssignedList = response;

      assignedWorkers.value = workersAssignedList;
      allAssignedWorkers = workersAssignedList;

      // check for new registered workers
      var newWorkersResponse =
          await DatabaseService.instance.getAllRegisteredWorkerSaved();
      // get recorded workers for attendances
      var responseWorkesAttended = await DatabaseService.instance
          .getAllAttendanceWorkerSaved(
              projectId: projectId, serviceId: serviceId);
      var recordedWorkesAttended = workersRecordedForAttendanceList(
          workersAttendances: workersAttendances,
          workersRecorded: responseWorkesAttended);
      allAttendanceWorkerSaved = recordedWorkesAttended;

      if (newWorkersResponse.isNotEmpty || recordedWorkesAttended.isNotEmpty) {
        newRegisteredWorkers =
            arrangeRegisteredWorkers(workers: newWorkersResponse);
        assignedWorkers.value = [...newRegisteredWorkers, ...assignedWorkers];
        allAssignedWorkers = [...newRegisteredWorkers, ...allAssignedWorkers];
        var newAssignedWorkersList = arrangeAttendedRegisteredWorkers(
            workers: recordedWorkesAttended,
            responseWorkes: allAssignedWorkers);
        allAssignedWorkers = newAssignedWorkersList;
        assignedWorkers.value = newAssignedWorkersList;
      }
    }
    isLoading.value = false;
  }

  bool searchByConcatenation(
      {required firstNamee, required lastNamee, required dataName}) {
    var newDataName = dataName.replaceAll(' ', '');

    var firstnameLastNamee =
        "${firstNamee.toLowerCase()}${lastNamee.toLowerCase()}";
    var statusNameConcatenation = false;
    if (firstnameLastNamee.contains(newDataName.toLowerCase())) {
      statusNameConcatenation = true;
    }

    return statusNameConcatenation;
  }

  void searchWorkers({required String data, required bool isEmpty}) {
    List<AssignedWorkers> newWorkers = [];
    isWorkerSearching.value = true;
    if (isEmpty) {
      newWorkers = allAssignedWorkers;

      isWorkerSearching.value = false;
    } else {
      if (data.split(' ').length == 1) {
        for (var item in allAssignedWorkers) {
          searchByConcatenation(
              dataName: data.toLowerCase(),
              firstNamee: item.firstName!.toLowerCase(),
              lastNamee: item.lastName!.toLowerCase());
          if (item.firstName!.toLowerCase().contains(data) ||
              item.lastName!.toLowerCase().contains(data) ||
              item.phoneNumber!.contains(data) ||
              item.nidNumber!.contains(data) ||
              searchByConcatenation(
                      dataName: data.toLowerCase(),
                      firstNamee: item.firstName!.toLowerCase(),
                      lastNamee: item.lastName!.toLowerCase()) ==
                  true) {
            newWorkers.add(item);
          }
        }
      } else if (data.split(' ').length > 1) {
        for (var item in allAssignedWorkers) {
          if (searchByConcatenation(
              dataName: data.toLowerCase(),
              firstNamee: item.firstName!.toLowerCase(),
              lastNamee: item.lastName!.toLowerCase())) {
            newWorkers.add(item);
          }
        }
      }
    }

    assignedWorkers.value = newWorkers;
    isWorkerSearching.value = false;
  }

  List<String> stringToArray(String str) {
    String delimiter = '|';
    return str.split(delimiter);
  }

  List<dynamic> getNewWorkersIdAssigned(
      {required Project project,
      required List<AssignedWorkers> dataAssignedWorkers}) {
    List<dynamic> idsNewWorkers = [];

    for (var item in dataAssignedWorkers) {
      if (item.projectId == 0) {
        var serviceNWId =
            item.services!.replaceAll('[', '').replaceAll(']', '');
        List<String> phoneMasked =
            item.phoneNumbersMasked == null || item.phoneNumbersMasked! == '[]'
                ? []
                : stringToArray(item.phoneNumbersMasked!);

        //  print("item ==> rates :: ${item.phoneNumbersMasked!} ${json.encode(phoneMasked)}");
        if (AppConfig.instance.appValues!.appTitle!.toLowerCase() == 'fixa') {
          if (item.rates == null || item.rates == "[null]") {
            idsNewWorkers.add({
              "first_name": item.firstName,
              "last_name": item.lastName,
              "district": item.district,
              "gender": item.gender,
              "nid_number": item.nidNumber,
              "phone_number": item.phoneNumber,
              "services": int.parse(serviceNWId),
              "country": int.parse(item.countryId ?? "0"),
              "phone_numbers":
                  item.phoneNumber == null || item.phoneNumber!.isEmpty
                      ? []
                      : [item.phoneNumber],
              "phone_numbers_masked": phoneMasked.isEmpty ? [] : phoneMasked,
              "date_of_birth": item.dateOfBirth,
              "daily_rate": ""
            });
          } else {
            var rateNWId = item.rates!.replaceAll('[', '').replaceAll(']', '');

            idsNewWorkers.add({
              "first_name": item.firstName,
              "last_name": item.lastName,
              "district": item.district,
              "gender": item.gender,
              "nid_number": item.nidNumber,
              "phone_number": item.phoneNumber,
              "services": int.parse(serviceNWId),
              "daily_rate": int.parse(rateNWId) > 0 ? rateNWId : "1",
              "country": int.parse(item.countryId ?? "0"),
              "phone_numbers":
                  item.phoneNumber == null || item.phoneNumber!.isEmpty
                      ? []
                      : [item.phoneNumber],
              "phone_numbers_masked": phoneMasked.isEmpty ? [] : phoneMasked,
              "date_of_birth": item.dateOfBirth
            });
          }
        } else {
          if (item.rates == null || item.rates == "[null]") {
            idsNewWorkers.add({
              "first_name": item.firstName,
              "last_name": item.lastName,
              "district": item.district,
              "gender": item.gender,
              "nid_number": item.nidNumber,
              "phone_number": item.phoneNumber,
              "services": int.parse(serviceNWId),
              "date_of_birth": item.dateOfBirth,
              "daily_rate": ""
            });
          } else {
            var rateNWId = item.rates!.replaceAll('[', '').replaceAll(']', '');
            idsNewWorkers.add({
              "first_name": item.firstName,
              "last_name": item.lastName,
              "district": item.district,
              "gender": item.gender,
              "nid_number": item.nidNumber,
              "phone_number": item.phoneNumber,
              "services": int.parse(serviceNWId),
              "date_of_birth": item.dateOfBirth,
              "daily_rate": int.parse(rateNWId) > 0 ? int.parse(rateNWId) : 1,
            });
          }
        }
      }
    }
    return idsNewWorkers;
  }

  List<int> getAssignedWorkersIdAssigned(
      {required Project project,
      required List<AssignedWorkers> dataAssignedWorkers}) {
    List<int> idsAssignedWorkers = [];

    for (var item in dataAssignedWorkers) {
      if (item.projectId == project.projectId) {
        idsAssignedWorkers.add(item.assignedWorkerId!);
      }
    }
    return idsAssignedWorkers;
  }

  submit({
    required Project project,
    required DateTime time,
    required int shiftId,
    required int selectedServiceId,
  }) async {
    isSubmit.value = true;
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(time);
    var user = await _dataProvider.getUserDetails();
    var today = DateTime.now();
    var newTime = DateTime(time.day, time.month, time.year);
    var todayTime = DateTime(today.day, today.month, today.year);
    var headers = await _dataProvider.headerDetails();

    if (newTime.isAtSameMomentAs(todayTime)) {
      var attendance = {
        "project_id": project.projectId,
        "date": formattedDate,
        "supervisor_id": user.user!.id,
        "shift_id": shiftId,
        "workers_assigned": getAssignedWorkersIdAssigned(
            dataAssignedWorkers: selectedAssignedWorkers, project: project),
        "new_workers": getNewWorkersIdAssigned(
            dataAssignedWorkers: selectedAssignedWorkers, project: project)
      };
      // print("attendance body :: ${json.encode(attendance)}");
      var response = await _apiHandler.postRequestMethod(
          headers: headers,
          body: attendance,
          endPoint: Enpoints.recordAttendanceEnpoint);
      if (response.error || response.response!.statusCode != 200) {
        negativeMessage(message: response.errorMessage!);
        isSubmit.value = false;
      } else {
        positiveMessage(
            message:
                "You have added ${selectedAssignedWorkers.length} worker(s) successfully");
        selectedAssignedWorkers.value = [];
        await DatabaseService.instance.deleteAttendanceWorkers(
            projectId: project.projectId!, serviceId: selectedServiceId);
        await DatabaseService.instance.deleteByServiceId(
            tableName: 'newworkers', serviceId: selectedServiceId);
        await mainController.getAttendances(
            time: mainController.dateTme.value, projectId: project.projectId!);
        mainController.getWorkersFromProject(projectId: project.projectId!);
        mainController.updateWorkerAssigned();
        // _homePageController.updateWorkersAfterAttendance(
        //     projectId: project.projectId!);
        isSubmit.value = false;
      }
    } else {
      if (mainController.allAttendances.isEmpty) {
        var attendance = {
          "project_id": project.projectId,
          "date": formattedDate,
          "supervisor_id": user.user!.id,
          "shift_id": shiftId,
          "workers_assigned": getAssignedWorkersIdAssigned(
              dataAssignedWorkers: selectedAssignedWorkers, project: project),
          "new_workers": getNewWorkersIdAssigned(
              dataAssignedWorkers: selectedAssignedWorkers, project: project)
        };
        // print("attendance body :: ${json.encode(attendance)}");
        var response = await _apiHandler.postRequestMethod(
            headers: headers,
            body: attendance,
            endPoint: Enpoints.recordAttendanceEnpoint);
        if (response.error || response.response!.statusCode != 200) {
          negativeMessage(message: response.errorMessage!);
          isSubmit.value = false;
        } else {
          positiveMessage(
              message:
                  "you have added ${selectedAssignedWorkers.length} workers successfully");
          selectedAssignedWorkers.value = [];
          await DatabaseService.instance.deleteAttendanceWorkers(
              projectId: project.projectId!, serviceId: selectedServiceId);
          await DatabaseService.instance.deleteByServiceId(
              tableName: 'newworkers', serviceId: selectedServiceId);
          await mainController.getAttendances(
              time: mainController.dateTme.value,
              projectId: project.projectId!);
          mainController.getWorkersFromProject(projectId: project.projectId!);
          // _homePageController.updateWorkersAfterAttendance(
          //     projectId: project.projectId!);
          isSubmit.value = false;
        }
      } else if (mainController.allAttendances.isNotEmpty) {
        var attendance = {
          "project_id": project.projectId,
          "date": formattedDate,
          "supervisor_id": user.user!.id,
          "shift_id": shiftId,
          "workers_assigned": getAssignedWorkersIdAssigned(
              dataAssignedWorkers: selectedAssignedWorkers, project: project),
          "new_workers": getNewWorkersIdAssigned(
              dataAssignedWorkers: selectedAssignedWorkers, project: project)
        };
        // print("attendance body :: ${json.encode(attendance)}");
        var response = await _apiHandler.postRequestMethod(
            headers: headers,
            body: attendance,
            endPoint: Enpoints.recordAttendanceEnpoint);
        if (response.error || response.response!.statusCode != 200) {
          negativeMessage(message: response.errorMessage!);
          isSubmit.value = false;
        } else {
          positiveMessage(
              message:
                  "you have added ${selectedAssignedWorkers.length} workers successfully");
          selectedAssignedWorkers.value = [];
          await DatabaseService.instance.deleteAttendanceWorkers(
              projectId: project.projectId!, serviceId: selectedServiceId);
          await DatabaseService.instance.deleteByServiceId(
              tableName: 'newworkers', serviceId: selectedServiceId);
          await mainController.getAttendances(
              time: mainController.dateTme.value,
              projectId: project.projectId!);
          mainController.getWorkersFromProject(projectId: project.projectId!);
          // _homePageController.updateWorkersAfterAttendance(
          //     projectId: project.projectId!);
          isSubmit.value = false;
        }
      } else {
        warningMessage(message: "Not Allowed to update Past Attendances");
        selectedAssignedWorkers.value = [];
        await DatabaseService.instance.deleteAttendanceWorkers(
            projectId: project.projectId!, serviceId: selectedServiceId);
        await DatabaseService.instance.deleteByServiceId(
            tableName: 'newworkers', serviceId: selectedServiceId);
      }
    }

    isSubmit.value = false;
  }

  // post or put attendance
  makeAttendance({
    required Project project,
    required DateTime time,
    required int shiftId,
    required int selectedServiceId,
  }) async {
    try {
      final result = await InternetAddress.lookup('api.fixarwanda.com');
      if ((_networkController.state is NetworkNotConnected) &&
          (result.isEmpty && result[0].rawAddress.isEmpty)) {
        negativeMessage(message: 'Check your internet connectivity');
      } else if ((_networkController.state is NetworkMobileConnected ||
              _networkController.state is NetworkWifiConnected) &&
          (result.isNotEmpty && result[0].rawAddress.isNotEmpty)) {
        await submit(
            project: project,
            time: time,
            shiftId: shiftId,
            selectedServiceId: selectedServiceId);
      } else {
        negativeMessage(message: 'Check your internet connectivity');
      }
    } on SocketException catch (_) {
      negativeMessage(message: 'No internet');
    }
  }
}
