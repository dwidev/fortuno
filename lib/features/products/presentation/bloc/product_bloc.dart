import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/bloc/base_bloc.dart';
import '../../../../core/failures/failure.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/package.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_category_by_companyid.dart';
import '../../domain/usecases/get_package_by_categoryid.dart';
import '../../domain/usecases/get_products_by_categoryid.dart';

part 'product_event.dart';
part 'product_state.dart';

@injectable
class ProductsBloc extends BaseAppBloc<ProductEvent, ProductState> {
  final GetCategoryByCompanyId getCategoryByCompanyId;
  final GetProductsByCategoryId getProductsByCategoryId;
  final GetPackageByCategoryid getPackageByCategoryid;

  ProductsBloc({
    required this.getCategoryByCompanyId,
    required this.getProductsByCategoryId,
    required this.getPackageByCategoryid,
  }) : super(ProductInitial()) {
    on<OnInitInvetoryPageEvent>(_onInit);
  }

  Future<void> _onInit(OnInitInvetoryPageEvent event, Emitter emit) async {
    final responses = await runUsecases([
      () => getCategoryByCompanyId(null),
    ], emit);

    final resCat = responses[0];

    resCat.fold(
      (err) {
        error(emit, err);
      },
      (data) {
        final newState = state.copyWith(categories: data);
        emit(newState);
      },
    );
  }
}
