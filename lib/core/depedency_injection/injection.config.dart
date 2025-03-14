// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fortuno/core/depedency_injection/register_module.dart' as _i852;
import 'package:fortuno/core/firebase/auth_service.dart' as _i592;
import 'package:fortuno/core/firebase/firebase.dart' as _i512;
import 'package:fortuno/features/auth/data/datasource/auth_nosql_datasource.dart'
    as _i787;
import 'package:fortuno/features/auth/data/datasource/auth_remote_datasource.dart'
    as _i720;
import 'package:fortuno/features/auth/data/repository/auth_repository_impl.dart'
    as _i319;
import 'package:fortuno/features/auth/domain/repository/auth_repository.dart'
    as _i948;
import 'package:fortuno/features/auth/domain/usecases/sign_out.dart' as _i101;
import 'package:fortuno/features/auth/domain/usecases/signin_with_google.dart'
    as _i870;
import 'package:fortuno/features/auth/presentations/bloc/auth_bloc.dart'
    as _i279;
import 'package:fortuno/features/order/data/repository/order_repository_imp.dart'
    as _i2;
import 'package:fortuno/features/order/domain/repository/order_repository.dart'
    as _i996;
import 'package:fortuno/features/order/domain/usecases/cache_order_from_cart.dart'
    as _i258;
import 'package:fortuno/features/order/presentations/bloc/cart/cart_bloc.dart'
    as _i184;
import 'package:fortuno/features/order/presentations/bloc/cart/cart_processing_bloc.dart'
    as _i617;
import 'package:fortuno/features/order/presentations/bloc/order/order_bloc.dart'
    as _i886;
import 'package:fortuno/features/products/data/datasources/product_nosql_datasource.dart'
    as _i294;
import 'package:fortuno/features/products/data/datasources/products_datasource.dart'
    as _i79;
import 'package:fortuno/features/products/data/repository/products_repository_impl.dart'
    as _i587;
import 'package:fortuno/features/products/domain/repository/products_repository.dart'
    as _i1028;
import 'package:fortuno/features/products/domain/usecases/get_category_by_companyid.dart'
    as _i436;
import 'package:fortuno/features/products/domain/usecases/get_package_by_categoryid.dart'
    as _i359;
import 'package:fortuno/features/products/domain/usecases/get_products_by_categoryid.dart'
    as _i852;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i617.CartProcessingBloc>(() => _i617.CartProcessingBloc());
    gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
    gh.lazySingleton<_i592.FirebaseAuthService>(
      () => registerModule.firebaseAuthService,
    );
    gh.lazySingleton<_i79.ProductsDatasource>(
      () => _i294.ProductNosqlDatasource(client: gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i720.AuthRemoteDataource>(
      () => _i787.AuthNosqlDatasource(client: gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i996.OrderRepository>(
      () => _i2.OrderRepositoryImpl(),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i1028.ProductsRepository>(
      () => _i587.ProductsRepositoryImpl(
        productsDatasource: gh<_i79.ProductsDatasource>(),
      ),
    );
    gh.lazySingleton<_i948.AuthRepository>(
      () => _i319.AuthRepositoryImpl(
        firebaseAuthService: gh<_i512.FirebaseAuthService>(),
        authRemoteDataource: gh<_i720.AuthRemoteDataource>(),
      ),
    );
    gh.lazySingleton<_i436.GetCategoryByCompanyId>(
      () => _i436.GetCategoryByCompanyId(
        productsRepository: gh<_i1028.ProductsRepository>(),
      ),
    );
    gh.lazySingleton<_i852.GetProductsByCategoryId>(
      () => _i852.GetProductsByCategoryId(
        productsRepository: gh<_i1028.ProductsRepository>(),
      ),
    );
    gh.lazySingleton<_i359.GetPackageByCategoryid>(
      () => _i359.GetPackageByCategoryid(
        productsRepository: gh<_i1028.ProductsRepository>(),
      ),
    );
    gh.factory<_i886.OrderBloc>(
      () => _i886.OrderBloc(
        getCategoryByCompanyId: gh<_i436.GetCategoryByCompanyId>(),
        getProductsByCategoryId: gh<_i852.GetProductsByCategoryId>(),
        getPackageByCategoryid: gh<_i359.GetPackageByCategoryid>(),
      ),
    );
    gh.lazySingleton<_i258.CacheOrderFromCart>(
      () => _i258.CacheOrderFromCart(
        orderRepository: gh<_i996.OrderRepository>(),
      ),
    );
    gh.lazySingleton<_i870.SignWithGoogle>(
      () => _i870.SignWithGoogle(authRepository: gh<_i948.AuthRepository>()),
    );
    gh.lazySingleton<_i101.SignOut>(
      () => _i101.SignOut(authRepository: gh<_i948.AuthRepository>()),
    );
    gh.factory<_i279.AuthBloc>(
      () => _i279.AuthBloc(
        signWithGoogle: gh<_i870.SignWithGoogle>(),
        signOut: gh<_i101.SignOut>(),
      ),
    );
    gh.factory<_i184.CartBloc>(
      () => _i184.CartBloc(cacheOrderFromCart: gh<_i258.CacheOrderFromCart>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i852.RegisterModule {}
