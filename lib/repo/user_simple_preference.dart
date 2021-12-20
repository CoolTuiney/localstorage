import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreference {
  static late SharedPreferences _preferences;
  static const keyUsername = 'email';
  static const keyPassword = 'password';
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setEmail(String email) async {
    bool isExist = isEmailExist(email);
    return (isExist)
        ? await _preferences.setString(email + keyUsername, email)
        : false;
  }

  static Future<bool> setPassword(String email, String password) async {
    return await _preferences.setString(email + keyPassword, password);
  }

  static bool isEmailExist(String email) {
    String? result = getEmail(email + keyUsername);
    return result == null ? false : true;
  }

  static String? getEmail(String keyUsername) {
    return _preferences.getString(keyUsername);
  }

  static Future<bool> removePreferences(String email) async {
    return await _preferences.remove(email);
  }
}
