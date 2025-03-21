// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:either_dart/either.dart';

import 'package:fortuno/features/payments/domain/repository/payment_repository.dart';

import '../../../../core/core.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../../../payments/domain/entities/payment.dart';
import '../../../payments/presentation/widgets/process_order_dialog.dart';
import '../enums/order_status.dart';
import '../repository/order_repository.dart';

@lazySingleton
class UpdateStatusOrder extends BaseUsecase<void, UpdateStatusOrderParams> {
  final OrderRepository orderRepository;
  final PaymentRepository paymentRepository;

  UpdateStatusOrder({
    required this.orderRepository,
    required this.paymentRepository,
  });

  @override
  FutureReturn<void> calling(UpdateStatusOrderParams params) async {
    await paymentRepository.savePayment(payment: params.payment);
    await orderRepository.updateOrderStatus(
      newStatus: params.newStatus,
      option: params.result.option,
      orderID: params.orderID,
    );
    return Right(null);
  }
}

class UpdateStatusOrderParams {
  final OrderStatus newStatus;
  final String orderID;
  final ProcessOrderDialogResult result;
  final Payment payment;

  UpdateStatusOrderParams({
    required this.newStatus,
    required this.orderID,
    required this.result,
    required this.payment,
  });
}
