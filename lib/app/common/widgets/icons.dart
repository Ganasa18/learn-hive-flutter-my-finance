import 'package:flutter/material.dart';
import 'package:my_finance_apps/app/core/values/icons_value.dart';

List<Icon> getIcons() {
  return const [
    Icon(
      IconData(personIcon, fontFamily: 'MaterialIcons'),
      color: Colors.blueAccent,
    ),
    Icon(
      IconData(workIcon, fontFamily: 'MaterialIcons'),
      color: Colors.blueAccent,
    ),
    Icon(
      IconData(movieIcon, fontFamily: 'MaterialIcons'),
      color: Colors.blueAccent,
    ),
    Icon(
      IconData(sportIcon, fontFamily: 'MaterialIcons'),
      color: Colors.blueAccent,
    ),
    Icon(
      IconData(travelIcon, fontFamily: 'MaterialIcons'),
      color: Colors.blueAccent,
    ),
    Icon(
      IconData(shopIcon, fontFamily: 'MaterialIcons'),
      color: Colors.blueAccent,
    ),
  ];
}
