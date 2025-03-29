import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/bloc/base_bloc.dart';
import '../../../../core/failures/failure.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/package.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_category_by_companyid.dart';
import '../../domain/usecases/get_packages_by_company.dart';
import '../../domain/usecases/get_products_by_company.dart';
import '../../domain/usecases/save_insert_product.dart';

part 'product_event.dart';
part 'product_state.dart';

@injectable
class ProductsBloc extends BaseAppBloc<ProductEvent, ProductState> {
  final GetCategoryByCompanyId getCategoryByCompanyId;
  final GetProductsByCompany getProductsByCompany;
  final GetPackagesByCompany getPackagesByCompany;

  // insert
  final SaveInsertProduct saveInsertProduct;

  ProductsBloc({
    required this.getCategoryByCompanyId,
    required this.getProductsByCompany,
    required this.getPackagesByCompany,
    required this.saveInsertProduct,
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

  Future<void> _onAddProduct(OnAddProduct event, Emitter emit) async {
    final result = await runUsecase(() {
      final params = SaveInsertProductParams(
        product: event.product,
        category: event.category,
      );
      return saveInsertProduct(params);
    }, emit);

    result.fold((error) => this.error(emit, error), (right) {
      emit(
        OnSavedForm(
          categories: state.categories,
          products: [...state.products, event.product],
          packages: state.packages,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    log("CLOSE $runtimeType");
    return super.close();
  }
}
