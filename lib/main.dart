

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ricinvestors/landing_page.dart';
import 'package:ricinvestors/services/auth.dart';


void main() {
  runApp(MyApp());
}




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      builder: (context) => Auth(),
      child: MaterialApp(
        title: 'RIC Investor',
        //theme: ThemeData(
        //  primarySwatch: Colors.indigo,
        //),
        home: LandingPage(),
      ),
    );
  }
}
