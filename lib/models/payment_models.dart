class Payments {
  int? id;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? totalPayees;
  String? paymentTypesId;
  String? projectId;
  String? description;
  String? addedOn;
  String? startDate;
  String? endDate;
  int? doneBy;
  String? totalAmount;
  String? title;
  String? projectName;
  String? doneByName;
  String? paymentTypeName;
  int? totalToBeDisbursed;

  Payments(
      {this.id,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.totalPayees,
      this.paymentTypesId,
      this.projectId,
      this.description,
      this.addedOn,
      this.startDate,
      this.endDate,
      this.doneBy,
      this.totalAmount,
      this.title,
      this.projectName,
      this.doneByName,
      this.paymentTypeName,
      this.totalToBeDisbursed});

  Payments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalPayees = json['total_payees'];
    paymentTypesId = json['payment_types_id'];
    projectId = json['project_id'];
    description = json['description'];
    addedOn = json['added_on'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    doneBy = json['done_by'];
    totalAmount = json['total_amount'];
    title = json['title'];
    projectName = json['project_name'];
    doneByName = json['done_by_name'];
    paymentTypeName = json['payment_type_name'];
    totalToBeDisbursed = json['total_to_be_disbursed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['total_payees'] = totalPayees;
    data['payment_types_id'] = paymentTypesId;
    data['project_id'] = projectId;
    data['description'] = description;
    data['added_on'] = addedOn;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['done_by'] = doneBy;
    data['total_amount'] = totalAmount;
    data['title'] = title;
    data['project_name'] = projectName;
    data['done_by_name'] = doneByName;
    data['payment_type_name'] = paymentTypeName;
    data['total_to_be_disbursed'] = totalToBeDisbursed;
    return data;
  }
}

class PaymentsType {
  int? id;
  String? typeName;
  String? description;

  PaymentsType({this.id, this.typeName, this.description});

  PaymentsType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['type_name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type_name'] = typeName;
    data['description'] = description;
    return data;
  }
}

class PayrollTransactions {
  int? id;
  String? payeeTypeId;
  String? paymentId;
  String? totalEarnings;
  String? takeHome;
  String? totalDeductions;
  String? status;
  String? phoneNumber;
  double? totalShifts;
  String? assignedWorkerId;
  String? workerName;
  bool? isMomo;
  String? workerId;
  double? dayShifts;
  double? nightShifts;
  String? serviceName;
  String? dailyRate;
  String? createdAt;
  String? updatedAt;
  String? idNumber;

  PayrollTransactions(
      {this.id,
      this.payeeTypeId,
      this.paymentId,
      this.totalEarnings,
      this.takeHome,
      this.totalDeductions,
      this.status,
      this.phoneNumber,
      this.totalShifts,
      this.assignedWorkerId,
      this.workerName,
      this.isMomo,
      this.workerId,
      this.dayShifts,
      this.nightShifts,
      this.serviceName,
      this.dailyRate,
      this.createdAt,
      this.updatedAt,
      this.idNumber});

  PayrollTransactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    payeeTypeId = json['payee_type_id'];
    paymentId = json['payment_id'];
    totalEarnings = json['total_earnings'];
    takeHome = json['take_home'];
    totalDeductions = json['total_deductions'];
    status = json['status'];
    phoneNumber = json['phone_number'] ?? "no-phone number";
    totalShifts = double.parse(json['total_shifts'].toString()) ;
    assignedWorkerId = json['assigned_worker_id'];
    workerName = json['worker_name'];
    isMomo = json['is_momo'];
    workerId = json['worker_id'];
    dayShifts = double.parse(json['day_shifts'].toString());
    nightShifts = double.parse(json['night_shifts'].toString());
    serviceName = json['service_name'];
    dailyRate = json['daily_rate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    idNumber = json['id_number'] ?? "no-id number";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['payee_type_id'] = payeeTypeId;
    data['payment_id'] = paymentId;
    data['total_earnings'] = totalEarnings;
    data['take_home'] = takeHome;
    data['total_deductions'] = totalDeductions;
    data['status'] = status;
    data['phone_number'] = phoneNumber;
    data['total_shifts'] = totalShifts;
    data['assigned_worker_id'] = assignedWorkerId;
    data['worker_name'] = workerName;
    data['is_momo'] = isMomo;
    data['worker_id'] = workerId;
    data['day_shifts'] = dayShifts;
    data['night_shifts'] = nightShifts;
    data['service_name'] = serviceName;
    data['daily_rate'] = dailyRate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['id_number'] = idNumber;
    return data;
  }
}

class PayoutTransactions {
  int? id;
  String? paymentId;
  String? payeeTypeId;
  String? payeeName;
  String? amount;
  String? phoneNumber;
  String? status;
  bool? isMomo;
  String? payeeTypeName;
  String? createdAt;
  String? updatedAt;

  PayoutTransactions(
      {this.id,
      this.paymentId,
      this.payeeTypeId,
      this.payeeName,
      this.amount,
      this.phoneNumber,
      this.status,
      this.isMomo,
      this.payeeTypeName,
      this.createdAt,
      this.updatedAt});

  PayoutTransactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentId = json['payment_id'];
    payeeTypeId = json['payee_type_id'];
    payeeName = json['payee_name'];
    amount = json['amount'];
    phoneNumber = json['phone_number'];
    status = json['status'];
    isMomo = json['is_momo'];
    payeeTypeName = json['payee_type_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['payment_id'] = paymentId;
    data['payee_type_id'] = payeeTypeId;
    data['payee_name'] = payeeName;
    data['amount'] = amount;
    data['phone_number'] = phoneNumber;
    data['status'] = status;
    data['is_momo'] = isMomo;
    data['payee_type_name'] = payeeTypeName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class PayrollAttendance {
  int? id;
  int? attendanceId;
  String? date;
  String? serviceName;
  String? shiftName;
  int? value;

  PayrollAttendance(
      {this.id,
      this.attendanceId,
      this.date,
      this.serviceName,
      this.shiftName,
      this.value});

  PayrollAttendance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attendanceId = json['attendance_id'];
    date = json['date'];
    serviceName = json['service_name'];
    shiftName = json['shift_name'];
    value = json['value'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['attendance_id'] = attendanceId;
    data['date'] = date;
    data['service_name'] = serviceName;
    data['shift_name'] = shiftName;
    data['value'] = value;
    return data;
  }
}
