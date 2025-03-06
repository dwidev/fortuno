import 'core/environtments/env_enum.dart';
import 'core/firebase/firebase.dart';
import 'main_app.dart';

Future<void> main() async {
  final env = Environtment.uat;
  await intializeFirebasApp(env);
  mainApp(env);
}
