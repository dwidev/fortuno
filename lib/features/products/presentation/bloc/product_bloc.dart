// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortuno/features/products/domain/usecases/activate_data.dart';
import 'package:fortuno/features/products/domain/usecases/delete_product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/bloc/base_bloc.dart';
import '../../../../core/failures/failure.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/package.dart';
import '../../domain/entities/product.dart';
import '../../domain/enums/inventory_type.dart';
import '../../domain/usecases/delete_category.dart';
import '../../domain/usecases/get_category_by_companyid.dart';
import '../../domain/usecases/get_packages_by_company.dart';
import '../../domain/usecases/get_products_by_company.dart';
import '../../domain/usecases/save_insert_category.dart';
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
  final SaveInsertCategory saveInsertCategory;

  // delete
  final DeleteCategory deleteCategory;
  final DeleteProduct deleteProduct;

  // activate
  final ActivateData activateData;

  ProductsBloc({
    required this.getCategoryByCompanyId,
    required this.getProductsByCompany,
    required this.getPackagesByCompany,
    required this.saveInsertProduct,
    required this.saveInsertCategory,
    required this.deleteCategory,
    required this.deleteProduct,
    required this.activateData,
  }) : super(ProductInitial()) {
    on<OnInitInvetoryPageEvent>(_onInit);
    on<OnAddProduct>(_onAddProduct);
    on<OnAddCategory>(_onAddCategory);
    on<OnDeleteCategory>(_onDeleteCategory);
    on<OnDeleteProduct>(_onDeleteProduct);
    on<OnActivateData>(_onActivateData);
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

    result.fold((error) => this.error(emit, error), (product) {
      emit(
        OnSavedForm(
          categories: state.categories,
          products: [...state.products, product],
          packages: state.packages,
        ),
      );
    });
  }

  Future<void> _onAddCategory(OnAddCategory event, Emitter emit) async {
    final result = await runUsecase(() {
      final params = SaveInsertCategoryParams(category: event.category);
      return saveInsertCategory(params);
    }, emit);

    result.fold((error) => this.error(emit, error), (category) {
      emit(
        OnSavedForm(
          categories: [...state.categories, category],
          products: state.products,
          packages: state.packages,
        ),
      );
    });
  }

  Future<void> _onDeleteCategory(OnDeleteCategory event, Emitter emit) async {
    final result = await runUsecase(() {
      return deleteCategory(event.id);
    }, emit);

    result.fold((error) => this.error(emit, error), (right) {
      final newCat = state.categories.toList();
      newCat.removeWhere((e) => e.id == event.id);

      final newState = state.copyWith(categories: newCat);
      emit(newState);
    });
  }

  Future<void> _onDeleteProduct(OnDeleteProduct event, Emitter emit) async {
    final result = await runUsecase(() {
      return deleteProduct(event.id);
    }, emit);

    result.fold((error) => this.error(emit, error), (right) {
      final newProd = state.products.toList();
      newProd.removeWhere((e) => e.id == event.id);

      final newState = state.copyWith(products: newProd);
      emit(newState);
    });
  }

  Future<void> _onActivateData(OnActivateData event, Emitter emit) async {
    final result = await activateData(event.params);

    result.fold(
      (error) {
        state.updateActive(event.params, event.params.value);
        emit(state);
        this.error(emit, error);
      },
      (right) {
        state.updateActive(event.params, event.params.value);
        emit(state);
      },
    );
  }

  @override
  Future<void> close() {
    log("CLOSE $runtimeType");
    return super.close();
  }
}
