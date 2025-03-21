import 'package:fortuno/features/payments/data/model/invoice_model.dart';

abstract class PaymentDatasource {
  Future<InvoiceModel> getInvoice({required String orderID});
}
