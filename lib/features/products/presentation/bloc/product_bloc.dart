// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortuno/core/usecases/base_usecase.dart';
import 'package:fortuno/features/products/domain/usecases/get_packages_by_company.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/bloc/base_bloc.dart';
import '../../../../core/failures/failure.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/package.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_category_by_companyid.dart';
import '../../domain/usecases/get_products_by_company.dart';

part 'product_event.dart';
part 'product_state.dart';

@injectable
class ProductsBloc extends BaseAppBloc<ProductEvent, ProductState> {
  final GetCategoryByCompanyId getCategoryByCompanyId;
  final GetProductsByCompany getProductsByCompany;
  final GetPackagesByCompany getPackagesByCompany;

  ProductsBloc({
    required this.getCategoryByCompanyId,
    required this.getProductsByCompany,
    required this.getPackagesByCompany,
  }) : super(ProductInitial()) {
    on<OnInitInvetoryPageEvent>(_onInit);
    on<OnAddProduct>(_onAddProduct);
  }

  Future<void> _onInit(OnInitInvetoryPageEvent event, Emitter emit) async {
    final responses = await runUsecases([
      () => getCategoryByCompanyId(null),
      () => getProductsByCompany(null),
      () => getPackagesByCompany(null),
    ], emit);

    final resCat = responses[0] as ReturnFailure<List<CategoryProduct>>;
    final resProducts = responses[1] as ReturnFailure<List<Product>>;
    final resPackages = responses[2] as ReturnFailure<List<Package>>;

    Failure? failure;

    final cat = resCat.fold((err) {
      failure = err;
      return null;
    }, (data) => data);

    final products = resProducts.fold((err) {
      failure = err;
      return null;
    }, (data) => data);

    final packages = resPackages.fold((err) {
      failure = err;
      return null;
    }, (data) => data);

    if (failure != null) {
      error(emit, failure!);
      return;
    }

    final newState = state.copyWith(
      categories: cat,
      products: products,
      packages: packages,
    );
    emit(newState);
  }

  Future<void> _onAddProduct(OnAddProduct event, Emitter emit) async {}

  @override
  Future<void> close() {
    log("CLOSE $runtimeType");
    return super.close();
  }
}
