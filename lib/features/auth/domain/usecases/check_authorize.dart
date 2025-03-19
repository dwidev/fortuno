import 'package:either_dart/either.dart';

import '../../../../core/core.dart';
import '../../../../core/local_storage/local_storage.dart';
import '../entities/auth_token.dart';
import 'base_authenticate.dart';

@lazySingleton
class CheckAuthorize extends BaseAuthenticateUsecase<bool, void> {
  CheckAuthorize({
    required super.authRepository,
    @secureStorage required super.secStorage,
  });

  @override
  Future<Either<Failure, bool>> calling(void params) async {
    await Future.delayed(1.seconds);
    final token = await secStorage.getData(accessTokenKey);
    if (((token as String?) ?? "").isNotEmpty) {
      return Right(true);
    }

    return Right(false);
  }
}
