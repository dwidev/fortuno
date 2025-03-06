import 'package:firebase_core/firebase_core.dart';
import 'package:fortuno/core/core.dart';
import 'package:fortuno/core/environtments/env_enum.dart';
import 'package:fortuno/core/firebase/firebase_options_prod.dart' as prod;
import 'package:fortuno/core/firebase/firebase_options_uat.dart' as uat;

Future<void> intializeFirebasApp(Environtment env) async {
  final options = switch (env) {
    Environtment.uat => uat.DefaultFirebaseOptions.currentPlatform,
    Environtment.production => prod.DefaultFirebaseOptions.currentPlatform,
  };

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: options);
}
