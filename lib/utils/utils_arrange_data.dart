// ignore_for_file: unnecessary_string_interpolations

import 'package:fixa/fixa_main_routes.dart';
import 'package:intl/intl.dart';

List<String> getLitsts({required String items}) {
  List<String> data = [];
  if (items.isNotEmpty) {
    String text = items.replaceAll('[', '').replaceAll(']', '');
    List<String> result = text.split(',');
    data = result;
  }

  return data;
}

String getServiceName(
    {required List<Services> servicesList, required String serviceId}) {
  String serviceName = "no-service";

  var service =
      servicesList.where((item) => item.id == int.parse(serviceId)).toList();
  if (service.isNotEmpty) {
    serviceName = service[0].name!;
  }

  return serviceName;
}

List<Map<String, dynamic>> getServiceRates(
    {required String services, required List<Services> servicesList}) {
  List<Map<String, dynamic>> data = [];
  var newServicesIds = getLitsts(items: services);

  for (var i = 0; i < newServicesIds.length; i++) {
    data.add({
      "service_name": getServiceName(
          serviceId: newServicesIds[i], servicesList: servicesList),
      "service_id": int.parse(newServicesIds[i])
    });
  }

  return data;
}

int getServiceWorkers(
    {required Services service,
    required List<WorkerAttendance> attendances,
    required bool shift}) {
  int number = 0;
  if (service.id == 0) {
    if (shift) {
      // night
      number = attendances
          .where((item) => item.shiftName == 'night')
          .toList()
          .length;
    } else {
      // day
      number =
          attendances.where((item) => item.shiftName == 'day').toList().length;
    }
  } else {
    if (shift) {
      // night
      number = attendances
          .where((item) =>
              item.service == service.name && item.shiftName == 'night')
          .toList()
          .length;
    } else {
      // day
      number = attendances
          .where(
              (item) => item.service == service.name && item.shiftName == 'day')
          .toList()
          .length;
    }
  }

  return number;
}

List<AssignedWorkers> getAssignedWorkerNumber(
    {required List<AssignedWorkers> assignedWorkers, required int serviceId}) {
  List<AssignedWorkers> sum = [];

  for (var item in assignedWorkers) {
    var services =
        item.services == "[]" ? [] : getLitsts(items: item.services!);
        
        if(services.isNotEmpty){
          if (serviceId.toString() ==services[0].toString()){
            sum.add(item);
          }
        }
    // if (services.isNotEmpty) {
    //   if (serviceId == int.parse(services[0])) {
    //     sum.add(item);
    //   }
    // }
  }
  // sum = assignedWorkers.where((item) {
  //   var services = getLitsts(items: item.services!);
  //   print("services ${services.toString()}");
  //   return services.isEmpty || services == null
  //       ? false
  //       : serviceId == int.parse(services[0]);
  // }).toList();
  return sum;
}

 List<Map<String,String>> getWorkersPerServices({required List<AssignedWorkers> assignedWorkers, required List<Services> services,required int projectId}){
  List<Map<String,String>> data = [];
  for (var item in services) {
    int sum = 0;
    for (var itemx in assignedWorkers) {
       var services =itemx.services == "[]" ? [] : getLitsts(items: itemx.services!);
    if (services.isNotEmpty) {
      if (item.id.toString() == services[0].toString()) {
        sum = sum +1;
      }
    }
    }
    if(sum !=0){
      data.add({"serviceName":item.name!,"count":sum.toString(),"service_id":item.id.toString()});
    }
  }
  return data;
 }

bool getExtra({required TablePayroll tablePayroll, required int serviceId}) {
  bool status = false;
  for (var item in tablePayroll.extra!) {
    if (item.level == serviceId) {
      status = true;
    }
  }

  return status;
}

String getPayrollHistoryPerService(
    {required Services service,
    required List<PayrollTransactions> payrollWorkers}) {
  int sum = 0;
  if (service.id == 0) {
    sum = payrollWorkers.length;
  } else {
    for (var item in payrollWorkers) {
      if (item.serviceName != null &&
          item.serviceName!.toLowerCase() == service.name!.toLowerCase()) {
        sum = sum + 1;
      }
    }
  }

  return sum.toString();
}

