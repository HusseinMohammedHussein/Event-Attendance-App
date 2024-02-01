import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async => await SharedPreferences.getInstance();

  static late SharedPreferences _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String getString(String key, [String? defValue]) {
    return _prefsInstance.getString(key) ?? defValue ?? "";
  }

  static Future<void> setString(String key, String value) async {
    var prefs = await _instance;
    prefs.setString(key, value);
  }

  static bool getBool(String key) {
    return _prefsInstance.getBool(key) ?? false;
  }

  static Future<void> setBool(String key, bool value) async {
    var prefs = await _instance;
    prefs.setBool(key, value);
  }
}
