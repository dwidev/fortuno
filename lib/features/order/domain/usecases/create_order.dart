import 'package:either_dart/either.dart';
import 'package:fortuno/core/core.dart';
import 'package:fortuno/core/usecases/base_usecase.dart';
import 'package:fortuno/features/order/domain/entities/order.dart';
import 'package:fortuno/features/order/domain/repository/order_repository.dart';

@lazySingleton
class CreateOrder extends BaseUsecase<void, Order> {
  final OrderRepository orderRepository;

  CreateOrder({required this.orderRepository});
  @override
  FutureReturn<void> calling(Order params) async {
    await orderRepository.onCrateOrder(order: params);
    return Right(null);
  }
}
