import 'package:fortuno/features/auth/presentations/pages/splash_page.dart';

import '../../features/auth/presentations/bloc/auth_bloc.dart';
import '../../features/auth/presentations/pages/login_page.dart';
import '../../features/auth/presentations/widgets/auth_listener_widget.dart';
import '../core.dart';
import '../depedency_injection/injection.dart';

final authRoute = <RouteBase>[
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: LoginPage.path,
    builder:
        (context, state) => BlocProvider(
          create: (context) => getIt<AuthBloc>(),
          child: AuthListener(
            builder: (context, bloc, state) {
              return LoginPage();
            },
          ),
        ),
  ),
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: SplashPage.path,
    builder:
        (context, state) => BlocProvider(
          create: (context) => getIt<AuthBloc>()..add(OnCheckAuthorize()),
          child: AuthListener(
            builder: (context, bloc, state) {
              return SplashPage();
            },
          ),
        ),
  ),
];
