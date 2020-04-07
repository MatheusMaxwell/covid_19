
import 'dart:convert';

import 'package:covid19/ext/Constants.dart';
import 'package:covid19/model/Current.dart';
import 'package:covid19/model/MyResponse.dart';
import 'package:covid19/ui/countries_list/CountriesList.dart';
import 'package:covid19/utils/AppSingleton.dart';
import 'package:covid19/utils/Destination.dart';
import 'package:covid19/utils/MySharedPreferences.dart';
import 'package:covid19/utils/SizeRoute.dart';
import 'package:covid19/utils/Widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin<HomePage> {

  var searchField = "";
  Current current;
  bool isUpdate = false;
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mundo"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: _bodyIndex(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: allDestinations.map((Destination destination) {
          return BottomNavigationBarItem(
              icon: Icon(destination.icon, color: destination.color,),
              title: Text(destination.title, style: TextStyle(color: destination.color),)
          );
        }).toList(),
      ),
    );
  }

  _bodyIndex(int index){
    switch(index){
      case 0: return _body();
      case 1: return CountriesList();
    }
  }

  _body(){
    if(current == null)
      _getJSONData();

    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset("assets/images/world.png"),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      _row("Todal de casos: ", current != null ? current.totalCases: ""),
                      space(10.0),
                      _row("Novos casos: ", current != null ? current.newCases: ""),
                      space(10.0),
                      _row("Todal de mortes: ", current != null ? current.totalDeaths: ""),
                      space(10.0),
                      _row("Recuperados: ", current != null ? current.totalRecovered: ""),
                    ],
                  ),
                ),
              ),
              space(20.0),
              _button("ATUALIZAR DADOS", true),
            ],
          ),
        ),
        current == null ? Container(
          color: Colors.white70,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ) : space(0.0)
      ],
    );
  }

  _button(String text, bool isUpdateButton){
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      color: isUpdateButton ? Colors.grey: Colors.red,
      onPressed: (){
        if(isUpdateButton){
          setState(() {
            isUpdate = true;
            current = null;
          });
        }
      },
    );
  }

  _row(String text, String value){
    value = value.replaceAll(",", ".");
    return Row(
      children: <Widget>[
        Text(text, style: TextStyle(fontSize: 24),),
        Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)
      ],
    );
  }

  Future<void> _getJSONData() async {
    String respSharedPref = await MySharedPreferences.getJson(Constants.SHARED_PREFS);
    MyResponse res;
    if(respSharedPref != null && respSharedPref.isNotEmpty && !isUpdate){
      res = MyResponse.fromMap(json.decode(respSharedPref));
      AppSingleton.myResponse = res;
    }
    else{
      var response = await http.get(
          Uri.encodeFull(Constants.BASE_URL+Constants.LIVE_STATS),
          headers: {"Accept": "application/json",
            "x-rapidapi-host": "covid-19-live-stats.p.rapidapi.com",
            "x-rapidapi-key": "d7f91f96fbmsh3b19878588c3ce6p1f5b9fjsnbb905c9c8d6a"}
      );
      res = MyResponse.fromMap(json.decode(response.body));
      MySharedPreferences.saveJson(response.body, Constants.SHARED_PREFS);
      AppSingleton.myResponse = res;
    }
    setState(() {
      isUpdate = false;
      current = res.current;
    });
  }

}
