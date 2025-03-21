import 'package:fortuno/features/order/domain/entities/order.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/core.dart';
import '../model/payment_model.dart';
import '../../domain/entities/payment.dart';

import '../../domain/entities/inovice.dart';
import '../../domain/repository/payment_repository.dart';
import '../datasource/payment_datasource.dart';

@LazySingleton(as: PaymentRepository)
class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentDatasource paymentDatasource;

  PaymentRepositoryImpl({required this.paymentDatasource});

  @override
  Future<Invoice> getInvoice({required String orderID}) async {
    final model = await paymentDatasource.getInvoice(orderID: orderID);
    return model.toEntity();
  }

  @override
  Future<void> savePayment({required Payment payment}) {
    final model = PaymentModel(
      id: Uuid().v4(),
      invoiceId: payment.invoiceId,
      amount: payment.amount,
      paymentMethod: payment.paymentMethod.name,
      paymentDate: payment.paymentDate.toUtc().toIso8601String(),
    );

    return paymentDatasource.savePayment(model: model);
  }

  @override
  Future<String> getInvoiceNumber({required Order order}) {
    return paymentDatasource.getInvoiceNumber(order: order);
  }
}
