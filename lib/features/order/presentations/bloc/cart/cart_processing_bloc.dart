import 'dart:async';

import '../../../../../core/core.dart';
import '../../../domain/entities/client_order.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/entities/order_item.dart';
import '../../../domain/usecases/create_order.dart';

part 'cart_processing_event.dart';
part 'cart_processing_state.dart';

@injectable
class CartProcessingBloc
    extends BaseAppBloc<CartProcessingEvent, CartProcessingState> {
  final CreateOrder createOrder;

  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController dateController;
  late TextEditingController timeController;
  late TextEditingController addressController;
  late TextEditingController rtController;
  late TextEditingController rwController;
  late TextEditingController detailAddressController;
  late TextEditingController shippingCostController;

  double firstTotalPrice = 0.0;

  ClientOrder get client => state.order.client;
  Order get order => state.order;

  CartProcessingBloc({required this.createOrder})
    : super(CartProcessingInitial(order: Order.init())) {
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    dateController = TextEditingController();
    timeController = TextEditingController();
    addressController = TextEditingController();
    rtController = TextEditingController();
    rwController = TextEditingController();
    detailAddressController = TextEditingController();
    shippingCostController = TextEditingController();

    on<OnAddOrderItemsEvent>(_onAddOrderItems);
    on<OnChangeShippingConstEvent>(_onChangeShippingCost);
    on<OnCreateOrder>(_onCreateOrder);
    on<ResetProcessingOrder>((event, emit) {
      clearResources();
      emit(CartProcessingInitial(order: Order.init()));
    });
  }

  Future<void> _onCreateOrder(OnCreateOrder event, Emitter emit) async {
    final res = await runUsecase(() => createOrder(event.order), emit);

    res.fold((left) => error(emit, left), (_) {
      emit(CartDoneCreateOrder(order: state.order));
    });
  }

  void _onAddOrderItems(OnAddOrderItemsEvent event, Emitter emit) {
    // create client order
    final date = mergeDateAndTime(dateController.text, timeController.text);
    final newClient = state.order.client.copyWith(
      name: nameController.text,
      phoneNumber: phoneController.text,
      sendDate: date,
      address: addressController.text,
      rw: rwController.text,
      rt: rtController.text,
      detailAddress: detailAddressController.text,
    );

    // create price
    final itemTotalPrice = event.items.totalPrice;
    final shippingCost = double.tryParse(shippingCostController.text) ?? 0;
    final discount = 0.0; // cuurently cannot setup for this
    final totalPrice = itemTotalPrice + shippingCost + discount;

    // set total price
    firstTotalPrice = totalPrice;

    final newOrder = state.order.copyWith(
      items: event.items,
      client: newClient,
      shippingCost: shippingCost,
      discount: discount,
      totalPrice: totalPrice,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    emit(state.copyWith(order: () => newOrder));
  }

  void _onChangeShippingCost(OnChangeShippingConstEvent event, Emitter emit) {
    final shippingCost = double.tryParse(event.cost) ?? 0;
    final newTotal = firstTotalPrice + shippingCost;

    final newShipping = state.order.copyWith(
      totalPrice: newTotal,
      shippingCost: shippingCost,
    );
    emit(state.copyWith(order: () => newShipping));
  }

  void clearResources() {
    nameController.clear();
    phoneController.clear();
    dateController.clear();
    timeController.clear();
    addressController.clear();
    rtController.clear();
    rwController.clear();
    detailAddressController.clear();
    shippingCostController.clear();
  }

  @override
  Future<void> close() async {
    clearResources();
    super.close();
  }
}
