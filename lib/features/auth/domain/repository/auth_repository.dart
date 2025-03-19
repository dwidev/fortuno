import '../entities/user_authenticated.dart';

abstract class AuthRepository {
  Future<String> signWithGoogle();
  Future<UserAuthenticated> authenticateWitEmail({required String email});
  Future<void> signOut();
}
