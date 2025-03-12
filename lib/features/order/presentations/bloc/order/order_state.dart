part of 'order_bloc.dart';

class OrderState extends BaseState {
  final List<CategoryProduct> categories;

  const OrderState({this.categories = const [], super.error, super.loading});

  @override
  List<Object?> get props => [categories];

  @override
  OrderState copyWith({
    List<CategoryProduct>? categories,
    LoadingOpts? loading,
    ValueGetter<Failure?>? error,
  }) {
    return OrderState(
      categories: categories ?? this.categories,
      loading: loading ?? this.loading,
      error: error != null ? error.call() : this.error,
    );
  }
}

final class OrderInitial extends OrderState {}

final class OrderInitSuccess extends OrderState {
  const OrderInitSuccess({required super.categories});
}

final class AtProductPage extends OrderState {
  final CategoryProduct categoryProduct;
  final List<Product> products;
  final List<Package> packages;

  const AtProductPage({
    required this.categoryProduct,
    this.products = const [],
    this.packages = const [],
    super.categories,
  });

  @override
  AtProductPage copyWith({
    CategoryProduct? categoryProduct,
    List<Product>? products,
    List<Package>? packages,
    List<CategoryProduct>? categories,
    LoadingOpts? loading,
    ValueGetter<Failure?>? error,
  }) {
    return AtProductPage(
      categoryProduct: categoryProduct ?? this.categoryProduct,
      products: products ?? this.products,
      packages: packages ?? this.packages,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [categoryProduct, packages, packages];
}
