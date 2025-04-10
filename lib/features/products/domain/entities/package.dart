import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utils/formatter.dart';
import 'category.dart';
import 'image.dart';
import 'product.dart';

class Package extends Equatable {
  final String id;
  final String name;
  final String code;
  final double price;
  final bool isActive;
  final String createAt;
  final CategoryProduct? category;
  final List<Product> items;
  final ImageData image;

  String get contents => items.map((e) => e.name).join(", ");
  String get priceFormated => moneyFormatter(price);

  const Package({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.isActive,
    required this.createAt,
    required this.category,
    required this.items,
    this.image = const ImageData(),
  });

  factory Package.create({
    required String name,
    required double price,
    required bool isActive,
    required CategoryProduct category,
    required List<Product> items,
    required ImageData? image,
  }) => Package(
    id: Uuid().v4(),
    name: name,
    code: "", // SET AT PRODUCT DATA SOURCE
    price: price,
    isActive: isActive,
    createAt: DateTime.now().toUtc().toString(),
    items: items,
    category: category,
    image: ImageData(),
  );

  factory Package.dummy() => Package(
    id: "id",
    name: "Nama Package",
    code: "code",
    price: 16000,
    isActive: true,
    createAt: DateTime.now().toString(),
    items: [Product.dummy(), Product.dummy(), Product.dummy(), Product.dummy()],
    category: CategoryProduct.initial(name: "Category"),
  );

  factory Package.preview() => Package(
    id: "id",
    name: "Nama Product",
    code: "",
    price: 0,
    createAt: DateTime.now().toString(),
    isActive: true,
    category: CategoryProduct.preview(),
    items: [Product.dummy(), Product.dummy(), Product.dummy(), Product.dummy()],
  );

  Package copyWith({
    String? id,
    String? name,
    String? code,
    double? price,
    bool? isActive,
    String? createAt,
    CategoryProduct? category,
    List<Product>? items,
    ImageData? image,
  }) {
    return Package(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      price: price ?? this.price,
      isActive: isActive ?? this.isActive,
      createAt: createAt ?? this.createAt,
      category: category ?? this.category,
      items: items ?? this.items,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props {
    return [id, name, code, price, isActive, createAt, category, items, image];
  }

  @override
  bool get stringify => true;
}
