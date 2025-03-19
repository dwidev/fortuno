import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage3rdPartyFactory {
  static Future<SharedPreferences> preference() async {
    final pref = await SharedPreferences.getInstance();
    return pref;
  }

  static FlutterSecureStorage secureStorage() {
    final aOpts = AndroidOptions(encryptedSharedPreferences: true);
    final iosOpts = IOSOptions(accountName: "fortuno-pos");
    final secureStorage = FlutterSecureStorage(
      aOptions: aOpts,
      iOptions: iosOpts,
    );
    return secureStorage;
  }
}
