import '../../../../core/local_storage/local_storage.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../entities/user_authenticated.dart';
import '../repository/auth_repository.dart';

abstract class BaseAuthenticateUsecase<R, P> extends BaseUsecase<R, P> {
  final AuthRepository authRepository;
  final ILocalStorage secStorage;
  final ILocalStorage? preference;

  BaseAuthenticateUsecase({
    required this.authRepository,
    required this.secStorage,
    this.preference,
  });

  Future<void> storeAuthenticatedData(UserAuthenticated data) async {
    final p = preference;
    if (p == null) return;

    await data.storeToStorage(secStorage, p);
  }

  Future<void> clearData() async {
    final p = preference;
    if (p == null) return;

    await UserAuthenticated.clearData(secStorage, p);
  }
}
