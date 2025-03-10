import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/bloc/base_bloc.dart';
import '../../../../core/failures/failure.dart';
import '../../../products/domain/entities/category.dart';
import '../../../products/domain/usecases/get_category_by_companyid.dart';

part 'order_event.dart';
part 'order_state.dart';

@injectable
class OrderBloc extends BaseAppBloc<OrderEvent, OrderState> {
  final GetCategoryByCompanyId getCategoryByCompanyId;

  OrderBloc({required this.getCategoryByCompanyId}) : super(OrderInitial()) {
    on<OnInitOrderPageEvent>(_onInit);
  }

  Future<void> _onInit(OnInitOrderPageEvent event, Emitter emit) async {
    final responses = await runUsecases([
      () => getCategoryByCompanyId(event.companyId),
    ], emit);

    final resCat = responses[0];

    resCat.fold(
      (err) {
        error(emit, err);
      },
      (right) {
        emit(OrderInitSuccess(categories: right));
      },
    );
  }
}
