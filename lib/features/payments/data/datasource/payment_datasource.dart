import '../../../order/domain/entities/order.dart';
import '../model/invoice_model.dart';
import '../model/payment_model.dart';

abstract class PaymentDatasource {
  Future<InvoiceModel> getInvoice({required String orderID});
  Future<void> savePayment({required PaymentModel model});
  Future<String> getInvoiceNumber({required Order order});
}
