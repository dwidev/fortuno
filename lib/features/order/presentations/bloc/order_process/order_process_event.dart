part of 'order_process_bloc.dart';

sealed class OrderProcessEvent extends BaseEvent {
  const OrderProcessEvent();

  @override
  List<Object> get props => [];
}

final class OnGetOrders extends OrderProcessEvent {
  const OnGetOrders();
}
