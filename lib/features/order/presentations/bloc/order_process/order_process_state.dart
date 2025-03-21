part of 'order_process_bloc.dart';

class OrderProcessState extends BaseState {
  final List<Order> orders;
  final Order order;

  const OrderProcessState({
    this.orders = const [],
    required this.order,
    super.loading,
    super.error,
  });

  @override
  List<Object?> get props => [orders, order, ...super.props];

  @override
  OrderProcessState copyWith({
    Order? order,
    List<Order>? orders,
    LoadingOpts? loading,
    ValueGetter<Failure?>? error,
  }) {
    return OrderProcessState(
      order: order ?? this.order,
      orders: orders ?? this.orders,
      loading: loading ?? this.loading,
      error: error != null ? error() : this.error,
    );
  }
}

final class OrderProcessInitial extends OrderProcessState {
  const OrderProcessInitial({required super.order});
}
