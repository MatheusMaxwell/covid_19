
import 'package:covid19/model/Country.dart';
import 'package:covid19/model/CountryCode.dart';
import 'package:covid19/model/MyResponse.dart';

class AppSingleton {
  static AppSingleton _instance;

  factory AppSingleton() {
    _instance ??= AppSingleton._internalConstructor();
    return _instance;
  }

  AppSingleton._internalConstructor();

  static MyResponse myResponse;
  static List<CountryCode> listCountryCode;
  static Country country;
}