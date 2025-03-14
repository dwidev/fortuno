import 'dart:developer';

import 'package:fortuno/features/order/domain/entities/order_item.dart';
import 'package:fortuno/features/order/domain/repository/order_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl extends OrderRepository {
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
  @disposeMethod
  void dispose() {
    log("disposing OrderRepositoryImpl");
    _cacheOrders.clear();
  }
}
