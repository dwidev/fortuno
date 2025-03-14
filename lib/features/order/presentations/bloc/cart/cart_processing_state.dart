part of 'cart_processing_bloc.dart';

class CartProcessingState extends BaseState {
  const CartProcessingState({super.loading, super.error});

  @override
  CartProcessingState copyWith({
    LoadingOpts? loading,
    ValueGetter<Failure?>? error,
  }) {
    return CartProcessingState();
  }
}

class CartProcessingInitial extends CartProcessingState {}
