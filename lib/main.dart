import 'package:fortuno/core/router/main_route.dart';

import 'features/main_page.dart';

import 'core/core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: lightTheme,
      routerConfig: router,
      builder: (context, child) {
        return child ?? Offstage();
      },
    );
  }
}
