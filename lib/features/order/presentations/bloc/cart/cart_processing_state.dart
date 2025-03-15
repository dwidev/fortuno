part of 'cart_processing_bloc.dart';

class CartProcessingState extends BaseState {
  final Order order;

  const CartProcessingState({required this.order});

  @override
  CartProcessingState copyWith({
    LoadingOpts? loading,
    ValueGetter<Failure?>? error,
    ValueGetter<Order>? order,
  }) {
    return CartProcessingState(order: order != null ? order() : this.order);
  }

  @override
  List<Object?> get props => [order, ...super.props];
}

class CartProcessingInitial extends CartProcessingState {
  const CartProcessingInitial({required super.order});
}
