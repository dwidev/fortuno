part of 'cart_bloc.dart';

class CartState extends BaseState {
  final List<OrderItem> items;

  const CartState({this.items = const []});

  @override
  List<Object> get props => [items];

  @override
  BaseState copyWith({
    LoadingOpts? loading,
    ValueGetter<Failure?>? error,
    List<OrderItem>? items,
  }) {
    return CartState(items: items ?? this.items);
  }
}

final class CartInitial extends CartState {}
