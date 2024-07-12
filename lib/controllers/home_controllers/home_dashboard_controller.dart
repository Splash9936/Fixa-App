// // ignore_for_file: prefer_const_constructors

// import 'package:fixa/fixa_main_routes.dart';
// import 'package:fixa/views/worker/home_worker.dart';
// import 'package:intl/intl.dart';

// class HomePageController extends GetxController {
//   // final _pusherService = PusherService.instance;
//   final AuthenticationController _auth = Get.find();
//   RxBool isLoading = false.obs;
//   RxList<Project> projects = <Project>[].obs;
//   RxList<AttendanceStatus> attendanceStatuses = <AttendanceStatus>[].obs;
//   RxList<AttendanceStatus> alltAtendanceStatuses = <AttendanceStatus>[].obs;
//   RxList<AssignedWorkers> assignedWorkers = <AssignedWorkers>[].obs;
//   final _dataProvider = DataProvider();
//   Rx<UserDetails> userInfo = UserDetails().obs;
//   RxBool isProject = false.obs;
//   RxBool isNotification = false.obs;
//   Rx<Project> selectedProject = Project().obs;
//   // ------------------ variables -------------

//   int selectedIndex = 0;
//   // home controllers variables
//   int selectedHomeProjectIndex = 0;
//   bool selectedHomeProjectStatus = false;
//   // widgets
//   List<Widget> widgets = [
//     HomePage(),
//     HomeMainAttendance(),
//     HomeWorkForce(),
//     HomePayrollSelectProject()
//   ];

//   // ---------------- methods --------------

//   void changeNotificationStatus() {
//     isNotification.value = !isNotification.value;
//   }

//   void changeIndex({required int index}) {
//     // final HomeWorkForceController _workerForceController = Get.find();

//     if (!isLoading.value) {
//       if (index == 0) {
//         getAttendanceStatuses(time: DateTime.now());
//         selectedIndex = index;
//       }
//       // else if (index == 2 && projects.length == 1) {
//       //   _workerForceController.getWorkersFromProject(
//       //       projectId: projects[0].projectId!);
//       //   selectedIndex = index;
//       // }
//       else {
//         selectedIndex = index;
//       }

//       update();
//     } else {
//       warningMessage(message: "Loading in process");
//     }
//   }

//   // change index to attendance
//   void indexToAttendance({required Project projectChoosen}) {
//     selectedIndex = 1;
//     selectedProject.value = projectChoosen;
//     isProject.value = true;
//     update();
//   }

//   // signout-user
//   signedOut() async {
//     selectedIndex = 0;
//     await _auth.signOut();
//   }

//   // initialize controllers
//   void _initialize() {
//     Get.lazyPut(
//       () => HomeWorkForceController(),
//     );
//     Get.lazyPut(
//       () => HomePayrollController(),
//     );
//     Get.lazyPut(
//       () => HomeAttendanceController(),
//     );
//   }

//   // get user info
//   getUserInfo() async {
//     var userDetails = await _dataProvider.getUserDetails();
//     userInfo.value = userDetails.user!;
//   }

//   // check if projects are available
//   void checkForProjects() async {
//     isLoading.value = true;

//     var projectsDB = await _dataProvider.readProject();

//     if (projectsDB.isEmpty) {
//       await getProjects();
//       await getAssignedWorkers();
//       // await setProject();
//     } else {
//       projects.value = projectsDB;
//       updateProject();
//       updateWorkerAssigned();
//     }

//     isLoading.value = false;
//   }

//   // update project
//   updateProject() async {
//     var response = await _dataProvider.getWorkerProjects(
//         endPoint: Enpoints.projectEnpoint);
//     if (!response.error) {
//       projects.value = response.response!;
//       await _dataProvider.deleteOders();
//       await _dataProvider.saveProjects(projects: response.response!);
//     } else {
//       negativeMessage(message: response.errorMessage!);
//     }
//   }

//   // // set Project
//   // setProject() async {
//   //   final HomeWorkForceController _workForceController = Get.find();
//   //   if (projects.length == 1) {
//   //     await _workForceController.getWorkersFromProject(
//   //         projectId: projects[0].projectId!);
//   //   }
//   // }

