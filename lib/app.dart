import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fortuno/core/core.dart';
import 'package:fortuno/core/environments/env_enum.dart';

class App extends StatelessWidget {
  const App({super.key, required this.env});

  final EnvApp env;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fortuno POS ${env.name}',
      theme: lightTheme,
      locale: Locale('id', 'ID'),
      routerConfig: router,
      builder: EasyLoading.init(
        builder:
            (context, child) => GestureDetector(
              onTap: () {
                print("TAP GA");
              },
              child: child,
            ),
      ),
    );
  }
}
