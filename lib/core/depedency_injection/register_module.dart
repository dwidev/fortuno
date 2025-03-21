import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../firebase/auth_service.dart';
import '../local_storage/local_storage_factory.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  SupabaseClient get supabaseClient => Supabase.instance.client;

  @lazySingleton
  FirebaseAuthService get firebaseAuthService => FirebaseAuthService(
    firebaseAuth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn(),
  );

  @lazySingleton
  FlutterSecureStorage get secStorage => Storage3rdPartyFactory.secureStorage();

  @preResolve
  @lazySingleton
  Future<SharedPreferences> get pref async =>
      Storage3rdPartyFactory.preference();
}
