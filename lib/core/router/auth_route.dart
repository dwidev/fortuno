import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortuno/core/core.dart';
import 'package:fortuno/core/depedency_injection/injection.dart';
import 'package:fortuno/features/auth/presentations/bloc/auth_bloc.dart';
import 'package:fortuno/features/auth/presentations/pages/login_page.dart';
import 'package:fortuno/features/auth/presentations/widgets/auth_listener_widget.dart';

final authRoute = <RouteBase>[
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: LoginPage.path,
    builder:
        (context, state) => BlocProvider(
          create: (context) => getIt<AuthBloc>(),
          child: AuthListener(
            builder: (context, state) {
              return LoginPage();
            },
          ),
        ),
  ),
];
