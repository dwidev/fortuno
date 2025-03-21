import 'package:either_dart/either.dart';

import '../../../../core/core.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../../../payments/presentation/widgets/process_order_dialog.dart';
import '../enums/order_status.dart';
import '../repository/order_repository.dart';

@lazySingleton
class UpdateStatusOrder extends BaseUsecase<void, UpdateStatusOrderParams> {
  final OrderRepository orderRepository;

  UpdateStatusOrder({required this.orderRepository});
  @override
  FutureReturn<void> calling(UpdateStatusOrderParams params) async {
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

  UpdateStatusOrderParams({
    required this.newStatus,
    required this.orderID,
    required this.result,
  });
}
