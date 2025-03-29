// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/formatter.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String code;
  final double price;
  final String createAt;
  final Uint8List? imageByte;

  String get kDisplayPrice => "${(price / 1000).toStringAsFixed(0)}K";
  String get priceFormated => moneyFormatter(price);

  const Product({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.createAt,
    this.imageByte,
  });

  factory Product.init() => Product(
    id: "id",
    name: "",
    code: "",
    price: 0.0,
    createAt: DateTime.now().toString(),
  );

  factory Product.dummy() => Product(
    id: "id",
    name: "Nama Product",
    code: "",
    price: 120000,
    createAt: DateTime.now().toString(),
  );

  factory Product.preview() => Product(
    id: "id",
    name: "Nama Product",
    code: "",
    price: 0,
    createAt: DateTime.now().toString(),
  );

  @override
  List<Object?> get props => [id, name, code, price, createAt, imageByte];

  Product copyWith({
    String? id,
    String? name,
    String? code,
    double? price,
    String? createAt,
    Uint8List? imageByte,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      price: price ?? this.price,
      createAt: createAt ?? this.createAt,
      imageByte: imageByte ?? this.imageByte,
    );
  }
}
