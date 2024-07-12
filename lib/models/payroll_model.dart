class Payroll {
  int? id;
  String? dateRange;
  String? startDate;
  String? endDate;
  String? year;

  Payroll({this.id, this.dateRange, this.startDate, this.endDate, this.year});

  Payroll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateRange = json['date_range'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date_range'] = dateRange;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['year'] = year;
    return data;
  }
}

class PayrollHistory {
  int? payrollId;
  Meta? meta;
  List<TablePayroll>? table;

  PayrollHistory({this.payrollId, this.meta, this.table});

  PayrollHistory.fromJson(Map<String, dynamic> json) {
    payrollId = json['payroll_id'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['table'] != null) {
      table = <TablePayroll>[];
      json['table'].forEach((v) {
        table!.add(TablePayroll.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payroll_id'] = payrollId;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (table != null) {
      data['table'] = table!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  String? date;
  int? totalShifts;
  int? successfulTransactions;
  int? failedTransactions;
  int? totalWorkers;
  int? amountDue;
  int? projectId;

  Meta(
      {this.date,
      this.totalShifts,
      this.successfulTransactions,
      this.failedTransactions,
      this.totalWorkers,
      this.amountDue,
      this.projectId});

  Meta.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    totalShifts = json['total_shifts'];
    successfulTransactions = json['successful_transactions'];
    failedTransactions = json['failed_transactions'];
    totalWorkers = json['total_workers'];
    amountDue = json['amount_due'];
    projectId = json['project_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['total_shifts'] = totalShifts;
    data['successful_transactions'] = successfulTransactions;
    data['failed_transactions'] = failedTransactions;
    data['total_workers'] = totalWorkers;
    data['amount_due'] = amountDue;
    data['project_id'] = projectId;
    return data;
  }
}

class TablePayroll {
  int? id;
  String? workerName;
  String? workerPhoneNumber;
  bool? onHold;
  int? takeHome;
  int? workerId;
  int? totalShifts;
  String? totalDeductions;
  String? totalEarnings;
  bool? momo;
  int? assignedWorkerId;
  int? additions;
  String? transactionStatus;
  List<Extra>? extra;
  List<WorkerDays>? workedDays;

  TablePayroll(
      {this.id,
      this.workerName,
      this.workerPhoneNumber,
      this.onHold,
      this.takeHome,
      this.workerId,
      this.totalShifts,
      this.totalDeductions,
      this.totalEarnings,
      this.momo,
      this.assignedWorkerId,
      this.additions,
      this.transactionStatus,
      this.extra,
      this.workedDays});

  TablePayroll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workerName = json['worker_name'];
    workerPhoneNumber = json['worker_phone_number'];
    onHold = json['on_hold'];
    takeHome = json['take_home'];
    workerId = json['worker_id'];
    totalShifts = json['total_shifts'];
    totalDeductions = json['total_deductions'];
    totalEarnings = json['total_earnings'];
    momo = json['momo'];
    assignedWorkerId = json['assigned_worker_id'];

    additions = json['additions'];
    transactionStatus = json['transaction_status'];
    if (json['extra'] != null) {
      extra = <Extra>[];
      json['extra'].forEach((v) {
        extra!.add(Extra.fromJson(v));
      });
    }

    if (json['worker_days_worked'] != null) {
      workedDays = <WorkerDays>[];
      json['worker_days_worked'].forEach((v) {
        workedDays!.add(WorkerDays.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['worker_name'] = workerName;
    data['worker_phone_number'] = workerPhoneNumber;
    data['on_hold'] = onHold;
    data['take_home'] = takeHome;
    data['total_shifts'] = totalShifts;
    data['worker_id'] = workerId;
    data['total_deductions'] = totalDeductions;
    data['total_earnings'] = totalEarnings;
    data['momo'] = momo;
    data['assigned_worker_id'] = assignedWorkerId;
    data['additions'] = additions;
    data['transaction_status'] = transactionStatus;
    if (extra != null) {
      data['extra'] = extra!.map((v) => v.toJson()).toList();
    }

    if (workedDays != null) {
      data['worker_days_worked'] = workedDays!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkerDays {
  int? count;
  String? shift;

  WorkerDays({this.count, this.shift});

  WorkerDays.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    shift = json['shift'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['shift'] = shift;
    return data;
  }
}

class Extra {
  int? level;
  int? serviceId;
  String? serviceName;
  int? dailyRate;
  int? daysWorked;

  Extra(
      {this.level,
      this.serviceId,
      this.serviceName,
      this.dailyRate,
      this.daysWorked});

  Extra.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    dailyRate = json['daily_rate'];
    daysWorked = json['days_worked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['level'] = level;
    data['service_id'] = serviceId;
    data['service_name'] = serviceName;
    data['daily_rate'] = dailyRate;
    data['days_worked'] = daysWorked;
    return data;
  }
}

class PayrollRangeFrame {
  String? date;
  List<PayrollFrame>? payrollFrames;
  PayrollRangeFrame({this.date, this.payrollFrames});
}

class PayrollFrame {
  String dateStart;
  String dateEnd;
  PayrollFrame({required this.dateEnd, required this.dateStart});
}

class WorkerHistory {
  Statistics? statistics;
  List<History>? history;

  WorkerHistory({this.statistics, this.history});

  WorkerHistory.fromJson(Map<String, dynamic> json) {
    statistics = json['statistics'] != null
        ? Statistics.fromJson(json['statistics'])
        : null;
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (statistics != null) {
      data['statistics'] = statistics!.toJson();
    }
    if (history != null) {
      data['history'] = history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statistics {
  List<Shift>? shift;
  int? project;
  double? totalDeduction;
  double? totalEarnings;

  Statistics(
      {this.shift, this.project, this.totalDeduction, this.totalEarnings});

  Statistics.fromJson(Map<String, dynamic> json) {
    if (json['shift'] != null) {
      shift = <Shift>[];
      json['shift'].forEach((v) {
        shift!.add(Shift.fromJson(v));
      });
    }
    project = json['project'];
    totalDeduction = json['total_deduction']!=null ?double.parse(json['total_deduction'].toString()) : 0.0;
    totalEarnings = json['total_earnings']!=null ? double.parse(json['total_earnings'].toString()): 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shift != null) {
      data['shift'] = shift!.map((v) => v.toJson()).toList();
    }
    data['project'] = project;
    data['total_deduction'] = totalDeduction;
    data['total_earnings'] = totalEarnings;
    return data;
  }
}

class Shift {
  double? day;
  double? night;

  Shift({this.day, this.night});

  Shift.fromJson(Map<String, dynamic> json) {
    day = json['day']!=null ?double.parse(json['day'].toString()):0.0;
    night = json['night'] !=null ? double.parse(json['night'].toString()): 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['night'] = night;
    return data;
  }
}

class History {
  String? date;
  ProjectPayroll? project;
  ProjectPayroll? supervisor;
  ProjectPayroll? shift;
  ProjectPayroll? service;
  double? dailyEarnings;

  History(
      {this.date,
      this.project,
      this.supervisor,
      this.shift,
      this.service,
      this.dailyEarnings});

  History.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    project = json['project'] != null
        ? ProjectPayroll.fromJson(json['project'])
        : null;
    supervisor = json['supervisor'] != null
        ? ProjectPayroll.fromJson(json['supervisor'])
        : null;
    shift =
        json['shift'] != null ? ProjectPayroll.fromJson(json['shift']) : null;
    service = json['service'] != null
        ? ProjectPayroll.fromJson(json['service'])
        : null;
    dailyEarnings = json['daily_earnings'] !=null ?double.parse(json['daily_earnings'].toString()) : 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    if (project != null) {
      data['project'] = project!.toJson();
    }
    if (supervisor != null) {
      data['supervisor'] = supervisor!.toJson();
    }
    if (shift != null) {
      data['shift'] = shift!.toJson();
    }
    if (service != null) {
      data['service'] = service!.toJson();
    }
    data['daily_earnings'] = dailyEarnings;
    return data;
  }
}

class ProjectPayroll {
  int? id;
  String? name;

  ProjectPayroll({this.id, this.name});

  ProjectPayroll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class WorkerPayroll {
  int? attendanceDetailId;
  String? attendanceDate;
  String? serviceName;
  String? attendanceShift;
  int? attendanceDailyRate;

  WorkerPayroll(
      {this.attendanceDetailId,
      this.attendanceDate,
      this.serviceName,
      this.attendanceShift,
      this.attendanceDailyRate});

  WorkerPayroll.fromJson(Map<String, dynamic> json) {
    attendanceDetailId = json['attendance_detail_id'];
    attendanceDate = json['attendance_date'];
    serviceName = json['service_name'];
    attendanceShift = json['attendance_shift'];
    attendanceDailyRate = json['attendance_daily_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attendance_detail_id'] = attendanceDetailId;
    data['attendance_date'] = attendanceDate;
    data['service_name'] = serviceName;
    data['attendance_shift'] = attendanceShift;
    data['attendance_daily_rate'] = attendanceDailyRate;
    return data;
  }
}

class PayrollWorkers {
  int? totalAmount;
  double? dailyRate;
  String? phoneNumber;
  int? workerId;
  String? serviceName;
  int? serviceId;
  double? dayShifts;
  double? nightShifts;
  String? firstName;
  String? lastName;

  PayrollWorkers(
      {this.totalAmount,
      this.dailyRate,
      this.phoneNumber,
      this.workerId,
      this.serviceName,
      this.serviceId,
      this.dayShifts,
      this.nightShifts,
      this.firstName,
      this.lastName});

  PayrollWorkers.fromJson(Map<String, dynamic> json) {
    totalAmount = json['total_amount'];
    dailyRate = json['daily_rate'] !=null ? double.parse(json['daily_rate'].toString()) :0.0;
    phoneNumber = json['phone_number'] ?? "0";
    workerId = json['worker_id'];
    serviceName = json['service_name'];
    serviceId = json['service_id'];
    dayShifts = json['day_shifts'] !=null ? double.parse(json['day_shifts'].toString()): 0.0;
    nightShifts = json['night_shifts'] !=null ?double.parse(json['night_shifts'].toString()):0.0;
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_amount'] = totalAmount;
    data['daily_rate'] = dailyRate;
    data['phone_number'] = phoneNumber;
    data['worker_id'] = workerId;
    data['service_name'] = serviceName;
    data['service_id'] = serviceId;
    data['day_shifts'] = dayShifts;
    data['night_shifts'] = nightShifts;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
