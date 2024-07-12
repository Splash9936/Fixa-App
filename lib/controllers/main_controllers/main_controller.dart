// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:fixa/fixa_main_routes.dart';
import 'package:intl/intl.dart';

class MainController extends GetxController {
  final _dataProvider = DataProvider();
  RxInt selectedProjectId = 0.obs;

  // dashboard_data
  // final _pusherService = PusherService.instance;
  final AuthenticationController _auth = Get.find();
  RxBool isDashboardLoading = false.obs;
  RxBool isAttendanceLoading = false.obs;
  RxBool isWorkForceLoading = false.obs;
  RxList<Project> projects = <Project>[].obs;
  RxList<AttendanceStatus> attendanceStatuses = <AttendanceStatus>[].obs;
  RxList<AttendanceStatus> alltAtendanceStatuses = <AttendanceStatus>[].obs;
  RxList<AssignedWorkers> assignedWorkers = <AssignedWorkers>[].obs;
  RxList<AssignedWorkers> allAssignedWorkers = <AssignedWorkers>[].obs;
  List<AssignedWorkers> allSavedWorkers = [];
  Rx<UserDetails> userInfo = UserDetails().obs;
  RxBool isProject = false.obs;
  RxBool isNotification = false.obs;
  Rx<Project> selectedProject = Project().obs;
  Rx<PageController> pageController = PageController().obs;
  // ------------------ variables -------------

  int selectedIndex = 0;
  // home controllers variables
  int selectedHomeProjectIndex = 0;
  bool selectedHomeProjectStatus = false;
  // widgets
  List<Widget> widgets = [
    HomePage(),
    HomeMainAttendance(),
    HomeWorkForce(),
    HomePayrollSelectProject()
  ];

  // attendance_data
  RxBool shift = false.obs;
  Rx<DateTime> dateTme = DateTime.now().obs;
  RxList<WorkerAttendance> attendances = <WorkerAttendance>[].obs;
  RxList<WorkerAttendance> allAttendances = <WorkerAttendance>[].obs;
  RxList<WorkerAttendance> allServicesAttendances = <WorkerAttendance>[].obs;
  List<int> workersAttendandedIds = [];
  RxInt selectedService = 0.obs;

  // work_force data
  RxBool isGettingWorker = false.obs;

  // ***************** main_dashboard_method (start) **************
  void changeNotificationStatus() {
    isNotification.value = !isNotification.value;
  }

  void changeIndex({required int index}) {
    if (!isDashboardLoading.value) {
      // pageController.value.jumpToPage(index);
      if (index == 0) {
        // getAttendanceStatuses(time: DateTime.now());
        selectedIndex = index;
      } else {
        selectedIndex = index;
      }

      update();
    } else {
      warningMessage(message: "Loading in process");
    }
  }

  // change index to attendance
  void indexToAttendance({required Project projectChoosen}) {
    // pageController.value.jumpToPage(1);
    selectedIndex = 1;
    selectedProject.value = projectChoosen;
    isProject.value = true;
    update();
  }

  // get user info
  getUserInfo() async {
    var userDetails = await _dataProvider.getUserDetails();
    userInfo.value = userDetails.user!;
  }

  // update project
  updateProject() async {
    var response = await _dataProvider.getWorkerProjects(
        endPoint: Enpoints.projectEnpoint);
    if (!response.error) {
      projects.value = response.response!;
      await _dataProvider.deleteOders();
      await _dataProvider.saveProjects(projects: response.response!);
    } else {
      negativeMessage(message: response.errorMessage!);
    }
  }

  // get projects
  getProjects() async {
    var response = await _dataProvider.getWorkerProjects(
        endPoint: Enpoints.projectEnpoint);
    if (!response.error) {
      projects.value = response.response!;
      await _dataProvider.saveProjects(projects: response.response!);
      if (response.response != null &&
          response.response!.isNotEmpty &&
          response.response!.length == 1) {
        selectedProjectId.value = response.response![0].projectId!;
      }
    } else {
      negativeMessage(message: response.errorMessage!);
    }
  }

