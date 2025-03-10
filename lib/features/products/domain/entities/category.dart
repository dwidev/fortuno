import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String code;
  final double price;
  final String createAt;

  const Product({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.createAt,
  });

  @override
  List<Object?> get props => [id, name, code, price, createAt];
}

class CategoryProduct extends Product {
  final bool haveProduct;

  const CategoryProduct({
    required super.id,
    required super.name,
    required super.code,
    required super.price,
    required super.createAt,
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
  List<Object?> get props => [id, name, code, haveProduct, price, createAt];
}
