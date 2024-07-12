class WorkerAttendance {
  String? firstname;
  String? lastname;
  String? phone;
  String? service;
  String? attendanceStatus;
  String? idNumber;
  String? shiftStatus;
  String? shiftName;
  bool? isVerified;
  int? assignedWorkerId;
  int? workerRate;
  int? attendanceId;
  int? workerId;
  int? serviceId;
  int? meanScore;

  WorkerAttendance(
      {this.firstname,
      this.lastname,
      this.phone,
      this.service,
      this.attendanceStatus,
      this.idNumber,
      this.isVerified,
      this.shiftStatus,
      this.shiftName,
      this.assignedWorkerId,
      this.workerRate,
      this.attendanceId,
      this.serviceId,
      this.workerId,
      this.meanScore});

  WorkerAttendance.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'] ?? "xxx";
    lastname = json['lastname'] ?? "xxx";
    phone = json['phone'] ?? "0700000000";
    service = json['service'];
    attendanceStatus = json['attendance_status'];
    idNumber = json['nid_number'] ?? '-';
    isVerified = json['is_verified'] ?? false;
    shiftStatus = json['shift_status'];
    shiftName = json['shift_name'];
    assignedWorkerId = json['assigned_worker_id'];
    workerRate = json['rate'] ?? 0 ;
    attendanceId = json['attendance_id'];
    workerId = json['worker_id'];
    serviceId = json['worker_service_id'];
    meanScore = json['mean'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['phone'] = phone;
    data['service'] = service;
    data['attendance_status'] = attendanceStatus;
    data['is_verified'] = isVerified;
    data['shift_status'] = shiftStatus;
    data['shift_name'] = shiftName;
    data['assigned_worker_id'] = assignedWorkerId;
    data['attendanceId'] = attendanceId;
    data['worker_id'] = workerId;
    data['worker_service_id'] = serviceId;
    data['rate'] = workerRate;
    data['mean'] = meanScore;
    return data;
  }
}

class AttendanceStatus {
  int? attendanceId;
  String? shift;
  String? date;
  String? workers;
  String? attendanceStatus;
  String? projectName;

  AttendanceStatus(
      {this.attendanceId,
      this.shift,
      this.date,
      this.workers,
      this.projectName,
      this.attendanceStatus});

  AttendanceStatus.fromJson(Map<String, dynamic> json) {
    attendanceId = json['attendance_id'];
    shift = json['shift'];
    date = json['date'];
    workers = json['workers'];
    projectName = json['project_name'];
    attendanceStatus = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attendance_id'] = attendanceId;
    data['shift'] = shift;
    data['date'] = date;
    data['workers'] = workers;
    data['project_name'] = projectName;
    data['status'] = attendanceStatus;
    return data;
  }
}
