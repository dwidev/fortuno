import 'package:fortuno/features/payments/domain/usecase/show_invoice.dart';

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
  final ShowInvoice showInvoice;

  OrderProcessBloc({
    required this.getOrdersByCompanyId,
    required this.updateStatusOrder,
    required this.showInvoice,
  }) : super(OrderProcessInitial(order: Order.init())) {
    on<OnGetOrders>(_onGetOrders);
    on<GoToOrderDetails>((event, emit) {
      emit(state.copyWith(order: event.order));
    });
    on<OnUpdateStatusOrder>(_onUpdateStatus);
    on<ShowInvoiceOrder>(_onShowInvoice);
  }

  Future<void> _onGetOrders(OnGetOrders event, Emitter emit) async {
    emit(OrderProcessInitial(order: Order.init()));

    final response = await runUsecase(() {
      final params = GetOrdersParams(status: event.status);
      return getOrdersByCompanyId(params);
    }, emit);

    response.fold((err) => error(emit, err), (right) {
      emit(state.copyWith(orders: right));
    });
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

  Future<void> _onShowInvoice(ShowInvoiceOrder event, Emitter emit) async {
    await runUsecase(() => showInvoice(event.order), emit);
  }
}
