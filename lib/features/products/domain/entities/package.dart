// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../enums/package_type.dart';
import 'category.dart';
import 'image.dart';
import 'inventory.dart';
import 'product.dart';

class Package extends Equatable implements Inventory {
  @override
  final String id;
  final String companyId;
  @override
  final String name;
  @override
  final String code;
  @override
  final double price;
  final bool isActive;
  final String createAt;
  final PackageType type;
  final CategoryProduct? category;
  final List<Product> items;
  @override
  final ImageData image;

  String get contents => items.map((e) => e.name).join(", ");

  const Package({
    required this.id,
    required this.companyId,
    required this.name,
    required this.code,
    required this.price,
    required this.isActive,
    required this.createAt,
    this.type = PackageType.def,
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
    required PackageType type,
  }) => Package(
    id: Uuid().v4(),
    companyId: "",
    name: name,
    code: "", // SET AT PRODUCT DATA SOURCE
    price: price,
    isActive: isActive,
    createAt: DateTime.now().toUtc().toString(),
    items: items,
    category: category,
    image: ImageData(),
    type: type,
  );

  factory Package.dummy() => Package(
    id: "id",
    companyId: "",
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
    companyId: "",
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
    String? companyId,
    String? name,
    String? code,
    double? price,
    bool? isActive,
    String? createAt,
    PackageType? type,
    CategoryProduct? category,
    List<Product>? items,
    ImageData? image,
  }) {
    return Package(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      name: name ?? this.name,
      code: code ?? this.code,
      price: price ?? this.price,
      isActive: isActive ?? this.isActive,
      createAt: createAt ?? this.createAt,
      type: type ?? this.type,
      category: category ?? this.category,
      items: items ?? this.items,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      companyId,
      name,
      code,
      price,
      isActive,
      createAt,
      type,
      category,
      items,
      image,
    ];
  }

  @override
  bool get stringify => true;
}
