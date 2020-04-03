
import 'package:covid19/model/Country.dart';

class CountryCode{
  String code;
  String name;

  CountryCode({this.code, this.name});

  CountryCode.fromMap(Map map):
      code = map['code'],
      name = map['name'];

}