  // get assigned workers
  getAssignedWorkers() async {
    var response = await _dataProvider.getAssignedWorkers(
        endPoint: Enpoints.assignedWorkersEnpoint);
    if (!response.error) {
      assignedWorkers.value = response.response!;
      List<Map<String, dynamic>> data =
          response.response!.map((item) => item.toJson()).toList();
      await DatabaseService.instance.addWorkers(rows: data);
    } else {
      negativeMessage(message: response.errorMessage!);
    }
  }

  updateWorkerAssigned() async {
    var response = await _dataProvider.getAssignedWorkers(
        endPoint: Enpoints.assignedWorkersEnpoint);

    if (!response.error) {
      await DatabaseService.instance.delete(tableName: "assignedWorkers");

      // insert data
      List<Map<String, dynamic>> data =
          response.response!.map((item) => item.toJson()).toList();
      await DatabaseService.instance.addWorkers(rows: data);
      // for (var item in response.response!) {
      //   await DatabaseService.instance.addWorkers(worker: item);
      // }
      await updateWorkerProjects();
    } else {
      negativeMessage(message: response.errorMessage!);
    }
  }

  List<AttendanceStatus> getAttendanceStatusesByProject(
      {required List<AttendanceStatus> statuses}) {
    List<AttendanceStatus> response = [];
    for (var item in projects) {
      var responseStatus = statuses
          .where((element) => item.projectName == element.projectName)
          .toList();
      response = [...responseStatus, ...response];
    }

    return response;
  }

  // getAttendanceStatuses({required DateTime time}) async {
  //   final DateFormat formatter = DateFormat('yyyy-MM-dd');
  //   final String formattedDate = formatter.format(time);
  //   var response = await _dataProvider.getAttendanceStatus(
  //       endPoint: Enpoints.attendanceNotificationEnpoint,
  //       body: {"date": formattedDate});
  //   if (response.error) {
  //     // negativeMessage(message: "failed to get attendance statuses");
  //   } else {
  //     attendanceStatuses.value =
  //         getAttendanceStatusesByProject(statuses: response.response!);
  //     alltAtendanceStatuses.value =
  //         getAttendanceStatusesByProject(statuses: response.response!);
  //   }
  // }

  // signout-user
  signedOut() async {
    selectedIndex = 0;
    await _auth.signOut();
  }

  deleteUser({required int workerId}) async {
    selectedIndex = 0;
    await _auth.deleteUser(userId: workerId);
  }

  // ***************** main_dashboard_method (start) **************

  // ***************** Attendance_method (start) **************

  List<int> getWorkersAttendedIds({required List<WorkerAttendance> worrkers}) {
    List<int> ids = [];
    for (var item in worrkers) {
      ids.add(item.assignedWorkerId!);
    }
    return ids;
  }

