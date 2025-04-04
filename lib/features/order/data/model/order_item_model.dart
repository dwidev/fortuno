import 'dart:convert';

import 'package:fortuno/core/models/base_model.dart';
import 'package:fortuno/features/order/domain/entities/order_item.dart';
import 'package:fortuno/features/products/data/model/category_model.dart';
import 'package:fortuno/features/products/data/model/package_model.dart';
import 'package:fortuno/features/products/data/model/product_model.dart';

class OrderItemModel extends BaseModel<OrderItem> {
  final String id;
  final String orderID;
  final String? productID;
  final String? packageID;
  final int quantity;
  final double totalPrice;

  // only bulk get data
  final CategoryModel? categoryModel;
  final ProductModel? productModel;
  final PackageModel? packageModel;

  OrderItemModel({
    required this.id,
    required this.orderID,
    required this.productID,
    required this.packageID,
    required this.quantity,
    required this.totalPrice,
    this.categoryModel,
    this.productModel,
    this.packageModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': id,
      'order_id': orderID,
      'product_id': productID,
      'package_id': packageID,
      'quantity': quantity,
      'total_price': totalPrice,
    };
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    final productModel =
        map['product'] != null
            ? ProductModel.fromMap(map['product'] as Map<String, dynamic>)
            : null;

    final packageModel =
        map['packages'] != null
            ? PackageModel.fromMap(map['packages'] as Map<String, dynamic>)
            : null;
    return OrderItemModel(
      id: map['ID']?.toString() ?? "",
      totalPrice: BaseModel.parseToDouble(map['total_price']),
      productModel: productModel,
      packageModel: packageModel,
      quantity: map['quantity'] as int,
      orderID: "",
      productID: productModel?.id,
      packageID: packageModel?.id,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItemModel.fromJson(String source) =>
      OrderItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  OrderItem toEntity() {
    return OrderItem(
      category: categoryModel?.toEntity(),
      product: productModel?.toEntity(),
      package: packageModel?.toEntity(),
      quantity: quantity,
    );
  }
}
