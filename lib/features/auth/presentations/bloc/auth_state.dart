part of 'auth_bloc.dart';

sealed class AuthState extends BaseState {
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthSucces extends AuthState {
  final bool isLoggin;

  AuthSucces({required this.isLoggin});
}

final class LoggedOut extends AuthState {}
