import 'package:equatable/equatable.dart';

class CategoryProduct extends Equatable {
  final String id;
  final String name;
  final String code;
  final bool haveProduct;
  final double price;
  final String createAt;

  const CategoryProduct({
    required this.id,
    required this.name,
    required this.code,
    required this.haveProduct,
    required this.price,
    required this.createAt,
  });

  const CategoryProduct.initial({
    this.id = '',
    this.name = '',
    this.code = '',
    this.haveProduct = false,
    this.price = 0.0,
    this.createAt = '',
  });

  @override
  List<Object?> get props => [id, name, code, haveProduct, price, createAt];
}
