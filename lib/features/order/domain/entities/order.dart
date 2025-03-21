import 'package:equatable/equatable.dart';
import 'package:fortuno/core/core.dart';

import '../enums/order_status.dart';
import 'client_order.dart';
import 'order_item.dart';

class Order extends Equatable {
  final String id;
  final String companyId;
  final String clientId;
  final double totalPrice;
  final double shippingCost;
  final double discount;
  final String paymentOption;
  final OrderStatus orderStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ClientOrder client;
  final List<OrderItem> items;

  String get totalPriceString => moneyFormatter(totalPrice);

  String get subTotalString => items.totalPriceString;

  double get downPayment => totalPrice * 10 / 100;

  const Order({
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
    required this.client,
    required this.items,
  });

  factory Order.init() => Order(
    id: '',
    companyId: '',
    clientId: '',
    totalPrice: 0,
    shippingCost: 0,
    discount: 0,
    paymentOption: '',
    orderStatus: OrderStatus.waiting,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    items: [],
    client: ClientOrder.init(),
  );

  Order copyWith({
    String? id,
    String? companyId,
    String? clientId,
    double? totalPrice,
    double? shippingCost,
    double? discount,
    String? paymentOption,
    OrderStatus? orderStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    ClientOrder? client,
    List<OrderItem>? items,
  }) {
    return Order(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      clientId: clientId ?? this.clientId,
      totalPrice: totalPrice ?? this.totalPrice,
      shippingCost: shippingCost ?? this.shippingCost,
      discount: discount ?? this.discount,
      paymentOption: paymentOption ?? this.paymentOption,
      orderStatus: orderStatus ?? this.orderStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      client: client ?? this.client,
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      companyId,
      clientId,
      totalPrice,
      shippingCost,
      discount,
      paymentOption,
      orderStatus,
      createdAt,
      updatedAt,
      client,
      items,
    ];
  }

  @override
  bool get stringify => true;
}
