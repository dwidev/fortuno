import '../../domain/entities/auth_token.dart';

abstract class AuthRemoteDataource {
  Future<AuthToken> signWithEmail({required String email});
}
