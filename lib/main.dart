import 'package:covid19/ui/countries_list/CountriesList.dart';
import 'package:covid19/ui/country_detail/country_detail_page.dart';
import 'package:covid19/ui/home_page/home_page.dart';
import 'package:covid19/ui/splash/splash_screen.dart';
import 'package:covid19/utils/SizeRoute.dart';
import 'package:flutter/material.dart';

import 'ext/Constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final routes = {
    Constants.SPLASH_SCREEN: (BuildContext context) => SizeRoute(page: SplashScreen()),
    Constants.HOME_PAGE: (BuildContext context) => SizeRoute(page: HomePage()),
    Constants.COUNTRY_LIST: (BuildContext context) => SizeRoute(page: CountriesList()),
    Constants.COUNTRY_DETAIL: (BuildContext context) => SizeRoute(page: CountryDetail())
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-19',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashScreen(),
    );
  }
}

