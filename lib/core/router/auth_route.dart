import 'package:fortuno/core/core.dart';
import 'package:fortuno/features/auth/presentations/pages/login_page.dart';

final authRoute = <RouteBase>[
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: LoginPage.path,
    builder: (context, state) => LoginPage(),
  ),
];
