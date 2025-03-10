import 'package:bloc/bloc.dart';
import 'package:fortuno/core/failures/failure.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/bloc/base_bloc.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/signin_with_google.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends BaseAppBloc<AuthEvent, AuthState> {
  final SignWithGoogle signWithGoogle;
  final SignOut signOut;

  AuthBloc({required this.signWithGoogle, required this.signOut})
    : super(AuthInitial()) {
    on<OnSignWithGoogleEvent>(_onSignWithEmail);
    on<OnSignOutEvent>(_onSignOut);
  }

  Future<void> _onSignWithEmail(
    OnSignWithGoogleEvent event,
    Emitter emit,
  ) async {
    final response = await runUsecase(() => signWithGoogle(null), emit);

    response.fold(
      (err) {
        error(emit, err);
      },
      (right) {
        emit(AuthSucces(isLoggin: right));
      },
    );
  }

  Future<void> _onSignOut(OnSignOutEvent event, Emitter emit) async {
    final response = await runUsecase(() => signOut(null), emit);

    response.fold(
      (err) {
        error(emit, err);
      },
      (right) {
        emit(LoggedOut());
      },
    );
  }
}
