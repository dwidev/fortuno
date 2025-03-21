import '../../../../../core/core.dart';
import '../../../../products/domain/entities/category.dart';
import '../../../../products/domain/entities/package.dart';
import '../../../../products/domain/entities/product.dart';
import '../../../domain/entities/order_item.dart';
import '../../../domain/usecases/cache_order_from_cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

@injectable
class CartBloc extends BaseAppBloc<CartEvent, CartState> {
  final CacheOrderFromCart cacheOrderFromCart;
  CartBloc({required this.cacheOrderFromCart}) : super(CartInitial()) {
    on<AddProductToCartEvent>(_onAddItem);
    on<RemoveProductFromCart>(_onRemoveItem);
    on<ResetCart>((event, emit) => emit(CartInitial()));
  }

  Future<void> _onAddItem(AddProductToCartEvent event, Emitter emit) async {
    final newItem = OrderItem(
      category: event.categoryProduct,
      product: event.product,
      package: event.package,
      quantity: event.quantity,
    );

    late AddedToCart newState;

    if (state.items.isEmpty) {
      newState = AddedToCart(newItem: newItem, items: [newItem]);
    } else {
      final indexUpdated = state.items.indexWhere(
        (e) => e.id == newItem.package?.id || e.id == newItem.product?.id,
      );

      if (indexUpdated != -1) {
        final (items, update) = _updateQuantityItem(
          newItem: newItem,
          quantity: event.quantity,
        );
        newState = (state as AddedToCart).copyWith(
          newItem: update,
          items: items,
        );
      } else {
        newState = (state as AddedToCart).copyWith(
          newItem: newItem,
          items: [newItem, ...state.items],
        );
      }
    }

    final cache = CacheOrderFromCartParams(
      categoryId: event.categoryProduct?.id ?? "",
      orders: newState.items,
    );
    cacheOrderFromCart(cache);
    emit(newState);
  }

  (List<OrderItem>, OrderItem) _updateQuantityItem({
    required OrderItem newItem,
    required int quantity,
  }) {
    OrderItem itemUpdated = newItem;

    final items =
        state.items.map((e) {
          if (e.id == newItem.package?.id || e.id == newItem.product?.id) {
            itemUpdated = newItem.copyWith(quantity: quantity);
            return itemUpdated;
          }

          return e;
        }).toList();

    return (items, itemUpdated);
  }

  Future<void> _onRemoveItem(RemoveProductFromCart event, Emitter emit) async {
    final removedItem = OrderItem(
      category: event.categoryProduct,
      product: event.product,
      package: event.package,
      quantity: 0,
    );

    final indexUpdated = state.items.indexWhere(
      (e) => e.id == event.package?.id || e.id == event.product?.id,
    );

    final items = state.items.toList();
    items.removeAt(indexUpdated);

    final newState = (state as AddedToCart).copyWith(
      items: items,
      newItem: removedItem,
    );

    final cache = CacheOrderFromCartParams(
      categoryId: event.categoryProduct?.id ?? "",
      orders: items,
    );
    cacheOrderFromCart(cache);

    emit(newState);
  }
}
