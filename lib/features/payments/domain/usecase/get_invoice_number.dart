import 'package:either_dart/either.dart';

import '../../../../core/core.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../../../order/domain/entities/order.dart';
import '../repository/payment_repository.dart';

@lazySingleton
class GetInvoiceNumber extends BaseUsecase<String, Order> {
  final PaymentRepository paymentRepository;

  GetInvoiceNumber({required this.paymentRepository});

  @override
  FutureReturn<String> calling(Order params) async {
    final invNumber = await paymentRepository.getInvoiceNumber(order: params);
    return Right(invNumber);
  }
}
