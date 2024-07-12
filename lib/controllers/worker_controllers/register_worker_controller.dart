import 'package:fixa/fixa_main_routes.dart';
import 'package:intl/intl.dart';

class RegisterWorkerController extends GetxController {
  final HomeRecordAttendanceController _recordAttendanceController = Get.find();
  final MainController mainController = Get.find();
  final _dataProvider = DataProvider();
  RxBool isLoading = false.obs;
  RxBool isSubmitLoading = false.obs;
  RxBool isfirstName = false.obs;
  RxBool islastName = false.obs;
  RxBool isidNumber = false.obs;
  RxBool isphoneNumber = false.obs;
  RxBool isworkerRate = false.obs;
  RxBool isdistrictName = false.obs;
  RxBool isserviceId = false.obs;
  RxBool isGender = false.obs;
  RxBool isForeigner = false.obs;
  RxBool isNationalitySelected = false.obs;
  RxBool isPhoneNumberVerified = false.obs;
  RxBool isIdNumberLocked = true.obs;
  List<AssignedWorkers> assignedWorkers = [];
  RxList<District> districts = <District>[].obs;
  RxList<Country> countries = <Country>[].obs;
  RxList<Widget> serviceWidgets = <Widget>[].obs;
  Rx<TextEditingController> firstName = TextEditingController().obs;
  Rx<TextEditingController> lastName = TextEditingController().obs;
  // Rx<TextEditingController> idNumber = TextEditingController().obs;
  Rx<TextEditingController> idVerificationNumber = TextEditingController().obs;
  Rx<TextEditingController> dateOfBirth = TextEditingController().obs;
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  Rx<TextEditingController> workerRate = TextEditingController().obs;
  Rx<IdVerificationData> workerInformation = IdVerificationData().obs;
  RxInt countryId = 0.obs;
  RxString districtName = "".obs;
  Rx<Services> serviceSelected = Services().obs;
  RxString errorNidFetching = "".obs;
  RxString dateOfBirthInput = "Select Date Of Birth".obs;

  // search worker from rssb
  void searchingNid({required String nid}) async {
    isSubmitLoading.value = true;
    
   
    var response = await _dataProvider.getNidInformation(nid: nid);
    if(response.error){
      errorNidFetching.value = response.errorMessage ?? "Error in getting NID information";
      negativeMessage(message: response.errorMessage ?? "Error in getting NID information");
    }else {
      workerInformation.value = response.response!;
     DateTime originalDate = DateFormat('MM/dd/yyyy').parse(response.response!.dateOfBirth!);
     String formattedDate = DateFormat('yyyy-MM-dd').format(originalDate);
      isNationalitySelected.value = true;
      firstName.value.text = workerInformation.value.firstName ?? "";
      lastName.value.text = workerInformation.value.lastName ?? "";
      // idNumber.value.text = idVerificationNumber.value.text;
      dateOfBirth.value.text =  formattedDate;
      dateOfBirthInput.value = formattedDate;
    }
    isSubmitLoading.value = false;
  }

  void changeGender() {
    isGender.value = !isGender.value;
  }

    void changeNationality() {
    isForeigner.value = !isForeigner.value;
    isNationalitySelected.value = !isNationalitySelected.value;
    idVerificationNumber.value.clear();
    isIdNumberLocked.value =!isIdNumberLocked.value;
  }

  void phoneVerified() {
    isPhoneNumberVerified.value = !isPhoneNumberVerified.value;
  }

  // add service
  void addService({required Widget widget}) {
    serviceWidgets.add(widget);
  }

  // add service
  void removeService() {
    serviceWidgets.value = [];
    // serviceId.value = 0;
    workerRate.value.clear();
  }

