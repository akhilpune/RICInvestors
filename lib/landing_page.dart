
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ricinvestors/services/database.dart';
import 'package:ricinvestors/ui/sign_in/sign_in_page.dart';
import 'package:ricinvestors/ui/property_list.dart';

import 'package:ricinvestors/services/auth.dart';





// User _user;
//
//  @override
//  void init() {
//    super.initState();
//    _checkCurrentUser() ;
//  widget.auth.onAuthStateChanged.listen((user){
//    print(  null);
//  });
//  }
//
//  Future<void> _checkCurrentUser() async{
//   User user = await widget.auth.currentUser();
//    _updateUser(user);
//  }
//
//  void _updateUser(User user){
//    setState(() {
//      _user = user;
//    });
//  }
//

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return SignInPage.create(context);
            }
            return Provider<User>.value(
              value: user,
              child: Provider<Database>(
                builder: (_) => FirestoreDatabase(uid: user.uid),
                child: PropertyList(),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
