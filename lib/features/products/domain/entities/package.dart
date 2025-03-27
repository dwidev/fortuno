import 'package:equatable/equatable.dart';
import 'package:fortuno/core/utils/formatter.dart';
import 'package:fortuno/features/products/domain/entities/category.dart';
import 'package:fortuno/features/products/domain/entities/product.dart';

class Package extends Equatable {
  final String id;
  final String name;
  final String code;
  final double price;
  final bool isActive;
  final String createAt;
  final List<Product> items;

  String get contents => items.map((e) => e.name).join(", ");
  String get priceFormated => moneyFormatter(price);

  const Package({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.isActive,
    required this.createAt,
    required this.items,
  });

  factory Package.dummy() => Package(
    id: "id",
    name: "Nama Package",
    code: "code",
    price: 16000,
    isActive: true,
    createAt: DateTime.now().toString(),
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
  }) {
    return Package(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      price: price ?? this.price,
      isActive: isActive ?? this.isActive,
      createAt: createAt ?? this.createAt,
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props {
    return [id, name, code, price, isActive, createAt, items];
  }

  @override
  bool get stringify => true;
}
