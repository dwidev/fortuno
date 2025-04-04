import 'package:fortuno/features/order/domain/enums/order_status.dart';
import 'package:fortuno/features/order/domain/enums/payment_option.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/core.dart';
import '../model/order_model.dart';
import 'order_datasource.dart';

@LazySingleton(as: OrderDatasource)
class OrderNosqlDatasource extends OrderDatasource {
  final SupabaseClient client;

  OrderNosqlDatasource({required this.client});

  String generateInvoiceNumber(String orderId, DateTime orderDate) {
    String shortOrderId =
        orderId
            .substring(0, 5)
            .replaceAll("-", "")
            .replaceAll(" ", "")
            .toUpperCase();

    String orderDateStr = DateFormat('ddMMyyyy').format(orderDate);
    String nowDateStr = DateFormat('ddMMyyyy').format(DateTime.now());

    return 'INV/$orderDateStr/$shortOrderId/$nowDateStr';
  }

  @override
  Future<void> createOrder({required OrderModel orderModel}) async {
    final mapOrder = orderModel.toMap();
    final mapClient = orderModel.clientOrderModel.toMap();
    final mapItems = orderModel.items.map((e) => e.toMap()).toList();
    final invNumber = generateInvoiceNumber(
      orderModel.id,
      orderModel.clientOrderModel.sendDate,
    );
    mapOrder['invoice_number'] = invNumber;

    final params = {'client': mapClient, 'orders': mapOrder, 'items': mapItems};
    await client.rpc('insert_order', params: params);
  }

  @override
  Future<List<OrderModel>> getOrdersByCompanyID({
    required String companyID,
    required OrderStatus status,
  }) async {
    final params = <String, String>{
      "company_uuid": companyID,
      "order_status_params": status.name,
    };
    final response =
        await client.rpc('get_order_by_company', params: params).select();
    final result = response.map((e) => OrderModel.fromMap(e)).toList();
    return result;
  }

  @override
  Future<void> updateOrderStatus({
    required String orderID,
    required OrderStatus newStatus,
    required PaymentOption option,
  }) async {
    final params = <String, dynamic>{
      'order_status': newStatus.name,
      'payment_option': option.name,
    };

    await client.from('orders').update(params).eq('ID', orderID);
  }
}
