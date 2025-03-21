import '../../features/order/presentations/bloc/cart/cart_bloc.dart';
import '../../features/order/presentations/bloc/order/order_bloc.dart';
import '../../features/order/presentations/pages/create_order/create_order_page.dart';
import '../core.dart';
import '../depedency_injection/injection.dart';

final createOrderRoute = <RouteBase>[
  GoRoute(
    parentNavigatorKey: createOrderRouteKey,
    path: CreateOrderPage.path,
    builder: (context, state) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<OrderBloc>()),
          BlocProvider(create: (context) => getIt<CartBloc>()),
        ],
        child: CreateOrderPage(key: UniqueKey()),
      );
    },
  ),
];
