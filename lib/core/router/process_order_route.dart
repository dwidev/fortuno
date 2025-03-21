import '../../features/order/presentations/bloc/order_process/order_process_bloc.dart';
import '../../features/order/presentations/pages/process_order/process_order_page.dart';
import '../core.dart';
import '../depedency_injection/injection.dart';

final processOrderRoute = <RouteBase>[
  GoRoute(
    parentNavigatorKey: processOrderRoutKey,
    path: ProcessOrderPage.path,
    builder: (context, state) {
      final key = state.extra as Key? ?? ValueKey("ProcessOrderPage");

      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<OrderProcessBloc>()),
        ],
        child: ProcessOrderPage(key: key),
      );
    },
  ),
];
