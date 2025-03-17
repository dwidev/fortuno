import 'dart:convert';

import '../../../../core/models/base_model.dart';
import '../../domain/entities/product.dart';

class ProductModel extends BaseModel<Product> {
  final String id;
  final String name;
  final String code;
  final double price;
  final String createAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.createAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': id,
      'product_name': name,
      'product_code': code,
      'price': price,
      'create_at': createAt,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    final price = BaseModel.parseToDouble(map['price']);

    return ProductModel(
      id: map["ID"] as String? ?? "",
      name: map["product_name"] as String? ?? "",
      code: map["product_code"] as String? ?? "",
      price: price,
      createAt: map["create_at"]?.toString() ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, code: $code,  price: $price, createAt: $createAt)';
  }

  @override
  Product toEntity() {
    return Product(
      id: id,
      name: name,
      code: code,
      price: price,
      createAt: createAt,
    );
  }
}
