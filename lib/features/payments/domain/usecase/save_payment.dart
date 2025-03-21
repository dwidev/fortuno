import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/base_usecase.dart';
import '../entities/payment.dart';
import '../repository/payment_repository.dart';

@lazySingleton
class SavePayment extends BaseUsecase<void, Payment> {
  final PaymentRepostiroy paymentRepostiroy;

  SavePayment({required this.paymentRepostiroy});

  @override
  FutureReturn<void> calling(Payment params) async {
    await paymentRepostiroy.savePayment(payment: params);
    return Right(null);
  }
}
