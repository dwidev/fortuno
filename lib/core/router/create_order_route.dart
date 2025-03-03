import 'package:fortuno/core/core.dart';

import '../../features/order/pages/create_order_page.dart';

final createOrderRoute = <RouteBase>[
  GoRoute(
    parentNavigatorKey: createOrderRouteKey,
    path: CreateOrderPage.path,
    builder: (context, state) {
      return CreateOrderPage();
    },
  ),
];
