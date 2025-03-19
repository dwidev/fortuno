import 'package:firebase_auth/firebase_auth.dart';
import 'package:fortuno/core/local_storage/local_storage_factory.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide LocalStorage;

import '../firebase/auth_service.dart';
import '../local_storage/local_storage.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  SupabaseClient get supabaseClient => Supabase.instance.client;

  @lazySingleton
  FirebaseAuthService get firebaseAuthService => FirebaseAuthService(
    firebaseAuth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn(),
  );

  @secureStorage
  LocalStorage get secStorage => LocalStorageFactory.secureStorage();

  @sharedPref
  @preResolve
  Future<LocalStorage> get pref async => LocalStorageFactory.preference();
}
