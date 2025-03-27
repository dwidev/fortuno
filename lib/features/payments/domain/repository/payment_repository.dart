import 'package:fortuno/features/payments/domain/entities/payment.dart';

import '../../../order/domain/entities/order.dart';
import '../entities/inovice.dart';

abstract class PaymentRepository {
  Future<Invoice> getInvoice({required String orderID});
  Future<void> savePayment({required Payment payment});
  Future<String> getInvoiceNumber({required Order order});
}
