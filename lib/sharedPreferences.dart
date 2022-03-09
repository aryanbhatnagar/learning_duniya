import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  saveValue(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  saveBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  readValue(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString(key);
    if (data != null || data != "") {
      return data;
    } else {
      return null;
    }
  }

  readBool(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getBool(key);
    if (data != null || data != "") {
      return data;
    } else {
      return null;
    }
  }
}