//   // get projects
//   getProjects() async {
//     var response = await _dataProvider.getWorkerProjects(
//         endPoint: Enpoints.projectEnpoint);
//     if (!response.error) {
//       projects.value = response.response!;
//       await _dataProvider.saveProjects(projects: response.response!);
//     } else {
//       negativeMessage(message: response.errorMessage!);
//     }
//   }

//   // get assigned workers
//   getAssignedWorkers() async {
//     var response = await _dataProvider.getAssignedWorkers(
//         endPoint: Enpoints.assignedWorkersEnpoint);
//     if (!response.error) {
//       assignedWorkers.value = response.response!;
//       for (var item in response.response!) {
//         await DatabaseService.instance.addWorkers(worker: item);
//       }
//     } else {
//       negativeMessage(message: response.errorMessage!);
//     }
//   }

//   // updateWorkersAfterAttendance({required int projectId}) async {
//   //   final HomeWorkForceController _workerForceController = Get.find();
//   //   await updateWorkerAssigned();
//   //   await _workerForceController.getWorkersFromProject(projectId: projectId);
//   // }

//   // update worker assigned
//   updateWorkerAssigned() async {
//     // get assigned workers
//     var response = await _dataProvider.getAssignedWorkers(
//         endPoint: Enpoints.assignedWorkersEnpoint);
//     if (!response.error) {
//       assignedWorkers.value = response.response!;
//       await DatabaseService.instance.delete(tableName: "assignedWorkers");
//       for (var item in response.response!) {
//         await DatabaseService.instance.addWorkers(worker: item);
//       }
//     } else {
//       negativeMessage(message: response.errorMessage!);
//     }
//   }

//   // void onEvent(PusherEvent event) {
//   //   print("onEvent: $event");
//   // }

//   // void onSubscriptionSucceeded(String channelName, dynamic data) {
//   //   print("onSubscriptionSucceeded: $channelName data: $data");
//   // }

//   // void onSubscriptionEventSucceeded(dynamic data) {
//   //   print("onSubscriptionEventSucceeded: data: $data");
//   // }

//   // void onSubscriptionError(String message, dynamic e) {
//   //   print("onSubscriptionError: $message Exception: $e");
//   // }

//   // void onDecryptionFailure(String event, String reason) {
//   //   print("onDecryptionFailure: $event reason: $reason");
//   // }

//   // void onMemberAdded(String channelName, PusherMember member) {
//   //   print("onMemberAdded: $channelName member: $member");
//   // }

//   // void onMemberRemoved(String channelName, PusherMember member) {
//   //   print("onMemberRemoved: $channelName member: $member");
//   // }

//   // dynamic onAuthorizer(
//   //     String channelName, String socketId, dynamic options) async {
//   //   var response = await _apiService.postRequestMethod(
//   //       headers: await _dataProvider.headerDetails(),
//   //       body: {
//   //         "socket_id": socketId,
//   //         "channel_name": channelName,
//   //       },
//   //       endPoint: Enpoints.pusherAuthEnpoint);
//   //   print(
//   //       "socket id :: ${socketId} :: ${channelName} :: ${response.response!.body}");
//   //   var data = {};

//   //   data = json.decode(response.response!.body);
//   //   return data;
//   // }

//   // void onConnectionStateChange(dynamic currentState, dynamic previousState) {
//   //   print("Connection: $currentState");
//   // }

//   // void onError(String message, int? code, dynamic e) {
//   //   print("onError: $message code: $code exception: $e");
//   // }

//   // setPusher() async {
//   //   var user = await _dataProvider.getUserDetails();
//   //   try {
//   //     await pusher.init(
//   //         apiKey: "5dbfc8f467a1222ed963",
//   //         cluster: "ap2",
//   //         onConnectionStateChange: onConnectionStateChange,
//   //         onError: onError,
//   //         onSubscriptionSucceeded: onSubscriptionSucceeded,
//   //         onEvent: onEvent,
//   //         onSubscriptionError: onSubscriptionError,
//   //         onDecryptionFailure: onDecryptionFailure,
//   //         onMemberAdded: onMemberAdded,
//   //         onMemberRemoved: onMemberRemoved,
//   //         authEndpoint: Enpoints.pusherAuthEnpoint,
//   //         onAuthorizer: onAuthorizer);
//   //     await pusher.subscribe(
//   //         channelName: 'attendance-status',
//   //         // onSubscriptionError: ,
//   //         // onEvent:
//   //         onSubscriptionSucceeded: onSubscriptionEventSucceeded);
//   //     await pusher.connect();
//   //   } catch (e) {
//   //     print("ERROR: $e");
//   //   }
//   // }

