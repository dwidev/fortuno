import 'package:go_router/go_router.dart';

import '../../features/profile/pages/profile_page.dart';
import 'main_route.dart';

final profilRoute = <RouteBase>[
  GoRoute(
    parentNavigatorKey: profilRouteKey,
    path: ProfilePage.path,
    builder: (context, state) {
      return ProfilePage();
    },
  ),
];
