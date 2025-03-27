import 'dart:developer';

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
    @sharedPref required super.preference,
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

    await super.storeAuthenticatedData(requestToken);
    return Right(true);
  }

  @override
  void dispose() {
    super.dispose();
    log("CHILD $runtimeType");
  }
}
