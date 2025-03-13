import 'package:either_dart/either.dart';
import 'package:fortuno/core/usecases/base_usecase.dart';
import 'package:fortuno/features/order/domain/entities/order_item.dart';
import 'package:fortuno/features/order/domain/repository/order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CacheOrderFromCart extends BaseUsecase<void, CacheOrderFromCartParams> {
  final OrderRepository orderRepository;

  CacheOrderFromCart({required this.orderRepository});

  @override
  FutureReturn<void> calling(CacheOrderFromCartParams params) async {
    orderRepository.cacheOrder(
      orders: params.orders,
      categoryId: params.categoryId,
    );
    return Right(null);
  }
}

class CacheOrderFromCartParams {
  final String categoryId;
  final List<OrderItem> orders;

  CacheOrderFromCartParams({required this.categoryId, required this.orders});
}