  void getDistricts() async {
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
   void getCountries() async {
    isLoading.value = true;
    var response =
        await _dataProvider.getCountries(endPoint: Enpoints.countriesEnpoint);
    if (!response.error) {
      countries.value = response.response!;
      isLoading.value = false;
    } else {
      isLoading.value = false;
      negativeMessage(message: response.errorMessage!);
    }
    isLoading.value = false;
  }

  String arrayToString(List array) {
  String delimiter = '|';
  return array.join(delimiter);
}
  

  void submit(
      {required GlobalKey<FormState> key,
      required Project project,
      required Services selectedService}) async {
    final isValid = key.currentState!.validate();
    if (isValid) {
      List phoneNumbersMasked = [];
      var stringArray = "";
      if(workerInformation.value.phoneNumbers == null || workerInformation.value.phoneNumbers!.isEmpty){
        stringArray = "[]";
      }else{
        phoneNumbersMasked = workerInformation.value.phoneNumbers!.map((item) => item.phoneNumber).toList();
         stringArray = phoneNumbersMasked.toString();
      }
      var newWorker = {
        "firstname": firstName.value.text,
        "lastname": lastName.value.text,
        "district": districtName.value,
        "nida": idVerificationNumber.value.text,
        "phone": phoneNumber.value.text.isEmpty? "":phoneNumber.value.text,
        "service_id": selectedService.id,
        "daily_rate":
            (workerRate.value.text.isEmpty || workerRate.value.text == '0')
                ? null
                :  workerRate.value.text.replaceAll(',', ''),
        "gender": isGender.value ? "female" : "male",
        "country_id": countryId.value.toString(),
        "phone_numbers": [].toString(),
        "phone_numbers_masked":stringArray,
        "date_of_birth": dateOfBirth.value.text
      };
      var shift = mainController.shift.value ? 'Night' : 'Day';
      await DatabaseService.instance.addRegisteredWorkers(worker: newWorker);
      var attendancesWorkers = mainController.allAttendances
          .where((item) =>
              item.service != null &&
              item.shiftName!.toLowerCase() == shift.toLowerCase() &&
              item.service!.toLowerCase() ==
                  selectedService.name?.toLowerCase())
          .toList();
      await _recordAttendanceController.getAssignedWorkers(
          projectId: project.projectId!,
          project: project,
          serviceId: 0,
          workersAttendances: attendancesWorkers);
      await getWorkersSaved();
      // await _recordAttendanceController.selectWorkersRegistered();

      key.currentState!.reset();
      firstName.value.clear();
      lastName.value.clear();
      idVerificationNumber.value.clear();
      phoneNumber.value.text = '';
      workerRate.value.clear();
      districtName.value = "";
      // serviceId.value = 0;
      isPhoneNumberVerified.value = false;

      positiveMessage(message: "You have successfully registered new worker");
      isNationalitySelected.value = false;
      isForeigner.value = false;
    }else {
      // print("not valid");
    }
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
      return 'Please input a valid id number';
    } else if (checkIfIdExist(idNumber: value)) {
      return 'Attention this id is already in use';
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

  bool checkIfPhoneNumberIsCorrect({required String phoneNumber}) {
    bool status = false;
    if (phoneNumber.startsWith("078") || phoneNumber.startsWith("079")) {
    } else {
      status = true;
    }
    return status;
  }

  bool checkIfIDIsCorrect({required String idDNumber}) {
    bool status = false;
    if ((idDNumber.startsWith("11") ||
        idDNumber.startsWith("12") ||
        idDNumber.startsWith("21") ||
        idDNumber.startsWith("22") ) && idDNumber.length ==16) {
    // } else {
      status = true;
    }
    return status;
  }

  String? phoneNumberValidator(String value) {
    if (value.isEmpty || value.length < 10 || value.length > 10) {
      return 'Please input a valid phoneNumber';
    } else if (checkIfPhoneNumberExist(phoneNumber: value)) {
      return 'Attention this Phone number is already in use';
    }
    return null;
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
      newData.add(newWorkerRecorded);
    }

    return newData;
  }

  // get workers saved
  getWorkersSaved() async {
   var  assignedWorkersData = await DatabaseService.instance.getAssingedWorkerSaved();
    var newWorkersResponse = await DatabaseService.instance.getAllRegisteredWorkerSaved();
    var registeredWorkers =   arrangeRegisteredWorkers(workers: newWorkersResponse);
    assignedWorkers = [...assignedWorkersData,...registeredWorkers];
  }

  @override
  void onInit() {
    getDistricts();
    getCountries();
    getWorkersSaved();
    super.onInit();
  }
}
