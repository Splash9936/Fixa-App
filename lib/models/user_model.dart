class User {
  String? jwt;
  UserDetails? user;

  User({this.jwt, this.user});

  User.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
    user = json['user'] != null ? UserDetails.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jwt'] = jwt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class UserDetails {
  int? id;
  String? username;
  String? email;
  Role? role;
  bool? blocked;
  String? firstName;
  String? lastName;
  String? country;
  String? district;
  String? phoneNumber;
  String? streetAddress;
  String? companyName;

  UserDetails({
    this.id,
    this.username,
    this.email,
    this.role,
    this.blocked,
    this.firstName,
    this.lastName,
    this.country,
    this.district,
    this.streetAddress,
    this.companyName,
  });

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'] ?? "no username";
    email = json['email'] ?? "no email";
    blocked = json['blocked'] ?? true;
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
    firstName = json['first_name'] ?? "no first name";
    lastName = json['last_name'] ?? "no last name";
    phoneNumber = json['phone_number'] ?? "no phone number";
    country = json['country'];
    district = json['district'];
    streetAddress = json['street_address'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    data['first_name'] = firstName;
    data['blocked'] = blocked;
    data['last_name'] = lastName;
    data['country'] = country;
    data['phone_number'] = phoneNumber;
    data['district'] = district;
    data['street_address'] = streetAddress;
    data['company_name'] = companyName;
    return data;
  }
}

class Role {
  int? id;
  String? name;
  String? description;
  String? type;

  Role({this.id, this.name, this.description, this.type});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['type'] = type;
    return data;
  }
}
