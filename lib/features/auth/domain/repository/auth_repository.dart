import '../entities/auth_token.dart';

abstract class AuthRepository {
  Future<String> signWithGoogle();
  Future<AuthToken> authenticateWitEmail({required String email});
  Future<void> signOut();
}
