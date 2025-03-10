// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fortuno/core/failures/failure.dart';
import 'package:fortuno/features/products/domain/usecases/get_category_by_companyid.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/bloc/base_bloc.dart';
import '../../../products/domain/entities/category.dart';

part 'order_event.dart';
part 'order_state.dart';

@injectable
class OrderBloc extends BaseAppBloc<OrderEvent, OrderState> {
  final GetCategoryByCompanyId getCategoryByCompanyId;

  OrderBloc({required this.getCategoryByCompanyId}) : super(OrderInitial()) {
    on<OnInitOrderPageEvent>(_onInit);
  }

  Future<void> _onInit(event, emit) async {
    final responses = await runUsecases([
      () => getCategoryByCompanyId("898a70b4-0758-4eda-bf73-b469db14eb50"),
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
