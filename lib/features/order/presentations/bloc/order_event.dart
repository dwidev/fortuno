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
