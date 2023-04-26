import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefernces {
  AppSharedPrefernces._();

  static AppSharedPrefernces appSharedPrefernces = AppSharedPrefernces._();
  static SharedPreferences? _sharedPreferences;

  Future<void> initSharedPred() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Object? getDate(String key) {
    return _sharedPreferences!.get(key);
  }

  Future<bool> setData(String key, dynamic data) async {
    if (data.runtimeType == String) {
      return await _sharedPreferences!.setString(key, data);
    }
    if (data.runtimeType == bool) {
      return await _sharedPreferences!.setBool(key, data);
    }
    if (data.runtimeType == int) {
      return await _sharedPreferences!.setInt(key, data);
    }
    if (data.runtimeType == double) {
      return await _sharedPreferences!.setDouble(key, data);
    }
    if (data.runtimeType == List<String>) {
      return await _sharedPreferences!.setStringList(key, data);
    }

    return false;
  }

  Future<bool> deleteData(String key) async {
    return await _sharedPreferences!.remove(key);
  }

  Future<bool> clearSharedApp() async {
    return await _sharedPreferences!.clear();
  }
}
