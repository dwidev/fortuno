part of 'product_bloc.dart';

class ProductState extends BaseState {
  final List<CategoryProduct> categories;
  final List<Product> products;
  final List<Package> packages;

  const ProductState({
    this.categories = const [],
    this.products = const [],
    this.packages = const [],
    super.loading,
    super.error,
  });

  @override
  List<Object?> get props => [categories, products, packages, ...super.props];

  @override
  ProductState copyWith({
    List<CategoryProduct>? categories,
    List<Product>? products,
    List<Package>? packages,
    LoadingOpts? loading,
    ValueGetter<Failure?>? error,
  }) {
    return ProductState(
      categories: categories ?? this.categories,
      loading: loading ?? this.loading,
      error: error != null ? error.call() : this.error,
      products: products ?? this.products,
      packages: packages ?? this.packages,
    );
  }
}

final class ProductInitial extends ProductState {
  const ProductInitial({super.categories = const []});
}

class OnSavedForm extends ProductState {
  const OnSavedForm({
    required super.categories,
    required super.products,
    required super.packages,
    super.loading,
    super.error,
  });
}
