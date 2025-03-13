import '../entities/order_item.dart';

abstract class OrderRepository {
  List<OrderItem> getCacheOrder({required String categoryId});
  void cacheOrder({
    required List<OrderItem> orders,
    required String categoryId,
  });

  void dispose();
}
