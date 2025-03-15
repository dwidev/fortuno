// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fortuno/core/models/base_model.dart';
import 'package:fortuno/features/order/data/model/order_model.dart';
import 'package:fortuno/features/order/domain/entities/order_item.dart';
import 'package:fortuno/features/products/data/model/category_model.dart';
import 'package:fortuno/features/products/data/model/package_model.dart';
import 'package:fortuno/features/products/data/model/product_model.dart';

class OrderItemModel extends BaseModel<OrderItem> {
  final String id;
  final CategoryModel categoryModel;
  final OrderModel orderModel;
  final ProductModel productModel;
  final PackageModel packageModel;
  final int quantity;
  final double totalPrice;

  OrderItemModel({
    required this.id,
    required this.categoryModel,
    required this.orderModel,
    required this.productModel,
    required this.packageModel,
    required this.quantity,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order_id': orderModel.id,
      'product_id': productModel.id,
      'package_id': packageModel.id,
      'quantity': quantity,
      'total_price': totalPrice,
    };
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      id: map['id'] as String,
      totalPrice: map['totalPrice'] as double,
      categoryModel: CategoryModel.fromMap(
        map['categor'] as Map<String, dynamic>,
      ),
      orderModel: OrderModel.fromMap(map['orders'] as Map<String, dynamic>),
      productModel: ProductModel.fromMap(
        map['products'] as Map<String, dynamic>,
      ),
      packageModel: PackageModel.fromMap(
        map['packages'] as Map<String, dynamic>,
      ),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItemModel.fromJson(String source) =>
      OrderItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  OrderItem toEntity() {
    return OrderItem(
      category: categoryModel.toEntity(),
      product: productModel.toEntity(),
      package: packageModel.toEntity(),
      quantity: quantity,
    );
  }
}
