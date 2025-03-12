// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:fortuno/features/products/domain/entities/package.dart';

import '../../../products/domain/entities/category.dart';
import '../../../products/domain/entities/product.dart';

class OrderItem extends Equatable {
  final String? id;
  final CategoryProduct? category;
  final Product? product;
  final Package? package;

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
    this.id,
    required this.category,
    this.product,
    this.package,
  });

  @override
  List<Object?> get props => [id, category, product, package];
}