  // get attendance by shift
  List<WorkerAttendance> getAttendanceByShift(
      {required List<WorkerAttendance> workersAttendance}) {
    List<WorkerAttendance> responseAttendance = [];
    if (shift.value) {
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

  getAttendances({required DateTime time, required int projectId}) async {
    isAttendanceLoading.value = true;
    selectedService.value = 0;
    workersAttendandedIds = [];
    selectedProjectId.value = projectId;
    dateTme.value = time;
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(time);
    var response = await _dataProvider.getAttendance(
        endPoint:
            "${Enpoints.viewAttendanceEnpoint}?attendance_date=$formattedDate&project_id=$projectId");

    if (!response.error) {
      allAttendances.value = response.response!;
      attendances.value =
          getAttendanceByShift(workersAttendance: response.response!);
      allServicesAttendances.value = response.response!;
      workersAttendandedIds =
          getWorkersAttendedIds(worrkers: response.response!);
      isAttendanceLoading.value = false;
    } else {
      negativeMessage(message: response.errorMessage!);
      isAttendanceLoading.value = false;
    }
  }

  // ***************** Attendance_method (End) **************

  // ***************** Work_Force_method (start) **************
  updateWorkerProjects() async {
    // get workers from database
    var response = await DatabaseService.instance.getAssingedWorkerSaved();
    allSavedWorkers = response;
    allAssignedWorkers.value = allSavedWorkers;
    assignedWorkers.value = allSavedWorkers;
  }

  getProjectWorkers() async {
    // get workers from database
    var response = await DatabaseService.instance.getAssingedWorkerSaved();
    allSavedWorkers = response;
    // get project workers
  }

  getAssignedWorkersSaved({required int projectId}) async {
    isWorkForceLoading.value = true;
    try {
      var responseW = await DatabaseService.instance
          .getAllAssingedWorkerSaved(projectId: projectId);
        
      var response = await DatabaseService.instance.getAssingedWorkerSaved();

      allSavedWorkers = response;
      // get project workers
      allAssignedWorkers.value = responseW;
     
      assignedWorkers.value = responseW;
      // var projectWorkers =
      //     allSavedWorkers.where((item) => item.projectId == projectId).toList();
      isWorkForceLoading.value = false;
    } catch (e) {
      isWorkForceLoading.value = false;
    }
  }

  getWorkersFromProject({required int projectId}) async {
    isGettingWorker.value = true;
    allAssignedWorkers.value = [];
    assignedWorkers.value = [];
    selectedProjectId.value = projectId;

    var response = await DatabaseService.instance
        .getAllAssingedWorkerSaved(projectId: projectId);

    if (response.isNotEmpty) {
      allAssignedWorkers.value = response;
      assignedWorkers.value = response;
      isGettingWorker.value = false;
    }
    isGettingWorker.value = false;
  }
  // ***************** Work_Force_method (End) **************

  // set workers project
  setWorkersProject() async {
    if (selectedProjectId > 0) {
      getWorkersFromProject(projectId: selectedProjectId.value);
      getAttendances(time: DateTime.now(), projectId: selectedProjectId.value);
    }
  }

  // set project
  setProjects({required List<Project> projectsDB}) async {
    projects.value = projectsDB;
    if (projectsDB.length == 1) {
      selectedProjectId.value = projectsDB[0].projectId!;
      getWorkersFromProject(projectId: selectedProjectId.value);
    }
  }

  // set project
  getAttendance({required List<Project> projectsDB}) async {
    if (projectsDB.length == 1) {
      selectedProjectId.value = projectsDB[0].projectId!;
      getAttendances(time: DateTime.now(), projectId: selectedProjectId.value);
    }
  }

  // initialize controllers
  void _initialize() {
    Get.lazyPut(
      () => HomeWorkForceController(),
    );
    Get.lazyPut(
      () => HomePayrollController(),
    );
    Get.lazyPut(
      () => HomeAttendanceController(),
    );
  }

  // check if projects are available
  checkForProjects() async {
    isDashboardLoading.value = true;

    var projectsDB = await _dataProvider.readProject();

    if (projectsDB.isEmpty) {
      await getProjects();
      await getAssignedWorkers();
      // get workers if done getting project
      await setWorkersProject();
      await getProjectWorkers();
      Timer.periodic(Duration(minutes: 10), (timer) => updateWorkerAssigned());
    } else {
      await setProjects(projectsDB: projectsDB);
      await getAttendance(projectsDB: projectsDB);
      await getProjectWorkers();
      updateProject();
      updateWorkerAssigned();
      Timer.periodic(Duration(minutes: 10), (timer) => updateWorkerAssigned());
    }

    isDashboardLoading.value = false;
  }

  @override
  void onInit() {
    getUserInfo();
    // getAttendanceStatuses(time: DateTime.now());
    checkForProjects();
    _initialize();
    super.onInit();
  }
}
