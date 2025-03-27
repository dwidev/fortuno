import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart' hide Order;

import '../../../../core/usecases/base_usecase.dart';
import '../../../order/domain/entities/order.dart';
import '../../invoice_service.dart';
import '../repository/payment_repository.dart';

@lazySingleton
class ShowInvoice extends BaseUsecase<void, Order> {
  final PaymentRepository paymentRepository;

  ShowInvoice({required this.paymentRepository});

  @override
  FutureReturn<void> calling(Order params) async {
    final invoice = await paymentRepository.getInvoice(orderID: params.id);
    await InvoiceService.showPdf(params, invoice);
    return Right(null);
  }
}
