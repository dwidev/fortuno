import 'dart:convert';

import '../../../../core/models/base_model.dart';
import 'client_order_model.dart';
import 'order_item_model.dart';
import '../../domain/enums/order_status.dart';

import '../../domain/entities/order.dart';

class OrderModel extends BaseModel<Order> {
  final String id;
  final String companyId;
  final String clientId;
  final double totalPrice;
  final double shippingCost;
  final double discount;
  final String paymentOption;
  final String orderStatus;
  final String createdAt;
  final String updatedAt;

  final List<OrderItemModel> items;
  final ClientOrderModel clientOrderModel;

  OrderModel({
    required this.id,
    required this.companyId,
    required this.clientId,
    required this.totalPrice,
    required this.shippingCost,
    required this.discount,
    required this.paymentOption,
    required this.orderStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    required this.clientOrderModel,
  });

  @override
  Order toEntity() {
    return Order(
      id: id,
      companyId: companyId,
      clientId: clientId,
      totalPrice: totalPrice,
      shippingCost: shippingCost,
      discount: discount,
      paymentOption: paymentOption,
      orderStatus: orderStatusfromString(orderStatus),
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
      client: clientOrderModel.toEntity(),
      items: items.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': id,
      'company_id': companyId,
      'client_id': clientId,
      'total_price': totalPrice,
      'shipping_cost': shippingCost,
      'discount': discount,
      'payment_option': paymentOption,
      'order_status': orderStatus,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['order_id'] as String,
      companyId: map['company_id'] as String,
      clientId: map['client_id'] as String,
      totalPrice: BaseModel.parseToDouble(map['total_price']),
      shippingCost: BaseModel.parseToDouble(map['shipping_cost']),
      discount: BaseModel.parseToDouble(map['discount']),
      paymentOption: map['payment_option'] as String,
      orderStatus: map['order_status'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
      clientOrderModel: ClientOrderModel.fromMap(map['client']),
      items:
          (map["items"] as List).map((e) => OrderItemModel.fromMap(e)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