String getPaymentTypeName(
    {required String paymentTypeId, required List<PaymentsType> paymentTypes}) {
  String typeName = '';
  var paymentTypesNames = paymentTypes
      .where((item) => item.id.toString() == paymentTypeId)
      .toList();
  if (paymentTypesNames.isNotEmpty) {
    typeName = paymentTypesNames[0].typeName!;
  }
  return typeName;
}

getPaymentTypesInfo(
    {required int paymentTypeId, required List<Payments> payments}) {
  int sum = 0;
  if (paymentTypeId == 0) {
    sum = payments.length;
  } else {
    sum = payments
        .where((item) => item.paymentTypesId == paymentTypeId.toString())
        .toList()
        .length;
  }
  return "$sum";
}
// get ranks_type

String getRankType(
    {required List<Map<String, dynamic>> rankings,
    required int metricId,
    required int questionId}) {
  String rankType = "Unkown";
  var result =
      rankings.where((item) => item["code"] == "$metricId$questionId").toList();
  if (result.isNotEmpty) {
    rankType = result[0]["rank_type_name"];
  }

  return rankType;
}

// get ranks_type_index

int getRankTypeIndex(
    {required List<Map<String, dynamic>> rankings,
    required int metricId,
    required int questionId}) {
  int rankType = 0;
  var result =
      rankings.where((item) => item["code"] == "$metricId$questionId").toList();
  if (result.isNotEmpty) {
    if (result[0]["rank_type_name"] == "Beginner") {
      rankType = 1;
    } else if (result[0]["rank_type_name"] == "Intermediate") {
      rankType = 2;
    } else if (result[0]["rank_type_name"] == "Advanced") {
      rankType = 3;
    }
  }

  return rankType;
}

bool checkIfRankIsInRange({required int meanScore}) {
  bool status = true;
  if (meanScore >= 0 && meanScore <= 100) {
    status = false;
  }
  return status;
}

int getAssessmentRank({required int meanScore}) {
  int rankType = 0;
  if (meanScore >= 1 && meanScore <= 50) {
    rankType = 1;
  } else if (meanScore >= 51 && meanScore <= 79) {
    rankType = 2;
  } else if (meanScore >= 80 && meanScore <= 100) {
    rankType = 3;
  }
  return rankType;
}

int getRankProfile({required List<AssessmentResult> assessmentsResults}) {
  int rankType = 0;
  if (assessmentsResults.isNotEmpty) {
    if (assessmentsResults[0].assessmentResult != null) {
      if (assessmentsResults[0].assessmentResult!.toLowerCase() ==
          "beginner".toLowerCase()) {
        rankType = 1;
      } else if (assessmentsResults[0].assessmentResult!.toLowerCase() ==
          "intermediate".toLowerCase()) {
        rankType = 2;
      } else if (assessmentsResults[0].assessmentResult!.toLowerCase() ==
          "advanced".toLowerCase()) {
        rankType = 3;
      }
    }
  }

  return rankType;
}

Widget getAttendanceStatus({required String status}) {
  if (status == "approved") {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 3, vertical: 3),
      decoration: BoxDecoration(
        color: greyGreenColorText,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "${nameCapitalised(status)}",
        style: TextStyling.smallRedTextStyle,
      ),
    );
  } else if (status == "declined") {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 3, vertical: 3),
      decoration: BoxDecoration(
        color: redlightDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "${nameCapitalised(status)}",
        style: TextStyling.redSmallTextStyle,
      ),
    );
  } else if (status == "pending") {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 3, vertical: 3),
      decoration: BoxDecoration(
        color: yeollowLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "${nameCapitalised(status)}",
        style: TextStyling.nameSmallOrangeTextStyle,
      ),
    );
  } else {
    return Container();
  }
}

String splitName(String? workerName) {
  String name = '--';
  if (workerName != null || workerName!.isNotEmpty) {
    var newName = workerName.split(' ');
    newName.removeWhere((item) => ["", null, false, 0].contains(item));
    if (newName.length > 1) {
      name =
          "${newName[0][0].toString().toUpperCase()}${newName[1][0].toString().toUpperCase()}";
    } else if (newName.length == 1) {
      name = "${newName[0][0].toString().toUpperCase()}";
    }
  }
  return name;
}

String checkForStringNull(String? nameNull, String name) {
  return (nameNull) ?? name;
}

