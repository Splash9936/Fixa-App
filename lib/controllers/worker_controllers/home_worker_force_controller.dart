import 'package:fixa/fixa_main_routes.dart';

class HomeWorkForceController extends GetxController {
  final MainController mainController = Get.find();
  // RxList<AssignedWorkers> assignedWorkers = <AssignedWorkers>[].obs;
  // RxList<AssignedWorkers> allAssignedWorkers = <AssignedWorkers>[].obs;
  RxBool isLoading = false.obs;
  RxList<Project> projects = <Project>[].obs;

  void getProjects() {
    projects.value = mainController.projects;
  }

  // getWorkersFromProject({required int projectId}) async {
  //   isLoading.value = true;
  //   var response = await DatabaseService.instance
  //       .getAllAssingedWorkerSaved(projectId: projectId);
  //   allAssignedWorkers.value = response;
  //   assignedWorkers.value = response;
  //   isLoading.value = false;
  // }

   getWorkersFromProjects({required int projectId}) async{
    await mainController.getAssignedWorkersSaved(projectId: projectId);
  }

  @override
  void onInit() {
    projects.value = mainController.projects;
    getProjects();
    super.onInit();
  }
}
