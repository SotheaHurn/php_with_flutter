import 'dart:convert';

class ProductModel {
  int? id;
  String? name;
  int? categoryId;
  String? categoryName;
  int? brandId;
  String? brandName;
  int? modelId;
  String? modelName;
  double? price;
  int? qty;
  String? image;
  DateTime? createAt;
  int? supplierId;
  String? supplierName;

  ProductModel({
    this.id,
    this.name,
    this.categoryId,
    this.categoryName,
    this.brandId,
    this.brandName,
    this.modelId,
    this.modelName,
    this.price,
    this.qty,
    this.image,
    this.createAt,
    this.supplierId,
    this.supplierName,
  });

  List<ProductModel> formList(List<dynamic> json) =>
      List<ProductModel>.from(json.map((e) => ProductModel.fromMap(e)));

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        id: int.tryParse(map['id'].toString()),
        name: map['name'],
        categoryId: int.tryParse(map['category_id']),
        categoryName: map['category_name'],
        brandId: int.tryParse(map['brand_id']),
        brandName: map['brand_name'],
        modelId: int.tryParse(map['model_id']),
        modelName: map['model_name'],
        price: double.tryParse(map['price']),
        qty: int.tryParse(map['qty']),
        image: map['image'],
        createAt: DateTime.tryParse(map['create_at'])?.toLocal(),
        supplierId: int.tryParse(map['supplier_id'].toString()),
        supplierName: map['supplier_name']);
  }

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
