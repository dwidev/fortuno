import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/products/presentation/pages/inventory_page.dart';
import '../../features/profile/pages/profile_page.dart';
import 'main_route.dart';

final inventoryRoute = <RouteBase>[
  GoRoute(
    parentNavigatorKey: inventoryRouteKey,
    path: InvetoryPage.path,
    builder: (context, state) {
      return MultiBlocProvider(providers: [], child: InvetoryPage());
    },
  ),
];
