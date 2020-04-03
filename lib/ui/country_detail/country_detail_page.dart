
import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid19/model/Country.dart';
import 'package:covid19/utils/AppSingleton.dart';
import 'package:covid19/utils/Widgets.dart';
import 'package:flutter/material.dart';

class CountryDetail extends StatefulWidget {
  @override
  _CountryDetailState createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {
  
  Country country;
  String code;
  
  @override
  void initState() {
    country = AppSingleton.country;
    _getCodeCountry();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country.country), centerTitle: true,
      ),
      body: _body(),
    );
  }
  
  _body(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              code != null ? _image("https://flagpedia.net/data/flags/normal/$code.png") : space(0.0),
              space(20.0),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      _row("Todal de casos: ", country.totalCases),
                      space(10.0),
                      _row("Novos casos: ", country.newCases),
                      space(10.0),
                      _row("Todal de mortes: ", country.totalDeaths),
                      space(10.0),
                      _row("Recuperados: ", country.totalRecovered),
                      space(10.0),
                      _row("Casos por milhão: ", country.totalCasesPerMillion),
                      space(10.0),
                      _row("Mortes por milhão: ", country.totalDeathsPerMillion)
                    ],
                  ),
                ),
              ),
            ],
          ),
          code == null ? Container(
            color: Colors.white70,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ) : space(0.0)
        ],
      ),
    );
  }

  _image(String link){
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
      ),
      child: CachedNetworkImage(
        imageUrl: link,
        imageBuilder: (context, imageProvider) => Container(
          height: 220,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
        ),
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Image.asset("assets/images/emptyimage.jpg"),
      ),
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

  _getCodeCountry(){
    for(var c in AppSingleton.listCountryCode){
      var name = country.country.toUpperCase();
      if(name == "USA")
        name = "UNITED STATES";
      if(c.name.toUpperCase() == name){
        setState(() {
          code = c.code.toLowerCase();
        });
        break;
      }
    }
  }
}
