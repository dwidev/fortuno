import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/core.dart';
import '../model/order_model.dart';
import 'order_datasource.dart';

@LazySingleton(as: OrderDatasource)
class OrderNosqlDatasource extends OrderDatasource {
  final SupabaseClient client;

  OrderNosqlDatasource({required this.client});

  @override
  Future<void> createOrder({required OrderModel orderModel}) async {
    final mapOrder = orderModel.toMap();
    final mapClient = orderModel.clientOrderModel.toMap();
    final mapItems = orderModel.items.map((e) => e.toMap()).toList();

    final params = {'client': mapClient, 'orders': mapOrder, 'items': mapItems};
    await client.rpc('insert_order', params: params);
  }

  @override
  Future<List<OrderModel>> getOrdersByCompanyID({
    required String companyID,
  }) async {
    final params = <String, String>{"company_uuid": companyID};
    final response =
        await client.rpc('get_order_by_company', params: params).select();
    final result = response.map((e) => OrderModel.fromMap(e)).toList();
    return result;
  }
}
