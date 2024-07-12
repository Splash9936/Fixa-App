// ignore_for_file: unnecessary_new, prefer_collection_literals

class WorkerProfile {
  WorkerInformation? workerInformation;
  WorkerDetails? workerDetails;

  WorkerProfile({this.workerInformation, this.workerDetails});

  WorkerProfile.fromJson(Map<String, dynamic> json) {
    workerInformation = json['worker_information'] != null
        ? WorkerInformation.fromJson(json['worker_information'])
        : null;
    workerDetails = json['worker_details'] != null
        ? WorkerDetails.fromJson(json['worker_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (workerInformation != null) {
      data['worker_information'] = workerInformation!.toJson();
    }
    if (workerDetails != null) {
      data['worker_details'] = workerDetails!.toJson();
    }
    return data;
  }
}

class WorkerInformation {
  String? workerProfileImageUrl;
  List<WorkerInfo>? worker;
  List<ServicesInfo>? services;
  WorkerRates? workerRates;
  // List<WorkerRates>? workerRates;
  List<AssessmentResult>? assessments;
  Verification? verification;
  String? lastAttendance;
  String? dateOnboarded;

  WorkerInformation(
      {this.workerProfileImageUrl,
      this.worker,
      this.services,
      this.workerRates,
      this.assessments,
      this.verification,
      this.lastAttendance,
      this.dateOnboarded});

