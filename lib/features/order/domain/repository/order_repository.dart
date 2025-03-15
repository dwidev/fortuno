import 'package:fortuno/features/order/domain/entities/order.dart';

import '../entities/order_item.dart';

abstract class OrderRepository {
  // cache order
  List<OrderItem> getCacheOrder({required String categoryId});
  void cacheOrder({
    required List<OrderItem> orders,
    required String categoryId,
  });

  // insert order
  Future<void> onCrateOrder({required Order order});

  void dispose();
}
