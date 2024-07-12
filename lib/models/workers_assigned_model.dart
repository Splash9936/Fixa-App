class AssignedWorkers {
  int? id;
  int? assignedWorkerId;
  int? workerId;
  int? projectId;
  String? firstName;
  String? district;
  String? lastName;
  String? isVerified;
  String? phoneNumber;
  String? gender;
  String? nidNumber;
  String? rates;
  String? services;
  String? countryId;
  String? phoneNumbers;
  String? phoneNumbersMasked;
  String? dateOfBirth;

  AssignedWorkers({
    this.id,
    this.assignedWorkerId,
    this.workerId,
    this.projectId,
    this.firstName,
    this.district,
    this.isVerified,
    this.gender,
    this.lastName,
    this.phoneNumber,
    this.nidNumber,
    this.rates,
    this.services,
    this.countryId,
    this.phoneNumbers,
    this.phoneNumbersMasked,
    this.dateOfBirth,
  });

  AssignedWorkers.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    assignedWorkerId = json['assigned_worker_id'] ?? 0;
    workerId = json['worker_id'] ?? 0;
    projectId = json['project_id'] ?? 0;
    firstName = json['first_name'] ?? 'no';
    isVerified = json["is_verified"] ?? "false";
    district = json['district'] ?? 'no';
    gender = json['gender'] ?? 'no';
    lastName = json['last_name'] ?? 'no';
    phoneNumber = json['phone_number'] ?? 'no';
    nidNumber = json['nid_number'] ?? 'no';
    rates = json['rates'] ?? '';
    services = json['services'] ?? '';
    countryId = json['country_id'] ?? '';
    phoneNumbers = json['phone_numbers'] ?? '';
    phoneNumbersMasked = json['phone_numbers_masked'] ?? '';
    dateOfBirth = json['date_of_birth'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assigned_worker_id'] = assignedWorkerId;
    data['worker_id'] = workerId;
    data['project_id'] = projectId;
    data['first_name'] = firstName;
    data['district'] = district;
    data['is_verified'] = isVerified;
    data['gender'] = gender;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    data['nid_number'] = nidNumber;
    data['rates'] = rates;
    data['services'] = services;
    data['country_id'] = countryId;
    data['phone_numbers'] = phoneNumbers;
    data['phone_numbers_masked'] = phoneNumbersMasked;
    data['date_of_birth'] = dateOfBirth;

    return data;
  }
}
