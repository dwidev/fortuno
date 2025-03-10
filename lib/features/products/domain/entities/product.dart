import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String code;
  final double price;
  final bool haveProducts;
  final String createAt;

  const Product({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.haveProducts,
    required this.createAt,
  });

  const Product.initial({
    this.id = '',
    this.name = '',
    this.code = '',
    this.price = 0.0,
    this.haveProducts = false,
    this.createAt = '',
  });

  @override
  List<Object?> get props => [id, name, code, price, haveProducts, createAt];
}
