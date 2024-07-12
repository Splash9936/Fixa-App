class AttendanceRecordedWorkers {
  int? id;
  int? assignedWorkerId;
  int? workerId;
  int? projectId;
  String? firstName;
  String? district;
  String? lastName;
  String? phoneNumber;
  String? nidNumber;
  String? rates;
  int? serviceId;

  AttendanceRecordedWorkers(
      {this.id,
      this.assignedWorkerId,
      this.workerId,
      this.projectId,
      this.firstName,
      this.district,
      this.lastName,
      this.phoneNumber,
      this.nidNumber,
      this.rates,
      this.serviceId});

  AttendanceRecordedWorkers.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    assignedWorkerId = json['assigned_worker_id'] ?? 0;
    workerId = json['worker_id'] ?? 0;
    projectId = json['project_id'] ?? 0;
    firstName = json['first_name'] ?? 'no';
    district = json['district'] ?? 'no';
    lastName = json['last_name'] ?? 'no';
    phoneNumber = json['phone_number'] ?? 'no';
    nidNumber = json['nid_number'] ?? 'no';
    rates = json['rates'] ?? '';
    serviceId = json['service_id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assigned_worker_id'] = assignedWorkerId;
    data['worker_id'] = workerId;
    data['project_id'] = projectId;
    data['first_name'] = firstName;
    data['district'] = district;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    data['nid_number'] = nidNumber;
    data['rates'] = rates;
    data['service_id'] = serviceId;
    return data;
  }
}
