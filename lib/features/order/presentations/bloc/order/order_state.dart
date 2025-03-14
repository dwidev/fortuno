part of 'order_bloc.dart';

class OrderState extends BaseState {
  final List<CategoryProduct> categories;
  final Map<String, int> productCountCart;

  const OrderState({
    this.categories = const [],
    this.productCountCart = const {},
    super.error,
    super.loading,
  });

  @override
  List<Object?> get props => [categories, ...super.props];

  @override
  OrderState copyWith({
    List<CategoryProduct>? categories,
    LoadingOpts? loading,
    ValueGetter<Failure?>? error,
    Map<String, int>? productCountCart,
  }) {
    return OrderState(
      categories: categories ?? this.categories,
      loading: loading ?? this.loading,
      error: error != null ? error.call() : this.error,
      productCountCart: productCountCart ?? this.productCountCart,
    );
  }
}

final class OrderInitial extends OrderState {}

final class OrderInitSuccess extends OrderState {
  const OrderInitSuccess({
    required super.categories,
    required super.productCountCart,
  });
}

final class AtProductPage extends OrderState {
  final CategoryProduct categoryProduct;
  final List<Product> products;
  final List<Package> packages;

  const AtProductPage({
    required this.categoryProduct,
    required super.categories,
    required super.productCountCart,
    this.products = const [],
    this.packages = const [],
  });

  @override
  AtProductPage copyWith({
    CategoryProduct? categoryProduct,
    List<Product>? products,
    List<Package>? packages,
    List<CategoryProduct>? categories,
    LoadingOpts? loading,
    ValueGetter<Failure?>? error,
    Map<String, int>? productCountCart,
  }) {
    return AtProductPage(
      categoryProduct: categoryProduct ?? this.categoryProduct,
      productCountCart: productCountCart ?? this.productCountCart,
      products: products ?? this.products,
      packages: packages ?? this.packages,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [
    categoryProduct,
    packages,
    packages,
    productCountCart,
  ];
}