String setDateOfBirth(String? date) {
  String newDate = "-";
  if (date != null && date != '-') {
    var toDate = DateTime.parse(date);
    newDate = "${toDate.day}/${toDate.month}/${toDate.year}";
  }
  return newDate;
}

String getDate({required String date}) {
  // DateTime time = DateTime.now();
  var newTime = DateTime.parse(date);

  return "${newTime.day} | ${newTime.month} | ${newTime.year}";
}

String getTimePayroll(
    {required int year,
    required int month,
    required List<Map<String, dynamic>> monthData}) {
  String time = '';
  for (var item in monthData) {
    if (item['id'].toString() == month.toString()) {
      time = "${item["month_name"]}, $year";
    }
  }
  return time;
}

String getTimePayrollDetails(
    {required int month, required List<Map<String, dynamic>> monthData}) {
  String time = '';
  for (var item in monthData) {
    if (item['id'].toString() == month.toString()) {
      time = "${item["month_name"]} Payments";
    }
  }
  return time;
}

String nameCapitalised(String? name) {
  String text = '-';
  if (name != null || name!.isNotEmpty) {
    text = "${name[0].toUpperCase()}${name.substring(1).toLowerCase()}";
  }
  return text;
}

String fullNameCapitalised(String? name) {
  String text = '';
  if (name != null || name!.isNotEmpty) {
    var names = name.split(' ');
    if (names.isNotEmpty) {
      for (var item in names) {
        if (item.isNotEmpty) {
          text = "$text ${nameCapitalised(item.trim())}";
        }
      }
    }
  }
  return text;
}

String nameProfileText(String? name){
  String text = '';
  if (name != null || name!.isNotEmpty){
    var names = name.split(' ');
    if(names.isNotEmpty){
      for (var item in names) {
        if(item.isNotEmpty){
          text= "$text${item[0].toString().toUpperCase()}";
        }
      }
    }
  }
  return text;
}

List<Map<String, dynamic>> arrangeServices(
    {required List<Services> allServices,
    required List<WorkerAttendance> workersAttendance,
    required bool shift}) {
  List<Map<String, dynamic>> services = [];
  List<Map<String, dynamic>> allServicesWithData = [];
  List<Map<String, dynamic>> allServicesWithNoData = [];
  for (var item in allServices) {
    var workersService = getServiceWorkers(
        service: item, attendances: workersAttendance, shift: shift);
    if (item.name!.toLowerCase() == "all") {
      services.add({
        "service_name":
            "${item.name![0].toUpperCase()}${item.name!.substring(1).toLowerCase()}",
        "service_workers": workersService,
        "service_id": item.id
      });
    } else if (workersService == 0 && item.name!.toLowerCase() != "all") {
      allServicesWithNoData.add({
        "service_name":
            "${item.name![0].toUpperCase()}${item.name!.substring(1).toLowerCase()}",
        "service_workers": 0,
        "service_id": item.id
      });
    } else if (workersService > 0 && item.name!.toLowerCase() != "all") {
      allServicesWithData.add({
        "service_name":
            "${item.name![0].toUpperCase()}${item.name!.substring(1).toLowerCase()}",
        "service_workers": workersService,
        "service_id": item.id
      });
    }
  }

  services = [...services, ...allServicesWithData, ...allServicesWithNoData];

  return services;
}

List<WorkerAttendance> getWorkersAttendances(
    {required List<WorkerAttendance> attendances,
    required bool isShift}) {
  List<WorkerAttendance> workersAttendances = [];
  if (isShift) {
    // if (service.id == 0) {
      workersAttendances = attendances
          .where((item) =>
              item.shiftName!.toLowerCase() == 'night' && item.service != null)
          .toList();
    // } else {
    //   workersAttendances = attendances
    //       .where((item) =>
    //           item.shiftName!.toLowerCase() == 'night' &&
    //           item.service != null &&
    //           item.service!.toLowerCase() == service.name!.toLowerCase())
    //       .toList();
    // }
  } else {
    // if (service.id == 0) {
      workersAttendances = attendances
          .where((item) =>
              item.shiftName!.toLowerCase() == 'day' && item.service != null)
          .toList();
    // } else {
    //   workersAttendances = attendances
    //       .where((item) =>
    //           item.shiftName!.toLowerCase() == 'day' &&
    //           item.service != null &&
    //           item.service!.toLowerCase() == service.name!.toLowerCase())
    //       .toList();
    // }
  }
  return workersAttendances;
}

