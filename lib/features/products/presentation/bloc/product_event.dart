part of 'product_bloc.dart';

sealed class ProductEvent extends BaseEvent {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class OnInitInvetoryPageEvent extends ProductEvent {
  const OnInitInvetoryPageEvent();
}
