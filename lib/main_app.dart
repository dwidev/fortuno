import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/core.dart';
import 'core/depedency_injection/injection.dart';
import 'core/environments/env_enum.dart';
import 'core/firebase/firebase.dart';

Future<void> mainApp(EnvApp env) async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDepedencies(env: env);

  await intializeFirebasApp(env);

  final url = dotenv.get('SUPABASE_URL');
  final key = dotenv.get('SUPABASE_KEY');
  Supabase.initialize(url: url, anonKey: key);

  // easy loading config style
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorColor = primaryColor
    ..animationStyle = EasyLoadingAnimationStyle.opacity
    ..toastPosition = EasyLoadingToastPosition.bottom;

  initializeDateFormatting('id_ID');
  runApp(App(env: env));
}
