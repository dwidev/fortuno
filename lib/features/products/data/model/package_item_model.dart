import 'dart:convert';

class PackageItemModel {
  final String id;
  final String productId;
  final String packageId;

  PackageItemModel({
    required this.id,
    required this.productId,
    required this.packageId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': id,
      'product_id': productId,
      'package_id': packageId,
    };
  }

  factory PackageItemModel.fromMap(Map<String, dynamic> map) {
    return PackageItemModel(
      id: map['ID'] as String,
      productId: map['product_id'] as String,
      packageId: map['package_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageItemModel.fromJson(String source) =>
      PackageItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
