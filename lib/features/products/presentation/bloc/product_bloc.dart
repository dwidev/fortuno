// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortuno/core/usecases/base_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/bloc/base_bloc.dart';
import '../../../../core/failures/failure.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/package.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_category_by_companyid.dart';
import '../../domain/usecases/get_package_by_categoryid.dart';
import '../../domain/usecases/get_products_by_categoryid.dart';
import '../../domain/usecases/get_products_by_company.dart';

part 'product_event.dart';
part 'product_state.dart';

@injectable
class ProductsBloc extends BaseAppBloc<ProductEvent, ProductState> {
  final GetCategoryByCompanyId getCategoryByCompanyId;
  final GetProductsByCompany getProductsByCompany;
  final GetProductsByCategoryId getProductsByCategoryId;
  final GetPackageByCategoryid getPackageByCategoryid;

  ProductsBloc({
    required this.getCategoryByCompanyId,
    required this.getProductsByCompany,
    required this.getProductsByCategoryId,
    required this.getPackageByCategoryid,
  }) : super(ProductInitial()) {
    on<OnInitInvetoryPageEvent>(_onInit);
  }

  Future<void> _onInit(OnInitInvetoryPageEvent event, Emitter emit) async {
    final responses = await runUsecases([
      () => getCategoryByCompanyId(null),
      () => getProductsByCompany(null),
    ], emit);

    final resCat = responses[0] as ReturnFailure<List<CategoryProduct>>;
    final resProducts = responses[1];

    Failure? failure;

    final cat = resCat.fold((err) {
      failure = err;
      return null;
    }, (data) => data);

    final products = resProducts.fold((err) {
      failure = err;
      return null;
    }, (data) => data);

    if (failure != null) {
      error(emit, failure!);
      return;
    }

    final newState = state.copyWith(categories: cat, products: products);
    emit(newState);
  }
}
