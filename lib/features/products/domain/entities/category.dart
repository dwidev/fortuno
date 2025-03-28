// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @override
  CategoryProduct copyWith({
    String? id,
    String? name,
    String? code,
    double? price,
    String? createAt,
    bool? haveProduct,
  }) {
    return CategoryProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      price: price ?? this.price,
      createAt: createAt ?? this.createAt,
      haveProduct: haveProduct ?? this.haveProduct,
    );
  }
}
