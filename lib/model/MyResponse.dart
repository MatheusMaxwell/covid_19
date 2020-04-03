
import 'package:covid19/model/CountryCode.dart';
import 'package:covid19/model/Current.dart';

import 'Country.dart';

class MyResponse{
  Current current;
  List<Country> countryWise;

  MyResponse({this.current, this.countryWise});

  MyResponse.fromMap(Map map):
      current = Current.fromMap(map['current']),
      countryWise = getCountries(map['countryWise']);


  static List<Country> getCountries(List<dynamic> map) {

    List<Country> list = List<Country>();

    for( int i=0; i < map.length; i++ ) {

      list.add(Country.fromMap(map[i]));

    }

    return list;

  }
}