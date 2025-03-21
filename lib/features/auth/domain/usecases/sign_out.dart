import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failure.dart';
import '../../../../core/local_storage/local_storage.dart';
import 'base_authenticate.dart';

@lazySingleton
class SignOut extends BaseAuthenticateUsecase<bool, void> {
  SignOut({
    required super.authRepository,
    @secureStorage required super.secStorage,
    @sharedPref required super.preference,
  });

  @override
  Future<Either<Failure, bool>> calling(void params) async {
    await authRepository.signOut();

    await clearData();
    return Right(true);
  }
}
