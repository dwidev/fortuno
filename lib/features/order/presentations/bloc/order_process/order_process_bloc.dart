import '../../../../../core/core.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/usecases/get_orders_by_company_id.dart';

part 'order_process_event.dart';
part 'order_process_state.dart';

@injectable
class OrderProcessBloc
    extends BaseAppBloc<OrderProcessEvent, OrderProcessState> {
  final GetOrdersByCompanyId getOrdersByCompanyId;

  OrderProcessBloc({required this.getOrdersByCompanyId})
    : super(OrderProcessInitial(order: Order.init())) {
    on<OnGetOrders>(_onGetOrders);
    on<GoToOrderDetails>((event, emit) {
      emit(state.copyWith(order: event.order));
    });
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
}
