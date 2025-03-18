import 'package:fortuno/features/order/domain/enums/payment_option.dart';

import '../../domain/enums/order_status.dart';

import '../model/order_model.dart';

abstract class OrderDatasource {
  Future<void> createOrder({required OrderModel orderModel});
  Future<List<OrderModel>> getOrdersByCompanyID({required String companyID});
  Future<void> updateOrderStatus({
    required OrderStatus newStatus,
    required PaymentOption option,
    required String orderID,
  });
}
