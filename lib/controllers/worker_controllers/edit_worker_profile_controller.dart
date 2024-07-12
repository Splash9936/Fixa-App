import 'package:fixa/fixa_main_routes.dart';

class EditWorkerProfileController extends GetxController {
  final MainController mainController = Get.find();
  final WorkerProfileController _workerProfileController = Get.find();
  List<AssignedWorkers> assignedWorkers = [];
  Rx<TextEditingController> firstName = TextEditingController().obs;
  Rx<TextEditingController> lastName = TextEditingController().obs;
  Rx<TextEditingController> idNumber = TextEditingController().obs;
  Rx<TextEditingController> rssbCodeText = TextEditingController().obs;
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  Rx<TextEditingController> workerRate = TextEditingController().obs;
  Rx<TextEditingController> workerNewRate = TextEditingController().obs;
  RxList<Widget> serviceWidgets = <Widget>[].obs;
  RxList<DeductionControllers> rateControllers = <DeductionControllers>[].obs;
  RxBool isLoading = false.obs;
  RxBool isSubmitLoading = false.obs;
  RxBool isPhoneNumberVerified = false.obs;
  RxBool isGender = false.obs;
  final _apiService = ApiHandler();
  final _dataProvider = DataProvider();
  RxList<District> districts = <District>[].obs;
  Rx<District> district = District().obs;
  RxString districtName = "".obs;
  RxInt serviceId = 0.obs;
  RxInt serviceNewId = 0.obs;

  getDistricts() async {
    isLoading.value = true;
    var response =
        await _dataProvider.getDistricts(endPoint: Enpoints.districtEnpoint);
    if (!response.error) {
      districts.value = response.response!;
      isLoading.value = false;
    } else {
      isLoading.value = false;
      negativeMessage(message: response.errorMessage!);
    }
    isLoading.value = false;
  }

  setDistrict(String? distrNm) async {
    await getDistricts();
    if (distrNm != null && distrNm.isNotEmpty) {
      var distrct = districts
          .where((item) =>
              item.districtName!.toLowerCase() == distrNm.toLowerCase())
          .toList();
      if (distrct.isNotEmpty) {
        district.value = distrct[0];
      } else {
        district.value = districts[0];
      }
    }
  }

  setTextField(
      {required String firstNam,
      required String lastNam,
      required String districtNam,
      required String gendr,
      required String idNUmbr,
      required String phoneNUmbr}) {
    firstName.value.text = firstNam;
    lastName.value.text = lastNam;
    idNumber.value.text = idNUmbr;
    phoneNumber.value.text = phoneNUmbr;
    setGender(gendr);
    setDistrict(districtNam);
  }

  setGender(String? gender) {
    if (gender == null) {
      isGender.value = false;
    } else if (gender == "female") {
      isGender.value = true;
    } else if (gender == "male") {
      isGender.value = false;
    } else {
      isGender.value = false;
    }
  }

  void phoneVerified() {
    isPhoneNumberVerified.value = !isPhoneNumberVerified.value;
  }

  // change gender
  void changeGender() {
    isGender.value = !isGender.value;
  }

  // add service
  void addRate() {
    rateControllers
        .add(DeductionControllers(0, 0, TextEditingController(), false));
    // serviceWidgets.add(widget);
  }

  // add service
  void removeRate({required DeductionControllers deductionController}) {
    rateControllers.remove(deductionController);
  }

  List<Map<String, dynamic>> getDeductionBody(
      {required List<All> workersRates, required int assignedWorkerId}) {
    List<Map<String, dynamic>> deductionBody = [];
    for (var item in rateControllers) {
      deductionBody.add({
        "id": item.deductionTypeId,
        "daily_rate": item.deductedAmount.text,
        "assigned_worker_id": assignedWorkerId
      });
    }
    // for (var item in workersRates) {
    //   deductionBody.add({
    //     "id": item.serviceId,
    //     "daily_rate": item.value.toString(),
    //     "assigned_worker_id": assignedWorkerId
    //   });
    // }
    return deductionBody;
  }

  // submit function for updating a worker

