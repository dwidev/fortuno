part of 'order_bloc.dart';

class OrderState extends BaseState {
  final List<CategoryProduct> categories;
  final Map<String, int> productCountCart;
  final bool finishSelected;

  const OrderState({
    this.categories = const [],
    this.productCountCart = const {},
    this.finishSelected = false,
    super.error,
    super.loading,
  });

  @override
  List<Object?> get props => [categories, finishSelected, ...super.props];

  @override
  OrderState copyWith({
    List<CategoryProduct>? categories,
    LoadingOpts? loading,
    ValueGetter<Failure?>? error,
    Map<String, int>? productCountCart,
    bool? finishSelected,
  }) {
    return OrderState(
      categories: categories ?? this.categories,
      loading: loading ?? this.loading,
      error: error != null ? error.call() : this.error,
      productCountCart: productCountCart ?? this.productCountCart,
      finishSelected: finishSelected ?? this.finishSelected,
    );
  }
}

final class OrderInitial extends OrderState {
  const OrderInitial({super.categories = const []});
}

final class OrderInitSuccess extends OrderState {
  const OrderInitSuccess({
    required super.categories,
    required super.productCountCart,
    required super.finishSelected,
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
    required super.finishSelected,
    this.products = const [],
    this.packages = const [],
  });

  @override
  AtProductPage copyWith({
    CategoryProduct? categoryProduct,
    bool? finishSelected,
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
      finishSelected: finishSelected ?? this.finishSelected,
    );
  }

  @override
  List<Object?> get props => [
    categoryProduct,
    finishSelected,
    packages,
    packages,
    productCountCart,
  ];
}
