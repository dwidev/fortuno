import 'package:bloc/bloc.dart';
import '../../../../core/bloc/base_bloc.dart';
import '../../domain/usecases/signin_with_google.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends BaseAppBloc<AuthEvent, AuthState> {
  final SignWithGoogle signWithGoogle;

  AuthBloc({required this.signWithGoogle}) : super(AuthInitial()) {
    on<OnSignWithGoogleEvent>(_onSignWithEmail);
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
}
