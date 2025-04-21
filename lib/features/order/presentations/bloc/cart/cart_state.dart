part of 'cart_bloc.dart';

class CartState extends BaseState {
  final List<OrderItem> items;

  const CartState({this.items = const []});

  bool isCustomePackages({required String itemId, required String productId}) {
    if (items.isEmpty) return false;
    final item = items.where((e) => e.id == itemId).firstOrNull;
    if (item == null) return false;
    if (item.product != null) return false;
    return item.package?.items.where((e) => e.id == productId).firstOrNull !=
        null;
  }

  @override
  List<Object?> get props => [items];

  @override
  CartState copyWith({
    LoadingOpts? loading,
    ValueGetter<Failure?>? error,
    List<OrderItem>? items,
  }) {
    return CartState(items: items ?? this.items);
  }
}

final class CartInitial extends CartState {}

final class AddedToCart extends CartState {
  final OrderItem? newItem;

  const AddedToCart({this.newItem, super.items});

  @override
  AddedToCart copyWith({
    OrderItem? newItem,
    LoadingOpts? loading,
    ValueGetter<Failure?>? error,
    List<OrderItem>? items,
  }) {
    return AddedToCart(
      newItem: newItem ?? this.newItem,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [newItem, super.props];
}
