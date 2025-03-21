// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:fortuno/core/depedency_injection/register_module.dart' as _i852;
import 'package:fortuno/core/firebase/auth_service.dart' as _i592;
import 'package:fortuno/core/firebase/firebase.dart' as _i512;
import 'package:fortuno/core/local_storage/local_storage.dart' as _i968;
import 'package:fortuno/core/local_storage/local_storage.dart';
import 'package:fortuno/core/local_storage/secure_storage.dart' as _i121;
import 'package:fortuno/features/auth/data/datasource/auth_nosql_datasource.dart'
    as _i787;
import 'package:fortuno/features/auth/data/datasource/auth_remote_datasource.dart'
    as _i720;
import 'package:fortuno/features/auth/data/repository/auth_repository_impl.dart'
    as _i319;
import 'package:fortuno/features/auth/domain/repository/auth_repository.dart'
    as _i948;
import 'package:fortuno/features/auth/domain/usecases/check_authorize.dart'
    as _i605;
import 'package:fortuno/features/auth/domain/usecases/sign_out.dart' as _i101;
import 'package:fortuno/features/auth/domain/usecases/signin_with_google.dart'
    as _i870;
import 'package:fortuno/features/auth/presentations/bloc/auth_bloc.dart'
    as _i279;
import 'package:fortuno/features/order/data/datasource/order_datasource.dart'
    as _i252;
import 'package:fortuno/features/order/data/datasource/order_nosql_datasource.dart'
    as _i781;
import 'package:fortuno/features/order/data/repository/order_repository_impl.dart'
    as _i562;
import 'package:fortuno/features/order/domain/repository/order_repository.dart'
    as _i996;
import 'package:fortuno/features/order/domain/usecases/cache_order_from_cart.dart'
    as _i258;
import 'package:fortuno/features/order/domain/usecases/create_order.dart'
    as _i242;
import 'package:fortuno/features/order/domain/usecases/get_orders_by_company_id.dart'
    as _i1028;
import 'package:fortuno/features/order/domain/usecases/update_status_order.dart'
    as _i211;
import 'package:fortuno/features/order/presentations/bloc/cart/cart_bloc.dart'
    as _i184;
import 'package:fortuno/features/order/presentations/bloc/cart/cart_processing_bloc.dart'
    as _i617;
import 'package:fortuno/features/order/presentations/bloc/order/order_bloc.dart'
    as _i886;
import 'package:fortuno/features/order/presentations/bloc/order_process/order_process_bloc.dart'
    as _i955;
import 'package:fortuno/features/payments/data/datasource/payment_datasource.dart'
    as _i401;
import 'package:fortuno/features/payments/data/datasource/payment_nosql_datasource.dart'
    as _i233;
import 'package:fortuno/features/payments/data/repository/payment_repository_impl.dart'
    as _i1063;
import 'package:fortuno/features/payments/domain/repository/payment_repository.dart'
    as _i721;
import 'package:fortuno/features/payments/domain/usecase/get_invoice_number.dart'
    as _i922;
import 'package:fortuno/features/payments/domain/usecase/save_payment.dart'
    as _i931;
import 'package:fortuno/features/payments/domain/usecase/show_invoice.dart'
    as _i837;
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
import 'package:fortuno/features/profile/data/datasource/company_datasource.dart'
    as _i536;
import 'package:fortuno/features/profile/data/datasource/company_local_datasource.dart'
    as _i479;
import 'package:fortuno/features/profile/data/repo/company_repository_impl.dart'
    as _i743;
