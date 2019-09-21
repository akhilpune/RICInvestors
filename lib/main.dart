
import 'package:flutter/material.dart';
import 'package:ricinvestors/ui/property_list.dart';

void main() async {
  runApp(new InvestorApp());
}

class InvestorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.pinkAccent,
          fontFamily: 'Ubuntu'
      ),
      home: new PropertyList(),
    );
  }
}