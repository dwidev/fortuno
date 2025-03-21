// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:fortuno/core/local_storage/local_storage.dart';

const accessTokenKey = 'access_token';
const refreshTokenKey = 'refresh_token';
const companyIdKey = 'company_id';

class UserAuthenticated extends Equatable {
  final String accessToken;
  final String refreshToken;
  final String companyID;

  const UserAuthenticated({
    required this.accessToken,
    required this.refreshToken,
    required this.companyID,
  });

  factory UserAuthenticated.unAuthorize() =>
      UserAuthenticated(accessToken: "", refreshToken: "", companyID: "");

  Future<void> storeToStorage(
    ILocalStorage secStorage,
    ILocalStorage preference,
  ) async {
    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      await Future.wait([
        secStorage.storeData(accessTokenKey, accessToken),
        secStorage.storeData(refreshTokenKey, refreshToken),
      ]);
    }

    if (companyID.isNotEmpty) {
      await preference.storeData(companyIdKey, companyID);
    }
  }

  static Future<void> clearData(
    ILocalStorage secStorage,
    ILocalStorage preference,
  ) async {
    await Future.wait([
      secStorage.clearDataByKey(accessTokenKey),
      secStorage.clearDataByKey(refreshTokenKey),
      preference.clearDataByKey(companyIdKey),
    ]);
  }

  @override
  List<Object> get props => [accessToken, refreshToken, companyID];

  @override
  bool get stringify => true;

  UserAuthenticated copyWith({
    String? accessToken,
    String? refreshToken,
    String? companyID,
  }) {
    return UserAuthenticated(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      companyID: companyID ?? this.companyID,
    );
  }
}
