import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String code;
  final double price;
  final String createAt;

  String get displayPrice => "${(price / 1000).toStringAsFixed(0)}K";

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
