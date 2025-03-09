import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failure.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../repository/auth_repository.dart';

@lazySingleton
class SignOut extends BaseUsecase<bool, void> {
  final AuthRepository authRepository;

  SignOut({required this.authRepository});

  @override
  Future<Either<Failure, bool>> calling(void params) async {
    await authRepository.signOut();
    return Right(true);
  }
}
