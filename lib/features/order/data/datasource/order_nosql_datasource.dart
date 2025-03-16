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
}
