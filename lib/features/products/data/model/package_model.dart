// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fortuno/core/models/base_model.dart';
import 'package:fortuno/features/products/data/model/category_model.dart';
import 'package:fortuno/features/products/data/model/product_model.dart';

import '../../domain/entities/package.dart';

class PackageModel extends BaseModel<Package> {
  final String id;
  final String name;
  final String code;
  final double price;
  final bool isActive;
  final String createAt;
  final CategoryModel categoryModel;
  final List<ProductModel> productModel;

  PackageModel({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.isActive,
    required this.createAt,
    required this.categoryModel,
    required this.productModel,
  });

  @override
  Package toEntity() {
    return Package(
      id: id,
      name: name,
      code: code,
      price: price,
      isActive: isActive,
      createAt: createAt,
      category: categoryModel.toEntity(),
      items: productModel.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': id,
      'package_name': name,
      'package_code': code,
      'price': price,
      'is_active': isActive,
      'created_at': createAt,
      'category': categoryModel.toMap(),
      'products': productModel.map((x) => x.toMap()).toList(),
    };
  }

  factory PackageModel.fromMap(Map<String, dynamic> map) {
    final price = BaseModel.parsePriceToDouble(map);

    return PackageModel(
      id: map['package_id'] as String,
      name: map['package_name'] as String,
      code: map['package_code'] as String,
      price: price,
      isActive: map['is_active'] as bool,
      createAt: map['created_at'] as String,
      categoryModel: CategoryModel.fromMap(map['category']),
      productModel: List.from(
        (map['products']).map(
          (x) => ProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageModel.fromJson(String source) =>
      PackageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
