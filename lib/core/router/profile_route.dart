import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortuno/features/auth/presentations/widgets/auth_listener_widget.dart';
import '../depedency_injection/injection.dart';
import '../../features/auth/presentations/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/profile/pages/profile_page.dart';
import 'main_route.dart';

final profilRoute = <RouteBase>[
  GoRoute(
    parentNavigatorKey: profilRouteKey,
    path: ProfilePage.path,
    builder: (context, state) {
      return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => getIt<AuthBloc>())],
        child: AuthListener(builder: (context, state) => ProfilePage()),
      );
    },
  ),
];
