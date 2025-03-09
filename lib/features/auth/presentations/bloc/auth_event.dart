part of 'auth_bloc.dart';

class AuthEvent extends BaseEvent {
  @override
  List<Object> get props => [];
}

final class OnSignWithGoogleEvent extends AuthEvent {}
