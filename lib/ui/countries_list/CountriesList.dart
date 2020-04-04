

import 'dart:convert';

import 'package:covid19/ext/Constants.dart';
import 'package:covid19/model/Country.dart';
import 'package:covid19/model/MyResponse.dart';
import 'package:covid19/ui/country_detail/country_detail_page.dart';
import 'package:covid19/utils/AppSingleton.dart';
import 'package:covid19/utils/SizeRoute.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CountriesList extends StatefulWidget {
  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {

  var searchField = "";
  List<Country> countries = AppSingleton.myResponse.countryWise;
  List<Country> initialList = AppSingleton.myResponse.countryWise;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Países"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          TextField(
              textInputAction: TextInputAction.done,
              onChanged: searchCountry,
              decoration: InputDecoration(
                hintText: "Busca",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                prefixIcon: Icon(Icons.search),
              )
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: countries.isNotEmpty ? ListView.builder(
                itemCount: countries.length,
                itemBuilder: (BuildContext context, int index){
                  return cardSingleText(countries[index]);
                },
              )
                  : Center(
                child: CircularProgressIndicator(),
              )
          )
        ],
      ),
    );
  }

  searchCountry(String text) {
    setState(() {
      searchField = text;
    });
    getCountriesFiltered();
  }

  getCountriesFiltered(){
    List<Country> list = List<Country>();
    if(searchField.isNotEmpty) {
      for (var c in initialList) {
        if (c.country.toUpperCase().contains(searchField.toUpperCase())) {
          list.add(c);
        }
      }
    }
    else{
      list = initialList;
    }

    setState(() {
      countries = list;
    });
  }

  cardSingleText(Country country){
    return GestureDetector(
      onTap: (){
        AppSingleton.country = country;
        Navigator.of(context).push(SizeRoute(page: CountryDetail()));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
        ),
        child: Container(
          height: 80.0,
          child: Row(
            children: <Widget>[
              Container(
                height: 60.0,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(country.country, style: TextStyle(fontSize: 26),),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
