part of 'auth_bloc.dart';

class AuthState extends BaseState {
  const AuthState({super.error, super.loading});

  @override
  List<Object> get props => [];

  @override
  BaseState copyWith({LoadingOpts? loading, Failure? error}) {
    return AuthState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}

final class AuthInitial extends AuthState {}

final class AuthSucces extends AuthState {
  final bool isLoggin;

  const AuthSucces({required this.isLoggin});
}

final class LoggedOut extends AuthState {}
