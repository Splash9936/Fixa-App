//  -----------------***** packages *******---------------
export 'package:flutter/material.dart';
export 'package:get/get.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:flutter_secure_storage/flutter_secure_storage.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:flutter/services.dart';
export 'package:equatable/equatable.dart';
export 'package:localstorage/localstorage.dart';
export 'dart:convert';
export 'package:path/path.dart';
export 'package:path_provider/path_provider.dart';
export 'package:sqflite/sqflite.dart';
export 'package:table_calendar/table_calendar.dart';
export 'package:flutter_rating_bar/flutter_rating_bar.dart';
// export 'package:equatable/equatable.dart';
export 'package:lottie/lottie.dart';

// ------------------******* routes to constants ******--------------
export 'constants/sizeConfig.dart';
export 'constants/colors.dart';
export 'constants/enpoints_urls_list.dart';
export 'constants/theme.dart';
export 'constants/text_styling.dart';
export 'constants/default_button.dart';
export 'constants/images.dart';
export 'constants/app_bar.dart';
export 'constants/buttons.dart';
export 'constants/snack_bar_messages.dart';
export 'constants/loading_lottie.dart';
export 'utils/app_env_values.dart';

// --------------------***** routes to controllers ******-----------
// route naigations
export 'app_route/app_router.dart';
export 'app_route/route_links.dart';

// main controllers
export 'controllers/main_controllers/main_controller.dart';

// worker controllers
export 'controllers/worker_controllers/worker_profile_controller.dart';
export 'controllers/worker_controllers/register_worker_controller.dart';
export 'controllers/worker_controllers/home_worker_force_controller.dart';
export 'controllers/worker_controllers/home_search_controller.dart';
export 'controllers/worker_controllers/edit_worker_profile_controller.dart';

// auth controllers
export 'controllers/auth_controllers/authentication_controller.dart';
export 'controllers/auth_controllers/login_controller.dart';
export 'controllers/auth_controllers/forgot_password_controller.dart';

// home controllers
export 'controllers/home_controllers/home_dashboard_controller.dart';

// attendances controllers
export 'controllers/attendance_controllers/home_attendance_controller.dart';
export 'controllers/attendance_controllers/home_record_attendance_controller.dart';

// payroll controllers
export 'controllers/payroll_controllers/home_payroll_controller.dart';
export 'controllers/payroll_controllers/home_worker_payroll.dart';
export 'controllers/payroll_controllers/home_payroll_details_controller.dart';

//  assessment controllers
export 'controllers/worker_assessments_controller/home_assess_worker_controller.dart';

// profile controllers
export 'controllers/profile_controllers/edit_profile_controller.dart';

// network controllers
export 'controllers/Network_controllers/network_controller.dart';
export 'controllers/Network_controllers/network_state.dart';

// --------------------**** routes to bindings *****-------------
export 'bindings/bindings.dart';

// -----------------**** routes to views *****---------------
// auth routes
export 'views/auth/login/home_login.dart';
export 'views/auth/recover_password/recover_password_email.dart';
export 'views/auth/recover_password/recover_by_password.dart';
export 'views/auth/select_business/home_select_business.dart';

// -------------- home_dashboard ----------
export 'views/home/home_dashboard.dart';
// -------------- home_page ---------------
export 'views/home/home.dart';
// -------------- home_attendance ---------
export 'views/attendance/body_home_attendance/home_main_attendance.dart';
export 'views/attendance/home_attendance.dart';
export 'views/attendance/record_attendance.dart';

// -------------- home user profile ---------
export 'views/profile/home_user_profile.dart';
export 'views/profile/home_edit_user_profile.dart';

// worker routes (worker_profile, register_worker, edit worker profile)
export 'views/worker/home_worker.dart';
export 'views/worker/home_worker_profile_test.dart';
export 'views/worker/home_worker_profile.dart';
export 'views/worker/home_register_worker.dart';
export 'views/worker/body_parts/home_register_worker_saas.dart';
export 'views/worker/home_search_worker.dart';
export 'views/worker/body_parts/work_force_data.dart';
export 'views/worker/edit_worker_profile.dart';
// payroll
export 'views/payroll/home_worker_payroll.dart';
export 'views/payroll/home_payroll.dart';
export 'views/payroll/home_worker_select_project.dart';
export 'views/payroll/home_payroll_details.dart';
// ---------------- worker assessments --------
// export 'views/assessments/home_assess_worker.dart';
export 'views/assessments/home_new_assessment.dart';

// ----------------- services ----------------
export 'services/authentication/authentication_states.dart';
export 'services/authentication/wrapper.dart';
export 'services/api_service/api_handler.dart';
export 'services/data_service/data_provider.dart';
// export 'services/authentication/wrapper.dart';
export 'services/database_service/database_service.dart';

// ----------------- models ------------------
export 'models/user_model.dart';
export 'models/response_model.dart';
export 'models/project_model.dart';
export 'models/workers_assigned_model.dart';
export 'models/location_model.dart';
export 'models/attendance.dart';
export 'models/payroll_model.dart';
export 'models/worker_profile.dart';
export 'models/assessment_model.dart';
export 'models/deduction_models.dart';
export 'models/attendance_recorded_workers_model.dart';
export 'models/payment_models.dart';
export 'models/app_env_models.dart';
export 'models/app_colors.dart';
export 'models/id_verification_data_model.dart';
export 'models/country_model.dart';
// ------------------ UTILS ----------------
export 'utils/utils_arrange_data.dart';
export 'app_config.dart';
