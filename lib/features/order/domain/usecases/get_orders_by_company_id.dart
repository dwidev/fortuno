import 'package:either_dart/either.dart';
import 'package:fortuno/core/core.dart';
import 'package:fortuno/core/usecases/base_usecase.dart';
import 'package:fortuno/features/order/domain/entities/order.dart';
import 'package:fortuno/features/order/domain/enums/order_status.dart';
import 'package:fortuno/features/order/domain/repository/order_repository.dart';

@lazySingleton
class GetOrdersByCompanyId extends BaseUsecase<List<Order>, GetOrdersParams> {
  final OrderRepository orderRepository;

  GetOrdersByCompanyId({required this.orderRepository});

  @override
  FutureReturn<List<Order>> calling(GetOrdersParams params) async {
    final result = await orderRepository.getOrdersByStatus(
      status: params.status,
    );
    return Right(result);
  }
}

class GetOrdersParams {
  final OrderStatus status;

  GetOrdersParams({required this.status});
}
