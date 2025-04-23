import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/environments/env_enum.dart';

import 'main_app.dart';

Future<void> main() async {
  await dotenv.load(fileName: "config.uat.env");
  mainApp(EnvApp.uat);
}
