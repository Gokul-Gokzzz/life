import 'package:shared_preferences/shared_preferences.dart';

class StoreService {
  Future<void> setKeys(key, value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, value);
  }

  Future<String?> getValues(key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }

  Future<void> clearValues() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

    static Future<String?> getLoginUserId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('member_id');
  }

  static Future<bool> setLoginUserId(String id) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString('member_id', id);
  }
}
