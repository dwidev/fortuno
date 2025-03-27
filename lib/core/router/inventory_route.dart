import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/products/presentation/bloc/product_bloc.dart';
import '../../features/products/presentation/pages/add_category_product_page.dart';
import '../../features/products/presentation/pages/add_package_page.dart';
import '../../features/products/presentation/pages/add_product_page.dart';
import '../../features/products/presentation/pages/inventory_page.dart';
import '../depedency_injection/injection.dart';
import 'main_route.dart';

final inventoryRoute = <RouteBase>[
  GoRoute(
    parentNavigatorKey: inventoryRouteKey,
    path: InvetoryPage.path,
    name: InvetoryPage.path,
    builder: (context, state) {
      return InvetoryPage();
      final inventory = getIt<ProductsBloc>();

      return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => inventory)],
        child: InvetoryPage(),
      );
    },
    routes: [
      GoRoute(
        parentNavigatorKey: inventoryRouteKey,
        path: AddCategoryProductPage.path,
        name: AddCategoryProductPage.path,
        builder: (context, state) {
          return AddCategoryProductPage();
        },
      ),
      GoRoute(
        parentNavigatorKey: inventoryRouteKey,
        path: AddProductPage.path,
        name: AddProductPage.path,
        builder: (context, state) {
          return AddProductPage();
        },
      ),
      GoRoute(
        parentNavigatorKey: inventoryRouteKey,
        path: AddPackagePage.path,
        name: AddPackagePage.path,
        builder: (context, state) {
          return AddPackagePage();
        },
      ),
    ],
  ),
];
