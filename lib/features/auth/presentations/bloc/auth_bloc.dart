import 'package:bloc/bloc.dart';
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
    emit(IsLoading());

    final response = await signWithGoogle(null);

    response.fold(
      (err) {
        emit(OnError(error: err));
      },
      (right) {
        emit(AuthSucces(isLoggin: true));
      },
    );
  }

  Future<void> _onSignOut(OnSignOutEvent event, Emitter emit) async {
    emit(IsLoading());

    final response = await signOut(null);

    response.fold(
      (err) {
        emit(OnError(error: err));
      },
      (right) {
        emit(LoggedOut());
      },
    );
  }
}
