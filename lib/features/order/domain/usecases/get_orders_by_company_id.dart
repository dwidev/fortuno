import 'package:either_dart/either.dart';
import 'package:fortuno/core/core.dart';
import 'package:fortuno/core/usecases/base_usecase.dart';
import 'package:fortuno/features/order/domain/entities/order.dart';
import 'package:fortuno/features/order/domain/repository/order_repository.dart';

@lazySingleton
class GetOrdersByCompanyId extends BaseUsecase<List<Order>, String> {
  final OrderRepository orderRepository;

  GetOrdersByCompanyId({required this.orderRepository});

  @override
  FutureReturn<List<Order>> calling(String params) async {
    final result = await orderRepository.getOrdersByCompanyID(
      companyID: params,
    );
    return Right(result);
  }
}
