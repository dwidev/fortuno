part of 'cart_processing_bloc.dart';

class CartProcessingState extends BaseState {
  final Order order;

  const CartProcessingState({required this.order, super.loading, super.error});

  @override
  CartProcessingState copyWith({
    LoadingOpts? loading,
    ValueGetter<Failure?>? error,
    ValueGetter<Order>? order,
  }) {
    return CartProcessingState(
      order: order != null ? order() : this.order,
      loading: loading ?? this.loading,
      error: error != null ? error.call() : this.error,
    );
  }

  @override
  List<Object?> get props => [order, ...super.props];
}

class CartProcessingInitial extends CartProcessingState {
  const CartProcessingInitial({required super.order});
}

class CartDoneCreateOrder extends CartProcessingState {
  const CartDoneCreateOrder({required super.order});
}
