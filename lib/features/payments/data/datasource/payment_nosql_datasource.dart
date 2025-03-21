import 'package:fortuno/core/core.dart';
import 'package:fortuno/features/payments/data/datasource/payment_datasource.dart';
import 'package:fortuno/features/payments/data/failures/invoice_failure.dart';
import 'package:fortuno/features/payments/data/model/invoice_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: PaymentDatasource)
class PaymentNosqlDatasource extends PaymentDatasource {
  final SupabaseClient client;

  PaymentNosqlDatasource({required this.client});

  @override
  Future<InvoiceModel> getInvoice({required String orderID}) async {
    final response = await client
        .from('invoice')
        .select()
        .eq('order_id', orderID);

    final invoice = response.firstOrNull;
    if (invoice == null) {
      throw InvoiceNotFound();
    }

    final result = InvoiceModel.fromMap(invoice);
    return result;
  }
}
