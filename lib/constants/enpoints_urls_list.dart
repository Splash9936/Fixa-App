import '../app_config.dart';

class Enpoints {
  /// *********** base_endpoint**************************/
  // static String baseUrl = AppConfig.instance.appValues!.baseUrl;
  // static const String baseUrl = "https://api.fixarwanda.com";
  static  String baseUrl = AppConfig.instance.appValues!.baseUrl!;
  // static const String baseUrl = "http://192.168.1.83:1337";
//
  // login_endpoint
  static String loginEndpoint = "$baseUrl/auth/local";
  // change Password endpoint
  static String changePasswordEndpoint = "$baseUrl/corporate/change-password";

  // project_enpoint
  static String projectEnpoint = "$baseUrl/projects/app/user";

  // forgot_password
  static String forgotPasswordEnpoint = "$baseUrl/auth/forgot-password";

  // district
  static String districtEnpoint = "$baseUrl/districts";
  //countries
  static String countriesEnpoint = "$baseUrl/countries";

  // payroll_attendance_range
  static String attendanceRangeEnpoint = "$baseUrl/attendance-pages/app";

  // payroll
  // static String payrollEnpoint = "$baseUrl/payrolls";
  // worker payroll enpoint
  static String payrollWorkersEnpoint =
      "$baseUrl/app/attendance-details/mobile_range";
  // payroll summary
  static String payrollSummaryEnpoint = "$baseUrl/app/payroll-details/summary";

  // workers assigned enpoint
  static String assignedWorkersEnpoint =
      "$baseUrl/new-assigned-workers/app-assigned-workers";

  // new record - attendance -url
  static String recordAttendanceEnpoint = "$baseUrl/app/new-attendances/do";

  // view attendance
  static String viewAttendanceEnpoint =
      "$baseUrl/app/attendance-details/mobile";

  // worker profile info
  static String workerProfileInfoEnpoint = "$baseUrl/worker/app/info";
  // assessment endpoints
  // static String assessmentEnpoint = "$baseUrl/assessments";
  static String assessmentEnpoint = "$baseUrl/assessments";
  //  worker assessment endpoints
  static String workerAssessmentEnpoint = "$baseUrl/custom/workers-assessments";

  static String workerHistoryEnpoint = "$baseUrl/worker/app/working_history";
  // worker payroll History endpoind
  static String workerHistoryPayrollEnpoint =
      "$baseUrl/app/payroll-details/worker/payment/history";

  // send sms api
  static String sendSmsEnpoint = "$baseUrl/worker/app/sms";

  // verify worker endpoint
  static String verifyWorkerEnpoint = "$baseUrl/service-providers/app/verify";

  // workers endpoint
  static String workersEnpoint = "$baseUrl/app/service-providers";

  // user endpoint
  static String usersEnpoint = "$baseUrl/users";

  // get nid information
  static String nidInformationEndpoint = "$baseUrl/service-providers/get-nid-information";

  // get attendance statuses
  static String attendanceNotificationEnpoint =
      "$baseUrl/new-attendances/app/notification";

  // attendance remove
  static String removeAttendanceEnpoint = "$baseUrl/app/new-attendances/remove";

  // push auth
  static String pusherAuthEnpoint = "$baseUrl/pusher/auth";

  // half-shift attendance
  static String halfShiftAttendanceEnpoint =
      "$baseUrl/app/attendance-details/half";

  // deduction types
  static String deductionTYpes = "$baseUrl/deduction-types";

  // deduction
  static String deductionInternalAttendance =
      "$baseUrl/deductions/attendance-deduction";
  static String deductionInternalPayroll =
      "$baseUrl/deductions/payroll-internal-deduction";

  static String deductionUrl = "$baseUrl/deductions";
  // // apply deduction
  // static String deductionEnpoint = "$baseUrl/deductions/app";
  // // apply deduction to many
  static String deductionManyEnpoint = "$baseUrl/deductions/app/many";
  // // deduction worker range
  // static String deductionWorkerRangeEnpoint = "$baseUrl/deductions/worker";

  // deductions
  static String getAttendanceDeduction = "$baseUrl/deductions/mobile_deduction";
  static String getPayrollDeduction = "$baseUrl/deductions/payroll_deduction";

  // users endpoint
  static String userEndpoint = "$baseUrl/users";
  // payments endpoints
  static String paymentTypeEndpoint = "$baseUrl/payment-types";
  static String paymentEndpoint = "$baseUrl/payments";
  static String payrollTransactionsEndpoint = "$baseUrl/payroll-transactions";
  static String payrollTransactionsShiftsEndpoint =
      "$baseUrl/payroll-transactions/attendance_shifts";
  static String payoutTransactionsEndpoint = "$baseUrl/payout-transactions";


  // // job or project _endpoint
  // // static String jobEndpoint = "$baseUrl/jobs";
  // static String jobSummaryEndpoint = "$baseUrl/jobs/app/home";
  // static String workerEnpoint = "$baseUrl/service-providers";
  // static String workerUpdateEnpoint = "$baseUrl/service-providers/";
  // static String attendanceEnpoint =
  //     "$baseUrl/attendances/app/record-attendance";
  // static String attendanceOldEnpoint = "$baseUrl/attendances";
  // static String attendanceViewEnpoint = "$baseUrl/attendances/app";
  // static String workerAssignedEnpoint = "$baseUrl/assigned-workers";

  // // deduction types endpoint
  // static String deductionTYpes = "$baseUrl/deduction-types";
  // static String deductions = "$baseUrl/deductions";
  // // deduction endpoints
  // static String deductionsEnpoint = "$baseUrl/app/payroll-details/deduct";
  // // payroll_enpoints
  // static String payrollsEnpoint = "$baseUrl/payrolls";
  // // assessment endpoints
  // static String assessmentEnpoint = "$baseUrl/assessments";
  // //  worker assessment endpoints
  // static String workerAssessmentEnpoint = "$baseUrl/workers-assessments";
}
