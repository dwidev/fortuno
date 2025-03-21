import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'local_storage.dart';

@secureStorage
@LazySingleton(as: ILocalStorage)
class SecureStorage implements ILocalStorage {
  final FlutterSecureStorage secureStorage;

  SecureStorage({required this.secureStorage});

  @override
  Future<String?> getData(String key) async {
    final res = await secureStorage.read(key: key);
    return res;
  }

  @override
  Future<void> storeData(String key, Object data) async {
    await secureStorage.write(key: key, value: data.toString());
  }

  @override
  Future<void> clearAllData() async {
    await secureStorage.deleteAll();
  }

  @override
  Future<void> clearDataByKey(String key) async {
    await secureStorage.delete(key: key);
  }
}
