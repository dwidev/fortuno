import '../../../../core/bloc/base_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../pages/login_page.dart';
import '../../../order/pages/create_order_page.dart';
import 'package:go_router/go_router.dart';

/// class for listen auth bloc
class AuthListener extends BaseListenerWidget<AuthBloc, AuthState> {
  const AuthListener({super.key, super.listener, required super.builder});

  @override
  void onListener(context, state) {
    if (state is AuthSucces && state.isLoggin) {
      context.go(CreateOrderPage.path);
    }

    if (state is LoggedOut) {
      context.go(LoginPage.path);
    }

    super.onListener(context, state);
  }
}
