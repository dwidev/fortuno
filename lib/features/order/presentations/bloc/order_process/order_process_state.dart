part of 'order_process_bloc.dart';

class OrderProcessState extends BaseState {
  final List<Order> orders;

  const OrderProcessState({this.orders = const []});

  @override
  List<Object> get props => [];

  @override
  OrderProcessState copyWith({
    List<Order>? orders,
    LoadingOpts? loading,
    ValueGetter<Failure?>? error,
  }) {
    return OrderProcessState(orders: orders ?? this.orders);
  }
}

final class OrderProcessInitial extends OrderProcessState {}
