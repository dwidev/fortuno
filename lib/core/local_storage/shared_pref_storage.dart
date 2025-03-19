import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage.dart';

@sharedPref
@LazySingleton(as: ILocalStorage)
class SharedPrefStorage implements ILocalStorage {
  final SharedPreferences preferences;

  SharedPrefStorage({required this.preferences});

  @override
  Future<Object?> getData(String key) async {
    final res = preferences.get(key);
    return res;
  }

  @override
  Future<void> storeData(String key, Object data) async {
    if (data is String) {
      await preferences.setString(key, data);
      return;
    }

    throw UnimplementedError(
      'data with the ${data.runtimeType} type is un implement at SharedPrefStorage.storeData',
    );
  }

  @override
  Future<void> clearAllData() async {
    await preferences.clear();
  }

  @override
  Future<void> clearDataByKey(String key) async {
    await preferences.remove(key);
  }
}
