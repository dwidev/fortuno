import '../entities/inovice.dart';

abstract class PaymentRepostiroy {
  Future<Invoice> getInvoice({required String orderID});
}
