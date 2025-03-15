import '../model/order_model.dart';

abstract class OrderDatasource {
  Future<void> createOrder({required OrderModel orderModel});
}
