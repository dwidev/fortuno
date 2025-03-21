// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:fortuno/core/core.dart';

import 'package:fortuno/features/products/domain/entities/package.dart';

import '../../../products/domain/entities/category.dart';
import '../../../products/domain/entities/product.dart';

extension ListOrderItemExt on List<OrderItem> {
  double get totalPrice {
    var total = 0.0;
    forEach((e) {
      total += e.totalPrice;
    });
    return total;
  }

  String get totalPriceString {
    return moneyFormatter(totalPrice);
  }
}

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

  double get price {
    double? price;

    if (product != null) {
      price = product?.price;
    }

    if (package != null) {
      price = package?.price;
    }

    if (price == null) return 0;
    return price;
  }

  String get priceString {
    if (price == 0) return "";
    return moneyFormatter(price);
  }

  double get totalPrice {
    double? total;

    if (product != null) {
      total = product!.price * quantity;
    }

    if (package != null) {
      total = package!.price * quantity;
    }

    if (total == null) return 0;
    return total;
  }

  String get totalPriceString {
    if (totalPrice == 0) return "";
    return moneyFormatter(totalPrice);
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

  String get contents {
    if (product != null) {
      return "";
    }

    if (package != null) {
      return package?.contents ?? "";
    }

    throw ArgumentError("product and package are null");
  }

  String get quantityTitle {
    if (price == 0) return "";

    if (product != null) {
      return "x $quantity item";
    }

    if (package != null) {
      return "x $quantity pax";
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
