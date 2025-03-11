import '../../../../core/bloc/base_bloc.dart';
import '../bloc/order_bloc.dart';

/// class for listen auth bloc
class OrderListenerWidget extends BaseListenerWidget<OrderBloc, OrderState> {
  const OrderListenerWidget({
    super.key,
    super.listener,
    required super.builder,
  });

  @override
  bool get overrideLoading => true;
}
