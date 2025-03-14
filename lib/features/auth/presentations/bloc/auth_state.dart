part of 'auth_bloc.dart';

class AuthState extends BaseState {
  const AuthState({super.error, super.loading});

  @override
  BaseState copyWith({LoadingOpts? loading, ValueGetter<Failure?>? error}) {
    return AuthState(
      loading: loading ?? this.loading,
      error: error != null ? error.call() : this.error,
    );
  }
}

final class AuthInitial extends AuthState {}

final class AuthSucces extends AuthState {
  final bool isLoggin;

  const AuthSucces({required this.isLoggin});
}

final class LoggedOut extends AuthState {}
