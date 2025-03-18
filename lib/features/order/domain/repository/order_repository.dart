import '../entities/order.dart';
import '../enums/order_status.dart';
import '../enums/payment_option.dart' show PaymentOption;

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

  Future<List<Order>> getOrdersByCompanyID({required String companyID});

  Future<void> updateOrderStatus({
    required OrderStatus newStatus,
    required PaymentOption option,
    required String orderID,
  });
  void dispose();
}
