// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortuno/core/usecases/base_usecase.dart';
import 'package:fortuno/features/products/domain/entities/package.dart';
import 'package:fortuno/features/products/domain/usecases/get_package_by_categoryid.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/bloc/base_bloc.dart';
import '../../../../core/failures/failure.dart';
import '../../../products/domain/entities/category.dart';
import '../../../products/domain/entities/product.dart';
import '../../../products/domain/usecases/get_category_by_companyid.dart';
import '../../../products/domain/usecases/get_products_by_categoryid.dart';

part 'order_event.dart';
part 'order_state.dart';

@injectable
class OrderBloc extends BaseAppBloc<OrderEvent, OrderState> {
  final GetCategoryByCompanyId getCategoryByCompanyId;
  final GetProductsByCategoryId getProductsByCategoryId;
  final GetPackageByCategoryid getPackageByCategoryid;

  OrderBloc({
    required this.getCategoryByCompanyId,
    required this.getProductsByCategoryId,
    required this.getPackageByCategoryid,
  }) : super(OrderInitial()) {
    on<OnInitOrderPageEvent>(_onInit);
    on<OnClickCategory>(_onClickCategory);
    on<OnBackToCategory>((event, emit) {
      emit(OrderInitSuccess(categories: state.categories));
    });
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

  Future<void> _onClickCategory(OnClickCategory event, Emitter emit) async {
    final responses = await runUsecases([
      () => getProductsByCategoryId(event.categoryProduct.id),
      () => getPackageByCategoryid(event.categoryProduct.id),
    ], emit);

    final resCat = responses[0] as ReturnFailure<List<Product>>;
    final resPac = responses[1] as ReturnFailure<List<Package>>;

    resCat.fold(
      (err) {
        error(emit, err);
      },
      (data) {
        emit(
          AtProductPage(
            categoryProduct: event.categoryProduct,
            categories: state.categories,
            products: data,
          ),
        );
      },
    );

    resPac.fold((err) {
      error(emit, err);
    }, (data) {});
  }
}
