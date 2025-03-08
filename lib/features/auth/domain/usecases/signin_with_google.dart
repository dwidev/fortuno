import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failure.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../repository/auth_repository.dart';

@lazySingleton
class SignWithGoogle extends BaseUsecase<bool, void> {
  final AuthRepository authRepository;

  SignWithGoogle({required this.authRepository});

  @override
  Future<Either<Failure, bool>> calling(void params) async {
    final email = await authRepository.signWithGoogle();
    final requestToken = await authRepository.signWithEmail(email: email);
    if (requestToken.accessToken.isEmpty) {
      return Right(false);
    }

    return Right(true);
  }
}