  WorkerInformation.fromJson(Map<String, dynamic> json) {
    workerProfileImageUrl = json['worker_profile_image_url'] ?? "";
    if (json['worker'] != null) {
      worker = <WorkerInfo>[];
      json['worker'].forEach((v) {
        worker!.add(WorkerInfo.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <ServicesInfo>[];
      json['services'].forEach((v) {
        services!.add(ServicesInfo.fromJson(v));
      });
    }
    workerRates = json['worker_rates'] != null
        ? new WorkerRates.fromJson(json['worker_rates'])
        : null;
    // if (json['worker_rates'] != null) {
    //   workerRates = <WorkerRates>[];
    //   json['worker_rates'].forEach((v) {
    //     workerRates!.add(WorkerRates.fromJson(v));
    //   });
    // }
    if (json['assessments'] != null) {
      assessments = <AssessmentResult>[];
      json['assessments'].forEach((v) {
        assessments!.add(AssessmentResult.fromJson(v));
      });
    }
    verification = json['verification'] != null
        ? Verification.fromJson(json['verification'])
        : null;

    lastAttendance = json['last_attendance'];
    dateOnboarded = json['date_onboarded'] ?? "no";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['worker_profile_image_url'] = workerProfileImageUrl;
    if (worker != null) {
      data['worker'] = worker!.map((v) => v.toJson()).toList();
    }
    if (workerRates != null) {
      data['worker_rates'] = workerRates!.toJson();
    }
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (verification != null) {
      data['verification'] = verification!.toJson();
    }
    data['last_attendance'] = lastAttendance;
    data['date_onboarded'] = dateOnboarded;
    return data;
  }
}

class AssessmentResult {
  int? level;
  String? assessmentResult;

  AssessmentResult({this.level, this.assessmentResult});

  AssessmentResult.fromJson(Map<String, dynamic> json) {
    level = json['level'] ?? 0;
    assessmentResult = json['rate'] ?? "no";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['level'] = level;
    data['rate'] = assessmentResult;

    return data;
  }
}

class WorkerInfo {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? nidNumber;
  String? rssbCode;
  String? gender;
  String? dateOfBirth;
  String? province;
  String? district;
  String? sector;
  bool? isVerified;
  bool? isActive;

  WorkerInfo(
      {this.firstName,
      this.lastName,
      this.phoneNumber,
      this.nidNumber,
      this.rssbCode,
      this.gender,
      this.dateOfBirth,
      this.province,
      this.district,
      this.sector,
      this.isVerified,
      this.isActive});

  WorkerInfo.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'] ?? "No firstname";
    lastName = json['last_name'] ?? "No lastname";
    phoneNumber = json['phone_number'] ?? "-";
    nidNumber = json['nid_number'] ?? "-";
    rssbCode = json['rssb_code'] ?? "-";
    gender = json['gender'] ?? "-";
    dateOfBirth = json['date_of_birth'] ?? "-";
    province = json['province'] ?? "-";
    district = json['district'] ?? "-";
    sector = json['sector'] ?? "-";
    isVerified = json['is_verified'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    data['nid_number'] = nidNumber;
    data['rssb_code'] = rssbCode;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['province'] = province;
    data['district'] = district;
    data['sector'] = sector;
    data['is_verified'] = isVerified;
    data['is_active'] = isActive;
    return data;
  }
}

class ServicesInfo {
  int? serviceId;
  String? name;

  ServicesInfo({this.serviceId, this.name});

  ServicesInfo.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_id'] = serviceId;
    data['name'] = name;
    return data;
  }
}

// class WorkerRates {
//   int? serviceId;
//   String? serviceName;
//   int? value;

//   WorkerRates({this.serviceId, this.serviceName, this.value});

//   WorkerRates.fromJson(Map<String, dynamic> json) {
//     serviceId = json['service_id'] ?? 0;
//     serviceName = json['name'] ?? "-";
//     value = json['value'] ?? 0;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['service_id'] = serviceId;
//     data['name'] = serviceName;
//     data['value'] = value;
//     return data;
//   }
// }

class WorkerRates {
  Current? current;
  List<All>? all;

  WorkerRates({this.current, this.all});

  WorkerRates.fromJson(Map<String, dynamic> json) {
    current =
        json['current'] != null ? new Current.fromJson(json['current']) : null;
    if (json['all'] != null) {
      all = <All>[];
      json['all'].forEach((v) {
        all!.add(new All.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (current != null) {
      data['current'] = current!.toJson();
    }
    if (all != null) {
      data['all'] = all!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Current {
  int? id;
  int? assignedWorkerId;
  int? serviceId;
  int? value;
  String? serviceName;

  Current(
      {this.id,
      this.assignedWorkerId,
      this.serviceId,
      this.value,
      this.serviceName});

  Current.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assignedWorkerId = json['assigned_worker_id'];
    serviceId = json['service_id'];
    value = json['value'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['assigned_worker_id'] = assignedWorkerId;
    data['service_id'] = serviceId;
    data['value'] = value;
    data['service_name'] = serviceName;
    return data;
  }
}

class All {
  int? id;
  int? assignedWorkerId;
  int? serviceId;
  int? value;
  String? serviceName;

  All(
      {this.id,
      this.assignedWorkerId,
      this.serviceId,
      this.value,
      this.serviceName});

  All.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assignedWorkerId = json['assigned_worker_id'];
    serviceId = json['service_id'];
    value = json['value'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['assigned_worker_id'] = assignedWorkerId;
    data['service_id'] = serviceId;
    data['value'] = value;
    data['service_name'] = serviceName;
    return data;
  }
}

class Verification {
  bool? phoneNumberIsVerified;
  bool? workerIsVerified;
  bool? isWorkerActive;

  Verification(
      {this.phoneNumberIsVerified, this.workerIsVerified, this.isWorkerActive});

  Verification.fromJson(Map<String, dynamic> json) {
    phoneNumberIsVerified = json['phone_number_is_verified'] ?? false;
    workerIsVerified = json['worker_is_verified'] ?? false;
    isWorkerActive = json['is_worker_active'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone_number_is_verified'] = phoneNumberIsVerified;
    data['worker_is_verified'] = workerIsVerified;
    data['is_worker_active'] = isWorkerActive;
    return data;
  }
}

class WorkerDetails {
  List<WorkerInfo>? worker;
  List<NextOfKin>? nextOfKin;
  List<Certificates>? certificates;

  WorkerDetails({this.worker, this.nextOfKin, this.certificates});

  WorkerDetails.fromJson(Map<String, dynamic> json) {
    if (json['worker'] != null) {
      worker = <WorkerInfo>[];
      json['worker'].forEach((v) {
        worker!.add(WorkerInfo.fromJson(v));
      });
    }
    if (json['next_of_kin'] != null) {
      nextOfKin = <NextOfKin>[];
      json['next_of_kin'].forEach((v) {
        nextOfKin!.add(NextOfKin.fromJson(v));
      });
    }
    if (json['certificates'] != null) {
      certificates = <Certificates>[];
      json['certificates'].forEach((v) {
        certificates!.add(Certificates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (worker != null) {
      data['worker'] = worker!.map((v) => v.toJson()).toList();
    }
    if (nextOfKin != null) {
      data['next_of_kin'] = nextOfKin!.map((v) => v.toJson()).toList();
    }
    if (certificates != null) {
      data['certificates'] = certificates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NextOfKin {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  int? workerId;

  NextOfKin(
      {this.id,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.workerId});

  NextOfKin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'] ?? "-";
    lastName = json['last_name'] ?? "-";
    phoneNumber = json['phone_number'] ?? "-";
    workerId = json['worker_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    data['worker_id'] = workerId;
    return data;
  }
}

class Certificates {
  int? id;
  String? schoolName;
  String? field;
  String? startDate;
  String? endDate;
  String? level;
  int? workerId;

  Certificates(
      {this.id,
      this.schoolName,
      this.field,
      this.startDate,
      this.endDate,
      this.level,
      this.workerId});

  Certificates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolName = json['school_name'] ?? "-";
    field = json['field'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    level = json['level'] ?? "-";
    workerId = json['worker_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['school_name'] = schoolName;
    data['field'] = field;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['level'] = level;
    data['worker_id'] = workerId;
    return data;
  }
}
