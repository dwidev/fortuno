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
import 'package:fortuno/features/auth/domain/usecases/signin_with_google.dart'
    as _i870;
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
    gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
    gh.lazySingleton<_i592.FirebaseAuthService>(
      () => registerModule.firebaseAuthService,
    );
    gh.lazySingleton<_i720.AuthRemoteDataource>(
      () => _i787.AuthNosqlDatasource(client: gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i948.AuthRepository>(
      () => _i319.AuthRepositoryImpl(
        firebaseAuthService: gh<_i512.FirebaseAuthService>(),
        authRemoteDataource: gh<_i720.AuthRemoteDataource>(),
      ),
    );
    gh.lazySingleton<_i870.SignWithGoogle>(
      () => _i870.SignWithGoogle(authRepository: gh<_i948.AuthRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i852.RegisterModule {}
