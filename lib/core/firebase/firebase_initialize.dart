import 'package:firebase_core/firebase_core.dart';
import 'package:fortuno/core/environments/env_enum.dart';

import 'firebase_options_prod.dart' as prod;
import 'firebase_options_uat.dart' as uat;

Future<void> intializeFirebasApp(EnvApp env) async {
  final options = switch (env) {
    EnvApp.uat => uat.DefaultFirebaseOptions.currentPlatform,
    EnvApp.production => prod.DefaultFirebaseOptions.currentPlatform,
  };

  await Firebase.initializeApp(options: options);
}
