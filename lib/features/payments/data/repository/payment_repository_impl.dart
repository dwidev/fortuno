import 'package:fortuno/core/core.dart';

import '../../domain/entities/inovice.dart';
import '../../domain/repository/payment_repository.dart';
import '../datasource/payment_datasource.dart';

@LazySingleton(as: PaymentRepostiroy)
class PaymentRepostiroyImpl extends PaymentRepostiroy {
  final PaymentDatasource paymentDatasource;

  PaymentRepostiroyImpl({required this.paymentDatasource});

  @override
  Future<Invoice> getInvoice({required String orderID}) async {
    final model = await paymentDatasource.getInvoice(orderID: orderID);
    return model.toEntity();
  }
}
