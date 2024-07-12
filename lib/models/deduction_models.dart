import 'package:fixa/fixa_main_routes.dart';

class DeductionTypes {
  int? id;
  String? title;
  bool? isAvailable;
  int? projectId;

  DeductionTypes({this.id, this.title, this.isAvailable, this.projectId});

  DeductionTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isAvailable = json['is_available'];
    projectId = json['project_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['is_available'] = isAvailable;
    data['project_id'] = projectId;
    return data;
  }
}

class DeductionControllers {
  int deductionId;
  int deductionTypeId;
  TextEditingController deductedAmount;
  bool isApplied;

  DeductionControllers(this.deductionId, this.deductionTypeId,
      this.deductedAmount, this.isApplied);
}

class Deductions {
  int? id;
  int? deductionAmount;
  int? deductionTypeId;
  String? title;

  Deductions({this.id, this.deductionAmount, this.deductionTypeId, this.title});

  Deductions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deductionAmount = json['deduction_amount'];
    deductionTypeId = json['deduction_type_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deduction_amount'] = deductionAmount;
    data['deduction_type_id'] = deductionTypeId;
    data['title'] = title;
    return data;
  }
}
