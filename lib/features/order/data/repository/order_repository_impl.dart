import 'package:uuid/uuid.dart';

import '../../../../core/core.dart';
import '../../../profile/data/datasource/company_datasource.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/order_item.dart';
import '../../domain/enums/order_status.dart';
import '../../domain/enums/payment_option.dart';
import '../../domain/repository/order_repository.dart';
import '../datasource/order_datasource.dart';
import '../model/client_order_model.dart';
import '../model/order_item_model.dart';
import '../model/order_model.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  final CompanyDatasource companyDatasource;
  final OrderDatasource orderDatasource;

  OrderRepositoryImpl({
    required this.companyDatasource,
    required this.orderDatasource,
  });

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
    final companyID = await companyDatasource.getCompanyID();

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

    final orderId = Uuid().v4();
    final now = DateTime.now().toUtc();

    final model = OrderModel(
      id: orderId,
      companyId: companyID,
      clientId: client.id,
      totalPrice: order.totalPrice,
      shippingCost: order.shippingCost,
      discount: order.discount,
      paymentOption: order.paymentOption,
      orderStatus: order.orderStatus.name,
      createdAt: now.toIso8601String(),
      updatedAt: now.toIso8601String(),
      items:
          order.items
              .map(
                (e) => OrderItemModel(
                  id: e.id,
                  orderID: orderId,
                  productID: e.product?.id,
                  packageID: e.package?.id,
                  quantity: e.quantity,
                  totalPrice: e.totalPrice,
                ),
              )
              .toList(),
      clientOrderModel: client,
    );

    return orderDatasource.createOrder(orderModel: model);
  }

  @override
  Future<List<Order>> getOrdersByStatus({required OrderStatus status}) async {
    final companyID = await companyDatasource.getCompanyID();
    final response = await orderDatasource.getOrdersByCompanyID(
      companyID: companyID,
      status: status,
    );
    return response.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> updateOrderStatus({
    required OrderStatus newStatus,
    required PaymentOption option,
    required String orderID,
  }) {
    return orderDatasource.updateOrderStatus(
      orderID: orderID,
      newStatus: newStatus,
      option: option,
    );
  }

  @override
  @disposeMethod
  void dispose() {
    _cacheOrders.clear();
  }
}
