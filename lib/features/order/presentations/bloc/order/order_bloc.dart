import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortuno/features/products/domain/enums/package_type.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/bloc/base_bloc.dart';
import '../../../../../core/failures/failure.dart';
import '../../../../../core/usecases/base_usecase.dart';
import '../../../../products/domain/entities/category.dart';
import '../../../../products/domain/entities/package.dart';
import '../../../../products/domain/entities/product.dart';
import '../../../../products/domain/usecases/get_category_by_companyid.dart';
import '../../../../products/domain/usecases/get_package_by_categoryid.dart';
import '../../../../products/domain/usecases/get_products_by_categoryid.dart';
import '../../../domain/entities/order_item.dart';

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
      emit(
        OrderInitSuccess(
          categories: state.categories,
          productCountCart: state.productCountCart,
          contentsCPackage: state.contentsCPackage,
          finishSelected: state.finishSelected,
        ),
      );
    });
    on<OnPreparationCustomPackage>((event, emit) {
      if (state is AtProductPage) {
        final state = this.state as AtProductPage;
        final newState = OnSelectingCustomPackage(
          selectedPackage: event.seletedPackage,
          categoryProduct: state.categoryProduct,
          products: state.products,
          packages: state.packages,
          categories: state.categories,
          productCountCart: state.productCountCart,
          contentsCPackage: state.contentsCPackage,
          finishSelected: state.finishSelected,
        );
        emit(newState);
      }
    });
    on<OnUpdateOrderItems>(_onUpdateOrderItems);
    on<OnFinishSelectedProduct>(_onFinishSelectProduct);
    on<ResetOrder>(
      (event, emit) => emit(OrderInitial(categories: state.categories)),
    );
    on<OnSaveCustomePackage>((event, emit) {
      if (state is OnSelectingCustomPackage) {
        final state = this.state as OnSelectingCustomPackage;
        emit(
          AtProductPage(
            categoryProduct: state.categoryProduct,
            categories: state.categories,
            productCountCart: state.productCountCart,
            contentsCPackage: state.contentsCPackage,
            finishSelected: state.finishSelected,
            packages: state.packages,
            products: state.products,
          ),
        );
      }
    });
  }

  Future<void> _onInit(OnInitOrderPageEvent event, Emitter emit) async {
    final responses = await runUsecases([
      () => getCategoryByCompanyId(null),
    ], emit);

    final resCat = responses[0];

    resCat.fold(
      (err) {
        error(emit, err);
      },
      (right) {
        emit(
          OrderInitSuccess(
            categories: right,
            productCountCart: state.productCountCart,
            contentsCPackage: state.contentsCPackage,
            finishSelected: state.finishSelected,
          ),
        );
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

    Failure? failure;
    var newState = AtProductPage(
      categoryProduct: event.categoryProduct,
      categories: state.categories,
      productCountCart: state.productCountCart,
      contentsCPackage: state.contentsCPackage,
      finishSelected: state.finishSelected,
    );

    resCat.fold((err) => failure ??= err, (data) {
      newState = newState.copyWith(products: data);
    });

    resPac.fold((err) => failure ??= err, (data) {
      final updatedPackage =
          data.map((e) {
            if (e.type == PackageType.def) return e;

            final customItems = state.contentsCPackage[e.id];
            if (customItems == null) return e;

            return e.copyWith(items: customItems);
          }).toList();

      newState = newState.copyWith(packages: updatedPackage);
    });

    if (failure != null) {
      error(emit, failure!);
      return;
    }

    emit(newState);
  }

  void _onUpdateOrderItems(OnUpdateOrderItems event, Emitter emit) {
    if (this.state is! AtProductPage) return;

    final state = (this.state as AtProductPage);
    var newState = state;

    // UPDATED QUANTITY
    final currentQuantity = Map<String, int>.from(state.productCountCart);
    final updatedQuantity = currentQuantity[event.item.id];
    final newQuantity = event.item.quantity;

    if (updatedQuantity == null || updatedQuantity != newQuantity) {
      if (newQuantity == 0) {
        currentQuantity.remove(event.item.id);
      } else {
        currentQuantity[event.item.id] = newQuantity;
      }
      newState = newState.copyWith(productCountCart: currentQuantity);
    }

    final curPackages = List<Package>.from(state.packages);
    final currentContents = Map<String, List<Product>>.from(
      state.contentsCPackage,
    );
    final idx = curPackages.indexWhere((e) => e.id == event.item.package?.id);
    final curPackage = idx != -1 ? curPackages[idx] : null;

    // UPDATED CONTENS CUSTOME PACKAGE
    if (state is OnSelectingCustomPackage &&
        curPackage != null &&
        event.item.contents != curPackage.contents) {
      final newPackage = curPackage.copyWith(items: event.item.package?.items);
      curPackages[idx] = newPackage;

      if (newPackage.items.isEmpty) {
        currentContents.remove(newPackage.id);
      } else {
        currentContents[newPackage.id] = newPackage.items;
      }

      newState = (newState as OnSelectingCustomPackage).copyWith(
        contentsCPackage: currentContents,
        packages: curPackages,
        selectedPackage: newPackage,
      );
      emit(newState);
      return;
    }

    emit(newState);
  }

  void _onFinishSelectProduct(OnFinishSelectedProduct event, Emitter emit) {
    emit(state.copyWith(finishSelected: event.isFinish));
  }
}
