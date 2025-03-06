import 'package:firebase_core/firebase_core.dart';

import 'core/core.dart';
import 'core/environtments/env_enum.dart';
import 'firebase_options_uat.dart';
import 'main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  mainApp(Environtment.uat);
}
