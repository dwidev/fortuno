// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fortuno/core/utils/code_gen.dart';

import '../../../../core/models/base_model.dart';
import '../../domain/entities/product.dart';

class ProductModel extends BaseModel<Product> {
  final String id;
  final String companyId;
  final String name;
  final String code;
  final double price;
  final bool isActive;
  final String createAt;

  ProductModel({
    required this.id,
    required this.companyId,
    required this.name,
    required this.code,
    required this.price,
    required this.isActive,
    required this.createAt,
  });

  Map<String, dynamic> toMap() {
    final code = codeGen(name);

    return <String, dynamic>{
      'ID': id,
      'company_id': companyId,
      'product_name': name,
      'product_code': code,
      'price': price,
      'created_at': createAt,
      'is_active': isActive,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    final price = BaseModel.parseToDouble(map['price']);

    return ProductModel(
      id: map["ID"] as String? ?? "",
      companyId: map["company_id"] as String? ?? "",
      name: map["product_name"] as String? ?? "",
      code: map["product_code"] as String? ?? "",
      price: price,
      isActive: map["is_active"] as bool? ?? false,
      createAt: map["created_at"]?.toString() ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, companyId: $companyId, name: $name, code: $code, price: $price, isActive: $isActive, createAt: $createAt)';
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
