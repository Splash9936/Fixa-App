// import 'package:fixa/fixa_main_routes.dart';

// class MainWorkerForceController extends GetxController {
//   RxBool isGettingWorker = false.obs;
//   RxInt selectedProjectId = 0.obs;
//   RxList<AssignedWorkers> assignedWorkers = <AssignedWorkers>[].obs;
//   RxList<AssignedWorkers> allAssignedWorkers = <AssignedWorkers>[].obs;

//   getWorkersFromProject({required int projectId}) async {
//     print("workforce project id :: $projectId ");
//     isGettingWorker.value = true;
//     selectedProjectId.value = projectId;
//     var response = await DatabaseService.instance
//         .getAllAssingedWorkerSaved(projectId: projectId);
//     allAssignedWorkers.value = response;
//     assignedWorkers.value = response;
//     print("workforce project id :: ${response.length} ");
//     print("workforce project id :: ${allAssignedWorkers.length} ");
//     isGettingWorker.value = false;
//   }
// }
