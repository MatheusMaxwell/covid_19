

import 'package:covid19/utils/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

class Destination {
  const Destination(this.title, this.icon, this.color);
  final String title;
  final IconData icon;
  final Color color;
}

const List<Destination> allDestinations = <Destination>[
  Destination('Mundo', MyFlutterApp.globe, Colors.white),
  Destination('Países', Icons.list, Colors.white)
];