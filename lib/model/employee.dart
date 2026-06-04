import 'package:fl_ga_mhis_hub/model/models.dart';

class Employee {
  int? id;
  String? idTalenta;
  String? createdAt;
  String? updatedAt;
  Person? approval;
  Person? personal;
  Employment? employment;
  ActiveSchedule? activeSchedule;
  User? user;
  bool? isActive;

  Employee({
    this.id,
    this.idTalenta,
    this.createdAt,
    this.updatedAt,
    this.approval,
    this.personal,
    this.employment,
    this.user,
    this.activeSchedule,
    this.isActive,
  });

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idTalenta = json['id_talenta'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    approval = json['approval'] != null
        ? Person.fromJson(json['approval'])
        : null;
    activeSchedule = json['active_schedule'] != null
        ? ActiveSchedule.fromJson(json['active_schedule'])
        : null;
    personal = json['personal'] != null
        ? Person.fromJson(json['personal'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    employment = json['employment'] != null
        ? Employment.fromJson(json['employment'])
        : null;
    isActive = (json['is_active'] == "1" || json['is_active'] == 1)
        ? true
        : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_talenta'] = idTalenta;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['approval'] = approval;
    data['is_active'] = isActive;
    if (personal != null) {
      data['personal'] = personal!.toJson();
    }
    if (employment != null) {
      data['employment'] = employment!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (activeSchedule != null) {
      data['active_schedule'] = activeSchedule!.toJson();
    }
    return data;
  }
}
