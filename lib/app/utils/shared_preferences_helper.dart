import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesHelper {
  static const String name = "name";
  static const String userName = "USERNAME";
  static const String userId = "USERID";
  static const String email = "Email";
  static const String mobileNo = "MobileNo";
  static const String registerLoginData = "registerLoginData";

  static Future<void> setStringInEncryptedFormat(key, value) async {
    var prefs = await SharedPreferences.getInstance();

    if (value.toString().isEmpty) {
      prefs.setString(key, value);
    } else {
      prefs.setString(key, value);
    } //Saving encrypted data in Shared Preferences
  }

  static Future<void> setString(key,value) async {
    var prefs = await SharedPreferences.getInstance();
    String token =  prefs.getString("token")??"";

    if (value.toString().isEmpty) {
      prefs.setString(key, value);
    } else {
      prefs.setString(key, value);
    } //Saving encrypted data in Shared Preferences
  }

  static Future<String> getString(key) async {
    try {
      var pref = await SharedPreferences.getInstance();
      return (pref.getString(key)) ?? ""; //Receiving encrypted data in Shared Preferences
    } catch (e) {
      return ""; // Do not remove this line
    }
  }

  static Future<void> setInt(key, value) async {
    var pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
  }

  static Future<int> getInt(key) async {
    var pref = await SharedPreferences.getInstance();
    return (pref.getInt(key)) ?? 0;
  }

  static Future<void> clear() async {
    var pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
