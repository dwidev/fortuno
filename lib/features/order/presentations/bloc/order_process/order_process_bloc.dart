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
    : super(OrderProcessInitial()) {
    on<OnGetOrders>(_onGetOrders);
  }

  Future<void> _onGetOrders(OnGetOrders event, Emitter emit) async {
    final response = await runUsecase(
      () => getOrdersByCompanyId("898a70b4-0758-4eda-bf73-b469db14eb50"),
      emit,
    );

    response.fold(
      (err) => error(emit, err),
      (right) => state.copyWith(orders: right),
    );
  }
}
