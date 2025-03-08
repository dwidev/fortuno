import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../firebase/auth_service.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  FirebaseAuthService get firebaseAuthService => FirebaseAuthService(
    firebaseAuth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn(),
  );
}
