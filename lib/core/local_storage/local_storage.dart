import '../core.dart';

const secureStorage = Named('secure-storage');
const sharedPref = Named('shared-pref');

abstract class ILocalStorage {
  Future<void> storeData(String key, Object data);
  Future<Object?> getData(String key);
  Future<void> clearDataByKey(String key);
  Future<void> clearAllData();
}
