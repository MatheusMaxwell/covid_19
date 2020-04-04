
import 'dart:convert';

import 'package:covid19/ext/Constants.dart';
import 'package:covid19/model/CountryCode.dart';
import 'package:covid19/ui/home_page/home_page.dart';
import 'package:covid19/utils/AppSingleton.dart';
import 'package:covid19/utils/SizeRoute.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    AppSingleton.listCountryCode = getCodes(jsonDecode(Constants.CODE_COUNTRY_LIST));
    Future.delayed(Duration(seconds: 4)).then((_) {
      Navigator.of(context).pushReplacement(SizeRoute(page: HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset("assets/images/worldgif.gif", width: 90, height: 90,)
      ),
    );
  }

  static List<CountryCode> getCodes(List<dynamic> map) {

    List<CountryCode> list = List<CountryCode>();

    for( int i=0; i < map.length; i++ ) {

      list.add(CountryCode.fromMap(map[i]));

    }

    return list;

  }
}
