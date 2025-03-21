import 'dart:convert';

import '../../../../core/models/base_model.dart';
import 'product_model.dart';

import '../../domain/entities/package.dart';

class PackageModel extends BaseModel<Package> {
  final String id;
  final String name;
  final String code;
  final double price;
  final bool isActive;
  final String createAt;
  final List<ProductModel> productModel;

  PackageModel({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.isActive,
    required this.createAt,
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
      'products': productModel.map((x) => x.toMap()).toList(),
    };
  }

  factory PackageModel.fromMap(Map<String, dynamic> map) {
    final price = BaseModel.parseToDouble(map['price']);

    return PackageModel(
      id: map['ID'] as String,
      name: map['package_name'] as String,
      code: map['package_code'] as String,
      price: price,
      isActive: map['is_active'] as bool? ?? false,
      createAt: map['created_at'] as String? ?? "",
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
