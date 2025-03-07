import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/images_assets.dart';
import '../../../core/core.dart';
import '../../order/pages/create_order_page.dart';
import 'welcome_page.dart';

class LoginPage extends StatelessWidget {
  static const path = '/login';

  const LoginPage({super.key});

  Future<void> signInWithGoogle(BuildContext c) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final user = await FirebaseAuth.instance.signInWithCredential(credential);
      final ok = await checkUser(googleUser?.email ?? "");
      if (ok) {
        print(googleUser?.email);
        c.go(CreateOrderPage.path);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkUser(String email) async {
    final check = await Supabase.instance.client.from('company').select();
    // .eq('email', email);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(flex: 3, child: WelcomePage()),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(kSizeXXL),
              decoration: BoxDecoration(color: whiteColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Fortuno POS",
                    style: context.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: darkColor,
                    ),
                  ),
                  Text(
                    "Kendali Bisnis di Ujung Jari, Laba Melesat Setiap Hari!",
                    style: context.textTheme.bodySmall?.copyWith(
                      color: darkColor,
                    ),
                  ),
                  SizedBox(height: kSizeM),
                  GradientButton(
                    width: 300,
                    onPressed: () async {
                      await signInWithGoogle(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(googlePng, width: 25, height: 25),
                        SizedBox(width: kSizeS),
                        Text(
                          "Sign with Google",
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: darkColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
