import '../../domain/entities/user_authenticated.dart';

abstract class AuthRemoteDataource {
  Future<UserAuthenticated> signWithEmail({required String email});
}
