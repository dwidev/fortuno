import 'package:firebase_core/firebase_core.dart';

import '../environtments/env_enum.dart';
import 'firebase_options_prod.dart' as prod;
import 'firebase_options_uat.dart' as uat;

Future<void> intializeFirebasApp(Environtment env) async {
  final options = switch (env) {
    Environtment.uat => uat.DefaultFirebaseOptions.currentPlatform,
    Environtment.production => prod.DefaultFirebaseOptions.currentPlatform,
  };

  await Firebase.initializeApp(options: options);
}
