import 'package:fortuno/core/core.dart';
import 'package:fortuno/features/order/data/model/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'order_datasource.dart';

@LazySingleton(as: OrderDatasource)
class OrderNosqlDatasource extends OrderDatasource {
  final SupabaseClient client;

  OrderNosqlDatasource({required this.client});

  @override
  Future<void> createOrder({required OrderModel orderModel}) async {
    final mapOrder = orderModel.toMap();
    final insertOrder = client.from('orders').insert(mapOrder);

    final mapClient = orderModel.clientOrderModel.toMap();
    final insertClient = client.from('client').insert(mapClient);

    final mapItems = orderModel.items.map((e) => e.toMap()).toList();
    final inserOrderItem = client.from('order_items').insert(mapItems);

    await Future.wait([insertOrder, insertClient, inserOrderItem]);
  }
}
