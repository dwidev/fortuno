import '../model/order_model.dart';

abstract class OrderDatasource {
  Future<void> createOrder({required OrderModel orderModel});
  Future<List<OrderModel>> getOrdersByCompanyID({required String companyID});
}
