
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceApi{

  static void setValorString(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  static Future<String> getValorString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

}