bool checkAttendanceWorkerPresence(
    {int? assignedWorkerId, required List<AssignedWorkers> attendanceWorkers}) {
  bool status = false;

  for (var item in attendanceWorkers) {
    if (assignedWorkerId != null &&
        item.assignedWorkerId != null &&
        item.assignedWorkerId == assignedWorkerId) {
      status = true;
    }
  }

  return status;
}

bool checkSelectedWorkerPresence(
    {required AssignedWorkers assignedWorker,
    required List<AssignedWorkers> selectedWorker}) {
  bool status = false;
  if (selectedWorker.contains(assignedWorker)) {
    status = true;
  }

  // for (var item in selectedWorker) {
  //   if (item.assignedWorkerId != null &&
  //       item.assignedWorkerId == assignedWorkerId) {
  //     status = true;
  //   }
  // }

  return status;
}

Color getCircledColor(
    {required List<AssignedWorkers> selectedAssignedWorkers,
    required AssignedWorkers workerAssign,
    required List<AssignedWorkers> workersSelectedAttendance}) {
  if (workerAssign.id != null &&
      checkAttendanceWorkerPresence(
          assignedWorkerId: workerAssign.id!,
          attendanceWorkers: workersSelectedAttendance)) {
    return greenColor;
  } else {
    return blueDark;
  }
}

Widget recordAttendanceWorkerCard({
  required GestureTapCallback press,
  required AssignedWorkers workerAssign,
  required List<AssignedWorkers> workersSelectedAttendance,
  required List<AssignedWorkers> assignedWorkers,
  required List<AssignedWorkers> selectedAssignedWorkers,
}) {
  Widget selectedContainer = GestureDetector(
    onTap: press,
    child: Container(
      height: SizeConfig.heightMultiplier * 4,
      width: SizeConfig.widthMultiplier * 9,
      decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color:blueDark),
          shape: BoxShape.circle),
    ),
  );
  for (var item in assignedWorkers) {
    // if worker is present in the attendance
    if (item.assignedWorkerId != null &&
        checkAttendanceWorkerPresence(
            assignedWorkerId: item.assignedWorkerId!,
            attendanceWorkers: workersSelectedAttendance)) {
      // print("attendance found");
      selectedContainer = Container(
        height: SizeConfig.heightMultiplier * 4,
        width: SizeConfig.widthMultiplier * 9,
        decoration: BoxDecoration(color: greenColor, shape: BoxShape.circle),
        child: Center(
          child: SvgPicture.asset(
            Images.selectIcon,
            height: SizeConfig.heightMultiplier * 0.7,
            width: SizeConfig.widthMultiplier * 4,
            color: whiteColor,
          ),
        ),
      );
    }
    // if worker is selected
    else if (checkSelectedWorkerPresence(
        assignedWorker: item, selectedWorker: selectedAssignedWorkers)) {
      // print("found ");
      selectedContainer = GestureDetector(
        onTap: press,
        child: Container(
          height: SizeConfig.heightMultiplier * 4,
          width: SizeConfig.widthMultiplier * 9,
          decoration: BoxDecoration(color: blueDark, shape: BoxShape.circle),
          child: Center(
            child: SvgPicture.asset(
              Images.selectIcon,
              height: SizeConfig.heightMultiplier * 0.7,
              width: SizeConfig.widthMultiplier * 4,
              color: whiteColor,
            ),
          ),
        ),
      );
    } else {
      selectedContainer = GestureDetector(
        onTap: press,
        child: Container(
          height: SizeConfig.heightMultiplier * 4,
          width: SizeConfig.widthMultiplier * 9,
          decoration: BoxDecoration(
              color: whiteColor,
              border: Border.all(color: blueDark),
              shape: BoxShape.circle),
        ),
      );
    }
  }
  return selectedContainer;
}

String getWorkerPayrollSum(
    {required List<History> workerPayroll, required int totalDeductions}) {
  double sum = 0;
  for (var item in workerPayroll) {
    var rate = item.dailyEarnings ?? 0;
    sum = sum + rate;
  }
  sum = sum - totalDeductions;
  return "${currencyFormat(price: double.parse(sum.toString()))}";
}

