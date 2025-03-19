import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failure.dart';
import '../../../../core/local_storage/local_storage.dart';
import 'base_authenticate.dart';

@lazySingleton
class SignWithGoogle extends BaseAuthenticateUsecase<bool, void> {
  SignWithGoogle({
    required super.authRepository,
    @secureStorage required super.secStorage,
  });

  @override
  Future<Either<Failure, bool>> calling(void params) async {
    final email = await authRepository.signWithGoogle();
    if (email.isEmpty) {
      return Right(false);
    }

    final requestToken = await authRepository.authenticateWitEmail(
      email: email,
    );

    if (requestToken.accessToken.isEmpty) {
      return Right(false);
    }

    await storeToken(requestToken);
    return Right(true);
  }
}
