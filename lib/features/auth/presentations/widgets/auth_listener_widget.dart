import 'package:go_router/go_router.dart';

import '../../../../core/bloc/base_bloc.dart';
import '../../../../core/depedency_injection/injection.dart';
import '../../../dashboard/presentation/page/dashboard_page.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/signin_with_google.dart';
import '../bloc/auth_bloc.dart';
import '../pages/login_page.dart';

/// class for listen auth bloc
class AuthListener extends BaseListenerWidget<AuthBloc, AuthState> {
  const AuthListener({super.key, super.listener, required super.builder});

  @override
  void onListener(context, state) {
    if (state is AuthSucces && state.isLoggin) {
      _clearResoureLogin();
      context.go(DashboardPage.path);
    }

    if (state is LoggedOut) {
      _clearResoureLogout();
      context.go(LoginPage.path);
    }

    super.onListener(context, state);
  }

  void _clearResoureLogin() {
    getIt.resetLazySingleton<SignWithGoogle>();
  }

  void _clearResoureLogout() {
    getIt.resetLazySingleton<SignOut>();
  }
}
