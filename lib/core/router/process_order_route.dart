import 'package:go_router/go_router.dart';

import '../../features/order/presentations/pages/process_order_page.dart';
import 'main_route.dart';

final processOrderRoute = <RouteBase>[
  GoRoute(
    parentNavigatorKey: processOrderRoutKey,
    path: ProcessOrderPage.path,
    builder: (context, state) {
      return ProcessOrderPage();
    },
  ),
];
