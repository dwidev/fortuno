import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/user_authenticated.dart';
import 'auth_remote_datasource.dart';

@LazySingleton(as: AuthRemoteDataource)
class AuthNosqlDatasource extends AuthRemoteDataource {
  final SupabaseClient client;

  AuthNosqlDatasource({required this.client});

  @override
  Future<UserAuthenticated> signWithEmail({required String email}) async {
    final response = await client
        .from('account')
        .select('*, company(ID)')
        .eq('email', email);

    final account = response.firstOrNull;

    if (account != null) {
      final company = account["company"];

      return UserAuthenticated(
        accessToken: "accessToken",
        refreshToken: "refreshToken",
        companyID: company["ID"],
      );
    } else {
      return UserAuthenticated.unAuthorize();
    }
  }
}