  submit(
      {required GlobalKey<FormState> key,
      required List<All> workersRates,
      required int assignedWorkerId,
      required String rssbCode,
      required BuildContext context,
      required int projectId,
      required String currentfirstName,
      required String currentlastName,
      required String currentdistrictName,
      required String currentidNumber,
      required String currentphoneNumber,
      required int workerId}) async {
    final isValid = key.currentState!.validate();
    if (isValid) {
      isSubmitLoading.value = true;
      var body = {
        // "first_name": firstName.value.text.isEmpty
        //     ? currentfirstName
        //     : firstName.value.text,
        "gender": isGender.value ? "female" : "male",
        // "last_name":
        //     lastName.value.text.isEmpty ? currentlastName : lastName.value.text,
        "district": districtName.value.isEmpty
            ? currentdistrictName
            : districtName.value,
        // "nid_number":
        //     idNumber.value.text.isEmpty ? currentidNumber : idNumber.value.text,
        "rssb_code": rssbCodeText.value.text.isEmpty
            ? rssbCode
            : rssbCodeText.value.text,
        // "phone_number": phoneNumber.value.text.isEmpty
        //     ? currentphoneNumber
        //     : phoneNumber.value.text,
        "services": getDeductionBody(
            workersRates: workersRates, assignedWorkerId: assignedWorkerId)
      };

      var response = await _apiService.putRequestMethod(
          headers: await _dataProvider.headerDetails(),
          body: body,
          endPoint: "${Enpoints.workersEnpoint}/$workerId");
      if (response.error) {
        isSubmitLoading.value = false;
        negativeMessage(message: "${response.errorMessage}");
      } else {
        var bodyWorker = json.decode(response.response!.body);
       

        // get and update worker
        var workerToUpdate =
            await DatabaseService.instance.getAssingedWorkerProjectIdSaved(
          assignedWorkerId: assignedWorkerId,
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
                firstName: bodyWorker['data']["first_name"],
                isVerified: workerToUpdate[0].isVerified,
                district: bodyWorker['data']["district"],
                lastName: bodyWorker['data']["last_name"],
                phoneNumber: bodyWorker['data']["phone_number"],
                nidNumber: bodyWorker['data']["nid_number"],
                rates: workerToUpdate[0].rates,
                services: workerToUpdate[0].services,
              ));
          await mainController.getWorkersFromProject(projectId: projectId);
          await mainController.getAttendances(
              time: mainController.dateTme.value, projectId: projectId);
          await _workerProfileController.getWorkerProfileInfo(
              assignedWorkerId: assignedWorkerId,
              workerProjectId: projectId,
              workerId: workerId);
          isSubmitLoading.value = false;
        }
        positiveMessage(message: "Worker profile updated successfully");
      }

      isSubmitLoading.value = false;
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  // add service
  void addService({required Widget widget}) {
    serviceWidgets.add(widget);
  }

  // remove service
  void removeService() {
    serviceWidgets.value = [];
    serviceNewId.value = 0;
    workerNewRate.value.clear();
  }

  bool checkIfIdExist({required String idNumber}) {
    for (var item in assignedWorkers) {
      if (item.nidNumber == idNumber) {
        return true;
      }
    }
    return false;
  }

  String? idNumberValidator(String value) {
    if (value.isEmpty || value.length < 16 || value.length > 16) {
      return 'Please, Input a valid id number';
    } else if (checkIfIdExist(idNumber: value)) {
      return 'Attention, This id is already in use';
    }
    return null;
  }

  bool checkIfPhoneNumberExist({required String phoneNumber}) {
    for (var item in assignedWorkers) {
      if (item.phoneNumber == phoneNumber) {
        return true;
      }
    }
    return false;
  }

  String? phoneNumberValidator(String value) {
    if (value.isEmpty || value.length < 10 || value.length > 10) {
      return 'Please, Input a phoneNumber';
    } else if (checkIfPhoneNumberExist(phoneNumber: value)) {
      return 'Attention, This Phone number is already in use';
    }
    return null;
  }

  // get workers saved
  getWorkersSaved() async {
    assignedWorkers = await DatabaseService.instance.getAssingedWorkerSaved();
  }

  @override
  void onInit() {
    getWorkersSaved();
    super.onInit();
  }
}