//   // Future<void> setPusher() async {
//   //   var user = await _dataProvider.getUserDetails();
//   //   try {
//   //     pusher = PusherClient(
//   //       "5dbfc8f467a1222ed963",
//   //       PusherOptions(
//   //         host: Enpoints.baseUrl,
//   //         encrypted: false,
//   //         auth: PusherAuth(
//   //           Enpoints.pusherAuthEnpoint,
//   //           headers: {
//   //             'Content-Type': 'application/json',
//   //             'Authorization': 'Bearer ${user.jwt}',
//   //             "socket_id": pusher!.getSocketId()!,
//   //             "channel_name": "private-notification-${user.user!.id}"
//   //           },
//   //         ),
//   //         cluster: 'ap2',
//   //       ),
//   //       enableLogging: true,
//   //     );
//   //     channel = pusher
//   //         ?.subscribe("private-notification-" + user.user!.id!.toString());

//   //     pusher?.onConnectionStateChange((state) {
//   //       print(
//   //           "previousState: ${state?.previousState}, currentState: ${state?.currentState}");
//   //     });

//   //     pusher?.onConnectionError((error) {
//   //       print("error: ${error?.message}");
//   //     });

//   //     channel?.bind('private-notification-event', (event) {
//   //       print("event here ::${event!.channelName}");
//   //     });
//   //   } catch (e) {
//   //     print(e.toString());
//   //   }
//   // }

//   // setPusher() async {
//   //   var user = await _dataProvider.getUserDetails();

//   //   PusherOptions options = PusherOptions(
//   //       cluster: "ap2",
//   //       // encrypted: true,
//   //       ).;
//   //   pusher = PusherClient("5dbfc8f467a1222ed963", options,
//   //       autoConnect: true, enableLogging: true);
//   //   // PusherClient pusher = PusherClient(
//   //   //   "5dbfc8f467a1222ed963",
//   //   //   PusherOptions(
//   //   //     cluster: "ap2",
//   //   //   ),
//   //   //   enableLogging: true,
//   //   // );
//   //   // pusher.subscribe("private-notification-${user.user!.id}");

//   //   // channel = pusher!.subscribe("private-notification-${user.user!.id}");
//   //   pusher!.onConnectionStateChange((state) {
//   //     print("currentState: ${state!.currentState}");
//   //     print("socket id :: ${pusher!.getSocketId()}");
//   //     print("socket id :: ${pusher!.getSocketId()}");
//   //   });
//   //   pusher!.subscribe("private-notification-${user.user!.id}");
//   //   pusher!.onConnectionError((error) {
//   //     print("error: ${error!.message}");
//   //   });
//   // }

//   List<AttendanceStatus> getAttendanceStatusesByProject(
//       {required List<AttendanceStatus> statuses}) {
//     List<AttendanceStatus> response = [];
//     for (var item in projects) {
//       var responseStatus = statuses
//           .where((element) => item.projectName == element.projectName)
//           .toList();
//       response = [...responseStatus, ...response];
//     }

//     return response;
//   }

//   getAttendanceStatuses({required DateTime time}) async {
//     final DateFormat formatter = DateFormat('yyyy-MM-dd');
//     final String formattedDate = formatter.format(time);
//     var response = await _dataProvider.getAttendanceStatus(
//         endPoint: Enpoints.attendanceNotificationEnpoint,
//         body: {"date": formattedDate});
//     if (response.error) {
//       negativeMessage(message: "failed to get attendance statuses");
//     } else {
//       attendanceStatuses.value =
//           getAttendanceStatusesByProject(statuses: response.response!);
//       alltAtendanceStatuses.value =
//           getAttendanceStatusesByProject(statuses: response.response!);
//     }
//   }

//   @override
//   void onInit() {
//     _initialize();
//     getUserInfo();
//     getAttendanceStatuses(time: DateTime.now());
//     checkForProjects();
//     super.onInit();
//   }
// }
