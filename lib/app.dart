import 'package:fortuno/core/core.dart';
import 'package:fortuno/core/environments/env_enum.dart';

class App extends StatelessWidget {
  const App({super.key, required this.env});

  final EnvApp env;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fortuno POS ${env.name}',
      theme: lightTheme,
      routerConfig: router,
      builder: (context, child) {
        return child ?? Offstage();
      },
    );
  }
}
