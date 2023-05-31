import 'dart:convert';

class SupplierModel {
  int? id;
  String? profile;
  String? name;
  String? sex;
  DateTime? dob;
  String? phone;

  SupplierModel({
    this.id,
    this.profile,
    this.name,
    this.sex,
    this.dob,
    this.phone,
  });

  List<SupplierModel> formList(List<dynamic> json) =>
      List<SupplierModel>.from(json.map((e) => SupplierModel.fromMap(e)));

  factory SupplierModel.fromMap(Map<String, dynamic> map) {
    return SupplierModel(
      id: int.tryParse(map['id']),
      profile: map['profile'],
      name: map['name'],
      sex: map['sex'],
      dob: DateTime.tryParse(map['dob'])?.toLocal(),
      phone: map['phone'],
    );
  }

  factory SupplierModel.fromJson(String source) =>
      SupplierModel.fromMap(json.decode(source));
}
