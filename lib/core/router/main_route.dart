import '../../features/auth/presentations/bloc/auth_bloc.dart';
import '../../features/auth/presentations/pages/splash_page.dart';
import '../../features/auth/presentations/widgets/auth_listener_widget.dart';
import '../../features/main_page.dart';
import '../core.dart';
import '../depedency_injection/injection.dart';
import 'auth_route.dart';
import 'create_order_route.dart';
import 'dashboard_route.dart';
import 'process_order_route.dart';
import 'profile_route.dart';

export 'main_route.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");

final dashboardRouteKey = GlobalKey<NavigatorState>(
  debugLabel: "dashboard-route",
);

final createOrderRouteKey = GlobalKey<NavigatorState>(
  debugLabel: "create-order-route",
);
final processOrderRoutKey = GlobalKey<NavigatorState>(
  debugLabel: "process-order-route",
);
final profilRouteKey = GlobalKey<NavigatorState>(debugLabel: "profile-route");

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: SplashPage.path,
  routes: [
    // auth route
    ...authRoute,

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MultiBlocProvider(
          providers: [BlocProvider(create: (context) => getIt<AuthBloc>())],
          child: AuthListener(
            builder: (context, bloc, state) {
              return MainPage(navigationShell: navigationShell);
            },
          ),
        );
      },
      branches: [
        // dashboard
        StatefulShellBranch(
          navigatorKey: dashboardRouteKey,
          routes: dashboardRoute,
        ),

        // create order route
        StatefulShellBranch(
          navigatorKey: createOrderRouteKey,
          routes: createOrderRoute,
        ),

        // process order route
        StatefulShellBranch(
          navigatorKey: processOrderRoutKey,
          routes: processOrderRoute,
        ),

        // inventaris
        StatefulShellBranch(navigatorKey: profilRouteKey, routes: profilRoute),

        // // notification
        // StatefulShellBranch(navigatorKey: profilRouteKey, routes: profilRoute),

        // // settings
        // StatefulShellBranch(navigatorKey: profilRouteKey, routes: profilRoute),
      ],
    ),
  ],
);
