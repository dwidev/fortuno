import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/bloc/base_bloc.dart';
import '../../../../../core/failures/failure.dart';

part 'cart_processing_event.dart';
part 'cart_processing_state.dart';

@injectable
class CartProcessingBloc
    extends BaseAppBloc<CartProcessingEvent, CartProcessingState> {
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController dateController;
  late TextEditingController timeController;
  late TextEditingController addressController;
  late TextEditingController rtController;
  late TextEditingController rwController;
  late TextEditingController detailAddressController;

  CartProcessingBloc() : super(CartProcessingInitial()) {
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    dateController = TextEditingController();
    timeController = TextEditingController();
    addressController = TextEditingController();
    rtController = TextEditingController();
    rwController = TextEditingController();
    detailAddressController = TextEditingController();
  }

  void clearResource() {
    nameController.clear();
    phoneController.clear();
    dateController.clear();
    timeController.clear();
    addressController.clear();
    rtController.clear();
    rwController.clear();
    detailAddressController.clear();
  }

  @override
  Future<void> close() async {
    clearResource();
    super.close();
  }
}
