import 'package:fortuno/core/router/main_route.dart';
import 'package:go_router/go_router.dart';

import '../../features/order/pages/create_order_page.dart';

final createOrderRoute = <RouteBase>[
  GoRoute(
    parentNavigatorKey: createOrderRootKey,
    path: CreateOrderPage.path,
    builder: (context, state) {
      return CreateOrderPage();
    },
  ),
];
