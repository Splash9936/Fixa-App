import 'package:fixa/fixa_main_routes.dart';

class HomeSearchWorkerController extends GetxController {
  final _apiHandler = ApiHandler();
  final _dataProvider = DataProvider();
  RxList<AssignedWorkers> assignedWorkers = <AssignedWorkers>[].obs;
  RxList<AssignedWorkers> allAssignedWorkers = <AssignedWorkers>[].obs;
  RxList<AssignedWorkers> selectedAssignedWorkers = <AssignedWorkers>[].obs;
  Rx<TextEditingController> sms = TextEditingController().obs;
  RxBool isLoading = false.obs;
  RxBool issmsLoading = false.obs;

  // search worker
  bool searchByConcatenation(
      {required firstNamee, required lastNamee, required dataName}) {
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

  void searchWorkers({required String data, required bool isEmpty}) {
    List<AssignedWorkers> newWorkers = [];
    if (isEmpty) {
      newWorkers = allAssignedWorkers;
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

  void addWorker({required AssignedWorkers toAdd}) {
    if (selectedAssignedWorkers.contains(toAdd)) {
      reverseArrangedWorkers(toAdd: toAdd);
      reversedArrangedAllWorkers(toAdd: toAdd);
      selectedAssignedWorkers.remove(toAdd);
    } else {
      rearrangeWorkers(toAdd: toAdd);
      rearrangeAllWorkers(toAdd: toAdd);
      selectedAssignedWorkers.add(toAdd);
    }
  }

  void setWorkers({required List<AssignedWorkers> workers}) {
    allAssignedWorkers.value = workers;
    assignedWorkers.value = workers;
  }

  List<String> workerPhoneNumbers({required List<AssignedWorkers> workers}) {
    List<String> workersPhones = [];
    for (var item in workers) {
      if (item.phoneNumber != null && item.phoneNumber!.length == 10) {
        var newWorkerPhone = item.phoneNumber!.replaceAll("07", "+2507");
        workersPhones.add(newWorkerPhone);
      }
    }
    return workersPhones;
  }

  // send message
  sendMessage() async {
    issmsLoading.value = true;
    var workersPhoneNumbers =
        workerPhoneNumbers(workers: selectedAssignedWorkers);
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
        positiveMessage(
            message:
                "Message sent to ${selectedAssignedWorkers.length} worker(s) successfully");
        assignedWorkers.value = allAssignedWorkers;
        sms.value.clear();
        selectedAssignedWorkers.value = [];
      }
      issmsLoading.value = false;
    } else {
      negativeMessage(
          message: "Workers with incomplete phone numbers ,please check");
      issmsLoading.value = false;
    }
    issmsLoading.value = false;
  }
}
