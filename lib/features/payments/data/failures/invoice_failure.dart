import 'package:fortuno/core/core.dart';

abstract class InvoiceFailure extends Failure {
  InvoiceFailure(super.message);
}

class InvoiceNotFound extends InvoiceFailure {
  InvoiceNotFound() : super("Invoice tidak ditemukan");
}
