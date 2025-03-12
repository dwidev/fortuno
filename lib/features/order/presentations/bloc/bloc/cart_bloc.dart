import 'package:bloc/bloc.dart';
import 'package:fortuno/core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/bloc/base_bloc.dart';
import '../../../../../core/failures/failure.dart';
import '../../../../products/domain/entities/category.dart';
import '../../../../products/domain/entities/package.dart';
import '../../../../products/domain/entities/product.dart';
import '../../../domain/entities/order_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

@injectable
class CartBloc extends BaseAppBloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddProductToCartEvent>(_onAddItem);
  }

  Future<void> _onAddItem(AddProductToCartEvent event, Emitter emit) async {
    final newItem = OrderItem(
      category: event.categoryProduct,
      product: event.product,
      package: event.package,
    );
    final newState = state.copyWith(items: [...state.items, newItem]);

    emit(newState);
  }
}
