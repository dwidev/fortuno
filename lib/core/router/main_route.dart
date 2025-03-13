import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentations/pages/login_page.dart';
import '../../features/main_page.dart';
import '../../features/order/presentations/bloc/cart/cart_bloc.dart';
import '../../features/order/presentations/bloc/order/order_bloc.dart';
import '../core.dart';
import '../depedency_injection/injection.dart';
import 'auth_route.dart';
import 'create_order_route.dart';
import 'process_order_route.dart';
import 'profile_route.dart';

export 'main_route.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");
final createOrderRouteKey = GlobalKey<NavigatorState>(
  debugLabel: "create-order-route",
);
final processOrderRoutKey = GlobalKey<NavigatorState>(
  debugLabel: "process-order-route",
);
final profilRouteKey = GlobalKey<NavigatorState>(debugLabel: "profile-route");

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: LoginPage.path,
  // initialLocation: CreateOrderPage.path,
  routes: [
    // auth route
    ...authRoute,
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<OrderBloc>()),
            BlocProvider(create: (context) => getIt<CartBloc>()),
          ],
          child: MainPage(navigationShell: navigationShell),
        );
      },
      branches: [
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

        // profile
        StatefulShellBranch(navigatorKey: profilRouteKey, routes: profilRoute),
      ],
    ),
  ],
);
