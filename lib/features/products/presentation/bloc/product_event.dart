// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

sealed class ProductEvent extends BaseEvent {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class OnInitInvetoryPageEvent extends ProductEvent {
  const OnInitInvetoryPageEvent();
}

class OnAddProduct extends ProductEvent {
  final Product product;
  final CategoryProduct? category;
  final XFile? productImage;

  const OnAddProduct({required this.product, this.category, this.productImage});
}

class OnAddCategory extends ProductEvent {
  final CategoryProduct category;
  final XFile? image;

  const OnAddCategory({required this.category, this.image});
}

abstract class OnDelete extends ProductEvent {
  final String id;

  const OnDelete({required this.id});
}

class OnDeleteCategory extends OnDelete {
  const OnDeleteCategory({required super.id});
}
