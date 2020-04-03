
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences{

  static saveJson(String data, String key)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  static Future<String> getJson(String key)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

}