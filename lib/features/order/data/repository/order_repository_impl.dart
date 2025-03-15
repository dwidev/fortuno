import 'dart:developer';

import 'package:uuid/uuid.dart';

import '../../../../core/core.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/order_item.dart';
import '../../domain/repository/order_repository.dart';
import '../datasource/order_datasource.dart';
import '../model/client_order_model.dart';
import '../model/order_model.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl extends OrderRepository {
  final OrderDatasource orderDatasource;
  OrderRepositoryImpl({required this.orderDatasource});

  final List<OrderItem> _cacheOrders = [];

  @override
  void cacheOrder({
    required List<OrderItem> orders,
    required String categoryId,
  }) {
    _cacheOrders.clear();
    _cacheOrders.addAll(orders);
  }

  @override
  List<OrderItem> getCacheOrder({required String categoryId}) {
    final orders =
        _cacheOrders.where((e) => e.category?.id == categoryId).toList();
    return orders;
  }

  @override
  Future<void> onCrateOrder({required Order order}) async {
    final client = ClientOrderModel(
      id: Uuid().v4(),
      name: order.client.name,
      phoneNumber: order.client.phoneNumber,
      sendDate: order.client.sendDate,
      address: order.client.address,
      rt: order.client.rt,
      rw: order.client.rw,
      detailAddress: order.client.detailAddress,
    );

    final model = OrderModel(
      id: Uuid().v4(),
      // TODO change company id
      companyId: "898a70b4-0758-4eda-bf73-b469db14eb50",
      clientId: client.id,
      totalPrice: order.totalPrice,
      shippingCost: order.discount,
      discount: order.discount,
      paymentOption: order.paymentOption,
      orderStatus: order.orderStatus.name,
      createdAt: order.createdAt.toString(),
      updatedAt: order.updatedAt.toString(),
      items: [],
      clientOrderModel: client,
    );

    return orderDatasource.createOrder(orderModel: model);
  }

  @override
  @disposeMethod
  void dispose() {
    log("disposing OrderRepositoryImpl");
    _cacheOrders.clear();
  }
}
