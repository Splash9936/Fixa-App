// ignore_for_file: prefer_const_constructors

import 'package:fixa/fixa_main_routes.dart';

class AppRouter {
  static final pages = [
    GetPage(
        binding: WrapperBindings(),
        name: RouteLinks.wrapper,
        page: () => Wrapper()),
    GetPage(
        binding: HomeWorkerProfileBindings(),
        name: RouteLinks.homeWorkerProfile,
        page: () => HomeWorkerProfile(
            workerId: Get.arguments["worker_id"],
            workerName: Get.arguments['worker_name'],
            assignedWorkerId: Get.arguments["assigned_worker_id"],
            project: Get.arguments["project"])),
    GetPage(
        binding: LoginBindings(),
        name: RouteLinks.login,
        page: () => HomeLogin()),
    GetPage(
        binding: ForgetPasswordBindings(),
        name: RouteLinks.recoverPasswordEmail,
        page: () => HomeRecoverPasswordEmail()),
    GetPage(
        name: RouteLinks.recoverPassword, page: () => HomeRecoverByPassword()),
    GetPage(
        binding: HomeEditUserProfileBindings(),
        name: RouteLinks.homeEditUserProfile,
        page: () => HomeEditUserProfile(
              userInfo: Get.arguments["user_info"],
            )),
    GetPage(
        binding: HomeDashboardBindings(),
        name: RouteLinks.homeDashboard,
        page: () => HomeDashBoard()),
    GetPage(
        // binding: HomeDashboardBindings(),
        name: RouteLinks.homeUserProfile,
        page: () => HomeUserProfile()),
    GetPage(
        binding: HomeRegisterWorkerBindings(),
        name: RouteLinks.homeRegisterWorker,
        page: () => HomeRegisterWorker(
            project: Get.arguments["project"],
            selectedService: Get.arguments["selectedService"])),
    GetPage(
        binding: HomeRegisterWorkerBindings(),
        name: RouteLinks.homeRegisterWorkerSaas,
        page: () => HomeRegisterWorkerSaas(
            project: Get.arguments["project"],
            selectedService: Get.arguments["selectedService"])),
    GetPage(
        binding: HomeWorkerPayrollBindings(),
        name: RouteLinks.homeWorkerPayroll,
        page: () => HomeWorkerPayroll(
            payrollTransaction: Get.arguments["payrollTransaction"],
            projectId: Get.arguments["project_id"])),
    GetPage(
        binding: HomeWorkerSearchBindings(),
        name: RouteLinks.homeSearchWorker,
        page: () => HomeSearchWorker(
              project: Get.arguments["project"],
              assignedWorkers: Get.arguments["assigned_workers"],
            )),
    GetPage(
        name: RouteLinks.homeViewAttendance,
        page: () => HomeAttendance(
              project: Get.arguments["project"],
              statusNavigator: Get.arguments["status"],
            )),
    GetPage(
        name: RouteLinks.homeMainPayroll,
        page: () => HomePayroll(
              project: Get.arguments["project"],
              statusNavigator: Get.arguments["status"],
            )),
    GetPage(
        name: RouteLinks.homeWorkForceData,
        page: () => WorforceBody(
            project: Get.arguments["project"],
            statusNavigator: Get.arguments["status"])),
    GetPage(
        binding: HomePayrollDetailsBindings(),
        name: RouteLinks.homePayrollDetails,
        page: () => HomePayrollDetails(
            paymentType: Get.arguments["payment_type"],
            project: Get.arguments["project"],
            payment: Get.arguments["payment"])),
    GetPage(
        binding: HomeRecordAttendanceBindings(),
        name: RouteLinks.homeRecordAttendance,
        page: () => HomeRecordAttendance(
              project: Get.arguments["project"],
              selectedService: Get.arguments["service"],
              time: Get.arguments["time"],
              shiftId: Get.arguments["shiftId"],
              workesAttendance: Get.arguments["workers"],
            )),
    GetPage(
        binding: HomeWorkerAssessmentsBindings(),
        name: RouteLinks.homeWorkerAssessment,
        page: () => HomeNewAssessment(
              workerFullName: Get.arguments["workerFullName"],
              assignedWorkerId: Get.arguments["assignedWorkerId"],
              workerId: Get.arguments["worker_id"],
              serviceId: Get.arguments["service_id"],
              projectId: Get.arguments["project_id"],
              attendance: Get.arguments["status"],
            )
        // page: () => HomeAssessWorker(
        //     workerId: Get.arguments["worker_id"],
        //     assignWorkerId: Get.arguments["assign_worker_id"],
        //     project: Get.arguments["project"],
        //     workerFullName: Get.arguments["workerFullName"],
        //     assessmentLevel: Get.arguments["level"])
        ),
    GetPage(
        binding: HomeEditWorkerProfileBindings(),
        name: RouteLinks.homeEditWorkerProfile,
        page: () => HomeEditWorkerProfile(
              project: Get.arguments["project"],
              rssbCode: Get.arguments["rssb_code"],
              gender: Get.arguments["gender"],
              workerId: Get.arguments["worker_id"],
              assignedWorkerId: Get.arguments["assign_worker_id"],
              districtName: Get.arguments["district_name"] ?? "",
              firstName: Get.arguments["first_name"],
              lastName: Get.arguments["last_name"],
              idNUmber: Get.arguments["id_number"],
              phoneNUmber: Get.arguments["phone_number"],
              currentRate: Get.arguments["current_rate"],
              currentService: Get.arguments["current_service"],
              workerRates: Get.arguments["worker_rates"],
            )),
  ];
}
