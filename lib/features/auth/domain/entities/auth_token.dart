import 'package:equatable/equatable.dart';
import 'package:fortuno/core/local_storage/local_storage.dart';

const accessTokenKey = 'access_token';
const refreshTokenKey = 'refresh_token';

class AuthToken extends Equatable {
  final String accessToken;
  final String refreshToken;

  const AuthToken({required this.accessToken, required this.refreshToken});

  factory AuthToken.unAuthorize() =>
      AuthToken(accessToken: "", refreshToken: "");

  Future<void> storeToStorage(LocalStorage secStorage) async {
    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      await Future.wait([
        secStorage.storeData(accessTokenKey, accessToken),
        secStorage.storeData(refreshTokenKey, refreshToken),
      ]);
    }
  }

  static Future<void> clearToken(LocalStorage secStorage) async {
    await Future.wait([
      secStorage.clearDataByKey(accessTokenKey),
      secStorage.clearDataByKey(refreshTokenKey),
    ]);
  }

  @override
  List<Object> get props => [accessToken, refreshToken];

  @override
  bool get stringify => true;
}
