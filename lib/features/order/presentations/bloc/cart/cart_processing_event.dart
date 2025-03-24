part of 'cart_processing_bloc.dart';

abstract class CartProcessingEvent extends BaseEvent {
  const CartProcessingEvent();
}

class OnAddOrderItemsEvent extends CartProcessingEvent {
  final List<OrderItem> items;

  const OnAddOrderItemsEvent({required this.items});

  @override
  List<Object?> get props => [items];
}

class OnChangeShippingConstEvent extends CartProcessingEvent {
  const OnChangeShippingConstEvent();

  @override
  List<Object?> get props => [];
}

class OnCreateOrder extends CartProcessingEvent {
  final Order order;

  const OnCreateOrder({required this.order});

  @override
  List<Object?> get props => [order];
}

class ResetProcessingOrder extends CartProcessingEvent {
  const ResetProcessingOrder();

  @override
  List<Object?> get props => [];
}
