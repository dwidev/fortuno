import '../../../../../core/core.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/enums/order_status.dart';
import '../../../domain/enums/payment_option.dart';
import '../../../domain/usecases/get_orders_by_company_id.dart';
import '../../../domain/usecases/update_status_order.dart';

part 'order_process_event.dart';
part 'order_process_state.dart';

@injectable
class OrderProcessBloc
    extends BaseAppBloc<OrderProcessEvent, OrderProcessState> {
  final GetOrdersByCompanyId getOrdersByCompanyId;
  final UpdateStatusOrder updateStatusOrder;

  OrderProcessBloc({
    required this.getOrdersByCompanyId,
    required this.updateStatusOrder,
  }) : super(OrderProcessInitial(order: Order.init())) {
    on<OnGetOrders>(_onGetOrders);
    on<GoToOrderDetails>((event, emit) {
      emit(state.copyWith(order: event.order));
    });
    on<OnUpdateStatusOrder>(_onUpdateStatus);
  }

  Future<void> _onGetOrders(OnGetOrders event, Emitter emit) async {
    final response = await runUsecase(
      () => getOrdersByCompanyId("898a70b4-0758-4eda-bf73-b469db14eb50"),
      emit,
    );

    response.fold(
      (err) => error(emit, err),
      (right) => emit(state.copyWith(orders: right)),
    );
  }

  Future<void> _onUpdateStatus(OnUpdateStatusOrder event, Emitter emit) async {
    final response = await runUsecase(() {
      final params = UpdateStatusOrderParams(
        newStatus: event.newStatus,
        orderID: event.orderID,
        paymentOption: event.paymentOption,
      );
      return updateStatusOrder(params);
    }, emit);

    response.fold((err) => error(emit, err), (right) {
      final newOrder = state.order.copyWith(orderStatus: event.newStatus);
      final newOrders = state.orders.toList();
      newOrders.removeWhere((e) => e.id == event.orderID);

      emit(state.copyWith(order: newOrder, orders: newOrders));
    });
  }
}
