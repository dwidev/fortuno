import 'package:go_router/go_router.dart';

import '../../../../core/bloc/base_listener.dart';
import '../../../order/pages/create_order_page.dart';
import '../bloc/auth_bloc.dart';
import '../pages/login_page.dart';

/// class for listen auth bloc
class AuthListener extends BaseListenerWidget<AuthBloc, AuthState> {
  const AuthListener({super.key, super.listener, required super.builder});

  @override
  void onListener(context, state) {
    if (state is AuthSucces) {
      context.go(CreateOrderPage.path);
    }

    if (state is LoggedOut) {
      context.go(LoginPage.path);
    }

    super.onListener(context, state);
  }
}
