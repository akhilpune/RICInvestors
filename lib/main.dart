

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ricinvestors/landing_page.dart';
import 'package:ricinvestors/services/auth.dart';
import 'package:ricinvestors/ui/property_list.dart';

//void main() async {
// runApp(new InvestorApp());
//  }

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MaterialApp(
      home: InvestorApp(),
      debugShowCheckedModeBanner: false,
    ));
  });
}
class InvestorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Provider<AuthBase>(
      builder: (context) => Auth(),
      child: MaterialApp(
        title: 'RIC Investor',
    //    theme: ThemeData(
    //      primarySwatch: Colors.indigo,
    //    ),
        home: LandingPage(),
      ),
    );

  }
}

