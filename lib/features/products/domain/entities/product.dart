import 'package:equatable/equatable.dart';

import 'category.dart';
import 'image.dart';
import 'inventory.dart';

const _defaultName = "Nama Product";

class Product extends Equatable implements Inventory {
  @override
  final String id;
  @override
  final String name;
  @override
  final String code;
  @override
  final double price;
  final String createAt;
  final bool isActive;
  final CategoryProduct? category;
  @override
  final ImageData image;

  const Product({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.createAt,
    this.image = const ImageData(),
    this.isActive = false,
    this.category,
  });

  factory Product.init() => Product(
    id: "id",
    name: "",
    code: "",
    price: 0.0,
    createAt: DateTime.now().toString(),
    isActive: true,
  );

  factory Product.dummy() => Product(
    id: "id",
    name: _defaultName,
    code: "",
    price: 120000,
    createAt: DateTime.now().toString(),
    isActive: true,
  );

  factory Product.preview() => Product(
    id: "id",
    name: _defaultName,
    code: "",
    price: 0,
    createAt: DateTime.now().toString(),
    isActive: true,
  );

  @override
  List<Object?> get props {
    return [id, name, code, price, createAt, image, isActive, category];
  }

  Product copyWith({
    String? id,
    String? name,
    String? code,
    double? price,
    String? createAt,
    ImageData? image,
    bool? isActive,
    CategoryProduct? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      price: price ?? this.price,
      createAt: createAt ?? this.createAt,
      image: image ?? this.image,
      isActive: isActive ?? this.isActive,
      category: category ?? this.category,
    );
  }

  @override
  bool get stringify => true;
}
