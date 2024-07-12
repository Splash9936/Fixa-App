class IdVerificationData {
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  List<PhoneNumbers>? phoneNumbers;

  IdVerificationData(
      {this.firstName, this.lastName, this.dateOfBirth, this.phoneNumbers});

  IdVerificationData.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    dateOfBirth = json['dateOfBirth'];
    if (json['phoneNumbers'] != null) {
      phoneNumbers = <PhoneNumbers>[];
      json['phoneNumbers'].forEach((v) {
        phoneNumbers!.add(PhoneNumbers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['dateOfBirth'] = dateOfBirth;
    if (phoneNumbers != null) {
      data['phoneNumbers'] = phoneNumbers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PhoneNumbers {
  String? id;
  String? phoneNumber;

  PhoneNumbers({this.id, this.phoneNumber});

  PhoneNumbers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
