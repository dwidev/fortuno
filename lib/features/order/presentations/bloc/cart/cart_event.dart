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

final class RemoveProductFromCart extends AddProductToCartEvent {
  const RemoveProductFromCart({
    super.categoryProduct,
    super.product,
    super.package,
    super.quantity = 0,
  });
}

final class ResetCart extends CartEvent {
  const ResetCart();
}
