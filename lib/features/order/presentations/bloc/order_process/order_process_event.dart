part of 'order_process_bloc.dart';

sealed class OrderProcessEvent extends BaseEvent {
  const OrderProcessEvent();

  @override
  List<Object> get props => [];
}

final class OnGetOrders extends OrderProcessEvent {
  final OrderStatus status;

  const OnGetOrders({required this.status});
}

final class GoToOrderDetails extends OrderProcessEvent {
  final Order order;

  const GoToOrderDetails({required this.order});
}

final class OnUpdateStatusOrder extends OrderProcessEvent
    implements UpdateStatusOrderParams {
  @override
  final String orderID;
  @override
  final OrderStatus newStatus;
  @override
  final PaymentOption paymentOption;

  const OnUpdateStatusOrder({
    required this.orderID,
    required this.newStatus,
    required this.paymentOption,
  });
}
