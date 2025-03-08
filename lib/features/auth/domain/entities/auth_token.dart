import 'package:equatable/equatable.dart';

class AuthToken extends Equatable {
  final String accessToken;
  final String refreshToken;

  const AuthToken({required this.accessToken, required this.refreshToken});

  @override
  List<Object> get props => [accessToken, refreshToken];

  @override
  bool get stringify => true;
}
