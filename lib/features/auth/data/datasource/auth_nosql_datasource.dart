import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/auth_token.dart';
import 'auth_remote_datasource.dart';

@LazySingleton(as: AuthRemoteDataource)
class AuthNosqlDatasource extends AuthRemoteDataource {
  final SupabaseClient client;

  AuthNosqlDatasource({required this.client});

  @override
  Future<AuthToken> signWithEmail({required String email}) async {
    try {
      final response =
          await client.from('account').select().eq('email', email).count();

      if (response.count == 1) {
        return AuthToken(
          accessToken: "accessToken",
          refreshToken: "refreshToken",
        );
      } else {
        return AuthToken.unAuthorize();
      }
    } catch (e) {
      if (e is PostgrestException) {
        return AuthToken.unAuthorize();
      }

      rethrow;
    }
  }
}
