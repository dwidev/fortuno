import 'package:injectable/injectable.dart';

import '../../../../core/firebase/firebase.dart';
import '../../domain/entities/user_authenticated.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_remote_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService firebaseAuthService;
  final AuthRemoteDataource authRemoteDataource;

  AuthRepositoryImpl({
    required this.firebaseAuthService,
    required this.authRemoteDataource,
  });

  @override
  Future<String> signWithGoogle() async {
    await firebaseAuthService.signOut();
    final userCrendtial = await firebaseAuthService.signWithGoogle();
    return userCrendtial?.user?.email ?? "";
  }

  @override
  Future<UserAuthenticated> authenticateWitEmail({
    required String email,
  }) async {
    return await authRemoteDataource.signWithEmail(email: email);
  }

  @override
  Future<void> signOut() async {
    await firebaseAuthService.signOut();
  }
}
