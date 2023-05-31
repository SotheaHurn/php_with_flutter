import 'dart:convert';

class BrandModel {
  int? id;
  String? name;
  String? image;

  BrandModel({
    this.id,
    this.name,
    this.image,
  });

  List<BrandModel> formList(List<dynamic> json) =>
      List<BrandModel>.from(json.map((e) => BrandModel.fromMap(e)));

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      id: int.tryParse(map['id'].toString()),
      name: map['name'],
      image: map['image'],
    );
  }

  factory BrandModel.fromJson(String source) =>
      BrandModel.fromMap(json.decode(source));
}
