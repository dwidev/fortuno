part of 'order_bloc.dart';

class OrderState extends BaseState {
  final List<CategoryProduct> categories;

  const OrderState({this.categories = const [], super.error, super.loading});

  @override
  List<Object?> get props => [categories, ...super.props];

  @override
  OrderState copyWith({
    List<CategoryProduct>? categories,
    LoadingOpts? loading,
    Failure? error,
  }) {
    return OrderState(
      categories: categories ?? this.categories,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}

final class OrderInitial extends OrderState {}

final class OrderInitSuccess extends OrderState {
  const OrderInitSuccess({required super.categories});
}
