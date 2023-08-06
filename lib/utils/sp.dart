import 'package:shared_preferences/shared_preferences.dart';

class SP {

  static _getSP() async {
    return await SharedPreferences.getInstance();
  }
  static put(String key,String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
  static Future<String> get(String key,String? defaultValue)  async {
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    String s =prefs.getString(key).toString();
    return s;
  }
}