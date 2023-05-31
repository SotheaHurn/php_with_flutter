import 'dart:convert';

class CategoryModel {
  int? id;
  String? name;
  String? image;

  CategoryModel({
    this.id,
    this.name,
    this.image,
  });

  List<CategoryModel> formList(List<dynamic> json) =>
      List<CategoryModel>.from(json.map((e) => CategoryModel.fromMap(e)));

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: int.tryParse(map['id'].toString()),
      name: map['name'],
      image: map['image'],
    );
  }

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));
}
