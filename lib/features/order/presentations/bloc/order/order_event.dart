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