String getSingleWorkerPayrollShiftSum(
    {required List<History> workerHistories, required bool isDay}) {
  double sumShift = 0;
  double sumShiftRate = 0;
  String shiftNamee = isDay ? 'days':'nights';
  if (isDay) {
    for (var item in workerHistories) {
      if (item.shift!.name != null &&
          item.shift!.name!.toLowerCase() == 'day') {
        var rate = item.dailyEarnings ?? 0;
        sumShift = sumShift + 1;
        sumShiftRate = sumShiftRate + rate;
        
      }
    }
  } else {
    for (var item in workerHistories) {
      if (item.shift!.name != null &&
          item.shift!.name!.toLowerCase() == 'night') {
        var rate = item.dailyEarnings ?? 0;
        sumShift = sumShift + 1;
        sumShiftRate = sumShiftRate + rate;
        
      }
    }
  }

  return "$sumShift $shiftNamee, ${currencyFormat(price: double.parse(sumShiftRate.toString()))} Rwf";
}

String getWorkerPayrollShiftSum(
    {required List<History> workerPayroll, required bool isDay}) {
  double sumShift = 0;
  double sumShiftRate = 0;
  if (isDay) {
    for (var item in workerPayroll) {
      if (item.shift != null && item.shift!.name!.toLowerCase() == 'day') {
        var rate = item.dailyEarnings ?? 0;
        sumShift = sumShift + 1;
        sumShiftRate = sumShiftRate + rate;
      }
    }
  } else {
    for (var item in workerPayroll) {
      if (item.shift != null && item.shift!.name!.toLowerCase() == 'night') {
        var rate = item.dailyEarnings ?? 0;
        sumShift = sumShift + 1;
        sumShiftRate = sumShiftRate + rate;
      }
    }
  }

  return "$sumShift days, ${currencyFormat(price: double.parse(sumShiftRate.toString()))} Rwf";
}

String getTotalDeductions({required List<Deductions> deductions}) {
  int sum = 0;
  for (var item in deductions) {
    var amount = item.deductionAmount ?? 0;
    sum = sum + amount;
  }
  return "${currencyFormat(price: double.parse(sum.toString()))} Rwf";
}

String getTotalEarnings({required List<PayrollWorkers> allPayrollWorkers}) {
  double sum = 0;
  for (var item in allPayrollWorkers) {
    var dayTotal = (item.dayShifts ?? 0) * (item.dailyRate ?? 0);
    var nightTotal = (item.nightShifts ?? 0) * (item.dailyRate ?? 0);
    var amount = dayTotal + nightTotal;
    sum = sum + amount;
  }
  return "${currencyFormat(price: double.parse(sum.toString()))} Rwf";
}

bool checkWorkerForceIfSelected(
    {required List<AssignedWorkers> selectedAssignedWorkers,
    required AssignedWorkers workerToCheck}) {
  bool status = false;
  for (var item in selectedAssignedWorkers) {
    if (item.assignedWorkerId != null &&
        workerToCheck.assignedWorkerId != null &&
        item.assignedWorkerId == workerToCheck.assignedWorkerId) {
      status = true;
    }
  }
  return status;
}

String currencyFormat({required double price}) {
  String currency = "";
  final NumberFormat usCurrency = NumberFormat('#,##0', 'en_US');
  currency = usCurrency.format(price);
  return currency;
}

Widget getAttendanceStatusShift({required String status}) {
  if (status == "half") {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 3, vertical: 3),
      decoration: BoxDecoration(
        color: yeollowLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "${nameCapitalised(status)} Shift",
        style: TextStyling.nameSmallOrangeTextStyle,
      ),
    );
  } else {
    return Container();
  }
}

bool parseBool({required String isVerified}) {
  bool status = false;
  if (isVerified.toLowerCase() == 'true') {
    return true;
  } else if (isVerified.toLowerCase() == 'false') {
    return false;
  }

  return status;
}

String parsingToDate(String? dateToParse) {
  if (dateToParse != null) {
    var date = DateTime.parse(dateToParse);
    return "${date.day}/${date.month}/${date.year}";
  } else {
    return "";
  }
}

String getCountryName({required int countryId,required List<Country> countries}){
  String countryName = "";
  var country = countries.where((element) => element.id == countryId).toList();
  if(country.isNotEmpty){
    countryName = country[0].countryName!;
  }
  return countryName;
}