import 'dart:typed_data';

import 'product.dart';

class CategoryProduct extends Product {
  final bool haveProduct;

  const CategoryProduct({
    required super.id,
    required super.name,
    required super.code,
    required super.price,
    required super.createAt,
    required super.imageByte,
    required super.isActive,
    required this.haveProduct,
  });

  const CategoryProduct.initial({
    super.id = '',
    super.name = '',
    super.code = '',
    super.price = 0.0,
    super.createAt = '',
    this.haveProduct = false,
  });

  @override
  List<Object?> get props => [...super.props, haveProduct];

  @override
  CategoryProduct copyWith({
    String? id,
    String? name,
    String? code,
    double? price,
    String? createAt,
    bool? haveProduct,
    Uint8List? imageByte,
    bool? isActive,
  }) {
    return CategoryProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      price: price ?? this.price,
      createAt: createAt ?? this.createAt,
      haveProduct: haveProduct ?? this.haveProduct,
      imageByte: imageByte ?? this.imageByte,
      isActive: isActive ?? this.isActive,
    );
  }
}
