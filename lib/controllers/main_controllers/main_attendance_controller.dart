// import 'package:fixa/fixa_main_routes.dart';
// import 'package:intl/intl.dart';

// class MainAttendanceController extends GetxController {
//   final _dataProvider = DataProvider();
//   RxInt selectedProjectId = 0.obs;
//   RxBool isLoading = false.obs;
//   RxBool shift = false.obs;
//   Rx<DateTime> dateTme = DateTime.now().obs;
//   RxList<WorkerAttendance> attendances = <WorkerAttendance>[].obs;
//   RxList<WorkerAttendance> allAttendances = <WorkerAttendance>[].obs;
//   RxList<WorkerAttendance> allServicesAttendances = <WorkerAttendance>[].obs;
//   List<int> workersAttendandedIds = [];
//   RxInt selectedService = 0.obs;

//   List<int> getWorkersAttendedIds({required List<WorkerAttendance> worrkers}) {
//     List<int> ids = [];
//     for (var item in worrkers) {
//       ids.add(item.assignedWorkerId!);
//     }
//     return ids;
//   }

//   // get attendance by shift
//   List<WorkerAttendance> getAttendanceByShift(
//       {required List<WorkerAttendance> workersAttendance}) {
//     List<WorkerAttendance> responseAttendance = [];
//     if (shift.value) {
//       responseAttendance = workersAttendance
//           .where((item) => item.shiftName!.toLowerCase() == "night")
//           .toList();
//     } else {
//       responseAttendance = workersAttendance
//           .where((item) => item.shiftName!.toLowerCase() == "day")
//           .toList();
//     }

//     return responseAttendance;
//   }

//   getAttendances({required DateTime time, required int projectId}) async {
//     isLoading.value = true;
//     selectedService.value = 0;
//     workersAttendandedIds = [];
//     selectedProjectId.value = projectId;
//     dateTme.value = time;
//     final DateFormat formatter = DateFormat('yyyy-MM-dd');
//     final String formattedDate = formatter.format(time);
//     var response = await _dataProvider.getAttendance(
//         endPoint:
//             "${Enpoints.viewAttendanceEnpoint}?attendance_date=$formattedDate&project_id=$projectId");
//     if (!response.error) {
//       allAttendances.value = response.response!;
//       attendances.value =
//           getAttendanceByShift(workersAttendance: response.response!);
//       allServicesAttendances.value = response.response!;
//       workersAttendandedIds =
//           getWorkersAttendedIds(worrkers: response.response!);
//       isLoading.value = false;
//     } else {
//       negativeMessage(message: response.errorMessage!);
//       isLoading.value = false;
//     }
//   }
// }
