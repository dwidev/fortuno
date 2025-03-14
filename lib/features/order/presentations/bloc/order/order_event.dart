// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

sealed class OrderEvent extends BaseEvent {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OnInitOrderPageEvent extends OrderEvent {
  final String companyId;

  const OnInitOrderPageEvent({required this.companyId});
}

class OnClickCategory extends OrderEvent {
  final CategoryProduct categoryProduct;

  const OnClickCategory({required this.categoryProduct});
}

class OnBackToCategory extends OrderEvent {
  const OnBackToCategory();
}

class OnAddQuantity extends OrderEvent {
  final String id;
  final int quantity;

  const OnAddQuantity(this.id, this.quantity);
}

class OnFinishSelectedProduct extends OrderEvent {
  final bool isFinish;
  const OnFinishSelectedProduct({required this.isFinish});
}
