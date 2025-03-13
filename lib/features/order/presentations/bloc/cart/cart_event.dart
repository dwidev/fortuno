part of 'cart_bloc.dart';

sealed class CartEvent extends BaseEvent {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

final class AddProductToCartEvent extends CartEvent {
  final CategoryProduct? categoryProduct;
  final Product? product;
  final Package? package;
  final int quantity;

  const AddProductToCartEvent({
    required this.quantity,
    this.product,
    this.package,
    this.categoryProduct,
  });
}
