import 'dart:convert';

class ModelModel {
  int? id;
  String? name;
  int? brandId;
  String? brandName;

  ModelModel({
    this.id,
    this.name,
    this.brandId,
    this.brandName,
  });

  List<ModelModel> formList(List<dynamic> json) =>
      List<ModelModel>.from(json.map((e) => ModelModel.fromMap(e)));

  factory ModelModel.fromMap(Map<String, dynamic> map) {
    return ModelModel(
      id: int.tryParse(map['id'].toString()),
      name: map['name'],
      brandId: map['brandId'],
      brandName: map['brandName'],
    );
  }

  factory ModelModel.fromJson(String source) =>
      ModelModel.fromMap(json.decode(source));
}
