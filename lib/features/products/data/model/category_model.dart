import 'dart:convert';

import '../../../../core/models/base_model.dart';
import '../../domain/entities/category.dart';

class CategoryModel extends BaseModel<CategoryProduct> {
  final String id;
  final String name;
  final String code;
  final bool haveProduct;
  final double price;
  final String createAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.code,
    required this.haveProduct,
    required this.price,
    required this.createAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': id,
      'category_name': name,
      'category_code': code,
      'have_product': haveProduct,
      'price': price,
      'create_at': createAt,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    final price = BaseModel.parsePriceToDouble(map);

    return CategoryModel(
      id: map["ID"] as String? ?? "",
      name: map["category_name"] as String? ?? "",
      code: map["category_code"] as String? ?? "",
      haveProduct: map["have_product"] as bool? ?? false,
      price: price,
      createAt: map["create_at"]?.toString() ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, code: $code, haveProduct: $haveProduct, price: $price, createAt: $createAt)';
  }

  @override
  CategoryProduct toEntity() {
    return CategoryProduct(
      id: id,
      name: name,
      code: code,
      haveProduct: haveProduct,
      price: price,
      createAt: createAt,
    );
  }
}
