import 'package:flutter_bloc/flutter_bloc.dart';
import '../depedency_injection/injection.dart';
import '../../features/products/presentation/bloc/product_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/products/presentation/pages/inventory_page.dart';
import 'main_route.dart';

final inventoryRoute = <RouteBase>[
  GoRoute(
    parentNavigatorKey: inventoryRouteKey,
    path: InvetoryPage.path,
    builder: (context, state) {
      final inventory = getIt<ProductsBloc>();

      return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => inventory)],
        child: InvetoryPage(),
      );
    },
  ),
];
