part of 'auth_bloc.dart';

class AuthEvent extends BaseEvent {
  @override
  List<Object> get props => [];
}

final class OnCheckAuthorize extends AuthEvent {}

final class OnSignWithGoogleEvent extends AuthEvent {}

final class OnSignOutEvent extends AuthEvent {}
