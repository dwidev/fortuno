import 'package:fortuno/core/core.dart';
import 'package:fortuno/core/environtments/env_enum.dart';

class App extends StatelessWidget {
  const App({super.key, required this.environtment});

  final Environtment environtment;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fortuno POS ${environtment.name}',
      theme: lightTheme,
      routerConfig: router,
      builder: (context, child) {
        return child ?? Offstage();
      },
    );
  }
}
