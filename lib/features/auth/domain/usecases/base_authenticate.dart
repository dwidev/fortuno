import '../../../../core/local_storage/local_storage.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../entities/auth_token.dart';
import '../repository/auth_repository.dart';

abstract class BaseAuthenticateUsecase<R, P> extends BaseUsecase<R, P> {
  final AuthRepository authRepository;
  final LocalStorage secStorage;

  BaseAuthenticateUsecase({
    required this.authRepository,
    required this.secStorage,
  });

  Future<void> storeToken(AuthToken token) async {
    await token.storeToStorage(secStorage);
  }

  Future<void> clearToken() async {
    await AuthToken.clearToken(secStorage);
  }
}
