import 'product.dart';

class CategoryProduct extends Product {
  final bool haveProduct;

  const CategoryProduct({
    required super.id,
    required super.name,
    required super.code,
    required super.price,
    required super.createAt,
    required this.haveProduct,
  });

  const CategoryProduct.initial({
    super.id = '',
    super.name = '',
    super.code = '',
    super.price = 0.0,
    super.createAt = '',
    this.haveProduct = false,
  });

  @override
  List<Object?> get props => [...super.props, haveProduct];
}
