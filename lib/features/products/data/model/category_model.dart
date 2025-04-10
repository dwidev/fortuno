import 'dart:convert';

import 'package:fortuno/core/utils/code_gen.dart';

import '../../../../core/models/base_model.dart';
import '../../domain/entities/category.dart';

class CategoryModel extends BaseModel<CategoryProduct> {
  final String id;
  final String companyId;
  final String name;
  final String code;
  final bool haveProduct;
  final double price;
  final String createAt;
  final bool isActive;

  CategoryModel({
    required this.id,
    required this.companyId,
    required this.name,
    required this.code,
    required this.haveProduct,
    required this.price,
    required this.createAt,
    this.isActive = false,
  });

  CategoryModel.submitOrder({
    required this.id,
    this.companyId = "",
    this.name = '',
    this.code = '',
    this.haveProduct = false,
    this.price = 0.0,
    this.createAt = '',
    this.isActive = false,
  });

  Map<String, dynamic> toMap() {
    final code = codeGen(name);

    return <String, dynamic>{
      'ID': id,
      'company_id': companyId,
      'category_name': name,
      'category_code': code,
      'have_product': haveProduct,
      'price': price,
      'is_active': isActive.toString(),
      'create_at': createAt,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    final price = BaseModel.parseToDouble(map['price']);

    return CategoryModel(
      id: map["ID"] as String? ?? "",
      companyId: map["company_id"] as String? ?? "",
      name: map["category_name"] as String? ?? "",
      code: map["category_code"] as String? ?? "",
      haveProduct: map["have_product"] as bool? ?? false,
      price: price,
      createAt: map["create_at"]?.toString() ?? "",
      isActive: map['is_active'] as bool? ?? false,
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
      imageByte: null,
      isActive: isActive,
    );
  }
}
