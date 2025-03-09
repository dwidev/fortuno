import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  FirebaseAuthService({required this.firebaseAuth, required this.googleSignIn});

  Future<UserCredential?> signWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final user = await firebaseAuth.signInWithCredential(credential);
    return user;
  }

  Future<void> signOut() async {
    googleSignIn.signOut();
    firebaseAuth.signOut();
  }
}
