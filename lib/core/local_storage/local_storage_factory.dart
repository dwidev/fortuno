import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage.dart';
import 'secure_storage.dart';
import 'shared_pref_storage.dart';

class LocalStorageFactory {
  static Future<LocalStorage> preference() async {
    final pref = await SharedPreferences.getInstance();
    return SharedPrefStorage(preferences: pref);
  }

  static LocalStorage secureStorage() {
    final aOpts = AndroidOptions(encryptedSharedPreferences: true);
    final iosOpts = IOSOptions(accountName: "fortuno-pos");
    final secureStorage = FlutterSecureStorage(
      aOptions: aOpts,
      iOptions: iosOpts,
    );
    return SecureStorage(secureStorage: secureStorage);
  }
}