import 'package:fortuno/features/profile/domain/repo/company_repository.dart'
    as _i1060;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../local_storage/shared_pref_storage.dart';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
    gh.lazySingleton<_i592.FirebaseAuthService>(
      () => registerModule.firebaseAuthService,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secStorage,
    );
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => registerModule.pref,
      preResolve: true,
    );
    gh.lazySingleton<_i252.OrderDatasource>(
      () => _i781.OrderNosqlDatasource(client: gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i79.ProductsDatasource>(
      () => _i294.ProductNosqlDatasource(client: gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i536.CompanyDatasource>(
      () => _i479.CompanyLocalDatasource(
        preference: gh<_i968.ILocalStorage>(instanceName: 'shared-pref'),
      ),
    );
    gh.lazySingleton<_i720.AuthRemoteDataource>(
      () => _i787.AuthNosqlDatasource(client: gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i401.PaymentDatasource>(
      () => _i233.PaymentNosqlDatasource(client: gh<_i454.SupabaseClient>()),
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
    gh.lazySingleton<_i968.ILocalStorage>(
      () =>
          _i121.SecureStorage(secureStorage: gh<_i558.FlutterSecureStorage>()),
      instanceName: 'secure-storage',
    );
    gh.lazySingleton<_i870.SignWithGoogle>(
      () => _i870.SignWithGoogle(
        authRepository: gh<_i948.AuthRepository>(),
        secStorage: gh<_i968.ILocalStorage>(instanceName: 'secure-storage'),
        preference: gh<_i968.ILocalStorage>(instanceName: 'shared-pref'),
      ),
    );
    gh.lazySingleton<_i101.SignOut>(
      () => _i101.SignOut(
        authRepository: gh<_i948.AuthRepository>(),
        secStorage: gh<_i968.ILocalStorage>(instanceName: 'secure-storage'),
        preference: gh<_i968.ILocalStorage>(instanceName: 'shared-pref'),
      ),
    );
    gh.lazySingleton<ILocalStorage>(
      () => SharedPrefStorage(preferences: gh<_i460.SharedPreferences>()),
      instanceName: 'shared-pref',
    );
    gh.lazySingleton<_i996.OrderRepository>(
      () => _i562.OrderRepositoryImpl(
        companyDatasource: gh<_i536.CompanyDatasource>(),
        orderDatasource: gh<_i252.OrderDatasource>(),
      ),
      dispose: (i) => i.dispose(),
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
    gh.lazySingleton<_i1060.CompanyRepository>(
      () => _i743.CompanyRepositoryImpl(
        datasource: gh<_i536.CompanyDatasource>(),
      ),
    );
    gh.factory<_i886.OrderBloc>(
      () => _i886.OrderBloc(
        getCategoryByCompanyId: gh<_i436.GetCategoryByCompanyId>(),
        getProductsByCategoryId: gh<_i852.GetProductsByCategoryId>(),
        getPackageByCategoryid: gh<_i359.GetPackageByCategoryid>(),
      ),
    );
    gh.lazySingleton<_i721.PaymentRepository>(
      () => _i1063.PaymentRepositoryImpl(
        paymentDatasource: gh<_i401.PaymentDatasource>(),
      ),
    );
    gh.lazySingleton<_i1028.GetOrdersByCompanyId>(
      () => _i1028.GetOrdersByCompanyId(
        orderRepository: gh<_i996.OrderRepository>(),
      ),
    );
    gh.lazySingleton<_i242.CreateOrder>(
      () => _i242.CreateOrder(orderRepository: gh<_i996.OrderRepository>()),
    );
    gh.lazySingleton<_i258.CacheOrderFromCart>(
      () => _i258.CacheOrderFromCart(
        orderRepository: gh<_i996.OrderRepository>(),
      ),
    );
    gh.lazySingleton<_i605.CheckAuthorize>(
      () => _i605.CheckAuthorize(
        authRepository: gh<_i948.AuthRepository>(),
        secStorage: gh<_i968.ILocalStorage>(instanceName: 'secure-storage'),
      ),
    );
    gh.factory<_i617.CartProcessingBloc>(
      () => _i617.CartProcessingBloc(createOrder: gh<_i242.CreateOrder>()),
    );
    gh.factory<_i279.AuthBloc>(
      () => _i279.AuthBloc(
        signWithGoogle: gh<_i870.SignWithGoogle>(),
        signOut: gh<_i101.SignOut>(),
        checkAuthorize: gh<_i605.CheckAuthorize>(),
      ),
    );
    gh.lazySingleton<_i211.UpdateStatusOrder>(
      () => _i211.UpdateStatusOrder(
        orderRepository: gh<_i996.OrderRepository>(),
        paymentRepository: gh<_i721.PaymentRepository>(),
      ),
    );
    gh.lazySingleton<_i837.ShowInvoice>(
      () => _i837.ShowInvoice(paymentRepository: gh<_i721.PaymentRepository>()),
    );
    gh.lazySingleton<_i922.GetInvoiceNumber>(
      () => _i922.GetInvoiceNumber(
        paymentRepository: gh<_i721.PaymentRepository>(),
      ),
    );
    gh.lazySingleton<_i931.SavePayment>(
      () => _i931.SavePayment(paymentRepository: gh<_i721.PaymentRepository>()),
    );
    gh.factory<_i184.CartBloc>(
      () => _i184.CartBloc(cacheOrderFromCart: gh<_i258.CacheOrderFromCart>()),
    );
    gh.factory<_i955.OrderProcessBloc>(
      () => _i955.OrderProcessBloc(
        getOrdersByCompanyId: gh<_i1028.GetOrdersByCompanyId>(),
        updateStatusOrder: gh<_i211.UpdateStatusOrder>(),
        showInvoice: gh<_i837.ShowInvoice>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i852.RegisterModule {}
