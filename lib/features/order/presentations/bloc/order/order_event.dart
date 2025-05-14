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

class OnFinishSelectedProduct extends OrderEvent {
  final bool isFinish;
  const OnFinishSelectedProduct({required this.isFinish});
}

class ResetOrder extends OrderEvent {
  const ResetOrder();
}

class OnPreparationCustomPackage extends OrderEvent {
  final Package seletedPackage;

  const OnPreparationCustomPackage(this.seletedPackage);
}

class OnSaveCustomePackage extends OrderEvent {
  const OnSaveCustomePackage();
}

class OnUpdateOrderItems extends OrderEvent {
  final OrderItem item;
  const OnUpdateOrderItems(this.item);
}
