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

final class OnUpdateStatusOrder extends OrderProcessEvent {
  final String orderID;
  final String invoiceId;
  final OrderStatus newStatus;
  final ProcessOrderDialogResult result;

  const OnUpdateStatusOrder({
    required this.orderID,
    required this.invoiceId,
    required this.newStatus,
    required this.result,
  });
}

final class ShowInvoiceOrder extends OrderProcessEvent {
  final Order order;

  const ShowInvoiceOrder({required this.order});
}
