// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:fortuno/features/products/domain/entities/package.dart';

import '../../../products/domain/entities/category.dart';
import '../../../products/domain/entities/product.dart';

class OrderItem extends Equatable {
  final CategoryProduct? category;
  final Product? product;
  final Package? package;
  final int quantity;

  String get id {
    if (product != null) {
      return product?.id ?? "";
    }

    if (package != null) {
      return package?.id ?? "";
    }

    throw ArgumentError("product and package are null");
  }

  String get title {
    if (product != null) {
      return product?.name ?? "";
    }

    if (package != null) {
      return package?.name ?? "";
    }

    throw ArgumentError("product and package are null");
  }

  String get content {
    if (product != null) {
      return "";
    }

    if (package != null) {
      return package?.contents ?? "";
    }

    throw ArgumentError("product and package are null");
  }

  const OrderItem({
    this.category,
    this.product,
    this.package,
    this.quantity = 0,
  });

  @override
  List<Object?> get props => [category, product, package, quantity];

  OrderItem copyWith({
    CategoryProduct? category,
    Product? product,
    Package? package,
    int? quantity,
  }) {
    return OrderItem(
      category: category ?? this.category,
      product: product ?? this.product,
      package: package ?? this.package,
      quantity: quantity ?? this.quantity,
    );
  }
}
