import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static const _keyUid = 'uid';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUid(String uid) async =>
      await _preferences!.setString(_keyUid, uid);

  static String? getUid() => _preferences!.getString(_keyUid);
}
