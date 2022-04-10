import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static const _keyUid = 'uid';
  static const _keyUserData = 'userData';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUid(String uid) async =>
      await _preferences!.setString(_keyUid, uid);

  static String? getUid() => _preferences!.getString(_keyUid);

  static Future setUserData(List<String> userData) async =>
      await _preferences!.setStringList(_keyUserData, userData);

  static List<String>? getUserData() =>
      _preferences!.getStringList(_keyUserData);
}
