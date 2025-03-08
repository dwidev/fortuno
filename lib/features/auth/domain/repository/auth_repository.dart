import '../entities/auth_token.dart';

abstract class AuthRepository {
  Future<String> signWithGoogle();
  Future<AuthToken> signWithEmail({required String email});
}
