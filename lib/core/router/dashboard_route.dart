import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentations/widgets/auth_listener_widget.dart';
import '../../features/dashboard/presentation/page/dashboard_page.dart';
import '../depedency_injection/injection.dart';
import '../../features/auth/presentations/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

import 'main_route.dart';

final dashboardRoute = <RouteBase>[
  GoRoute(
    parentNavigatorKey: dashboardRouteKey,
    path: DashboardPage.path,
    builder: (context, state) {
      return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => getIt<AuthBloc>())],
        child: AuthListener(builder: (context, bloc, state) => DashboardPage()),
      );
    },
  ),
];
