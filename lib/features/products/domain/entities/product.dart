// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:fortuno/features/products/domain/entities/category.dart';

import '../../../../core/utils/formatter.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String code;
  final double price;
  final String createAt;
  final Uint8List? imageByte;
  final bool isActive;
  final CategoryProduct? category;

  String get kDisplayPrice => "${(price / 1000).toStringAsFixed(0)}K";
  String get priceFormated => moneyFormatter(price);

  const Product({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.createAt,
    this.imageByte,
    this.isActive = false,
    this.category,
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
  List<Object?> get props {
    return [id, name, code, price, createAt, imageByte, isActive, category];
  }

  Product copyWith({
    String? id,
    String? name,
    String? code,
    double? price,
    String? createAt,
    Uint8List? imageByte,
    bool? isActive,
    CategoryProduct? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      price: price ?? this.price,
      createAt: createAt ?? this.createAt,
      imageByte: imageByte ?? this.imageByte,
      isActive: isActive ?? this.isActive,
      category: category ?? this.category,
    );
  }

  @override
  bool get stringify => true;
}
