import 'dart:async';

import 'package:meta/meta.dart';
import 'package:ricinvestors/models/user.dart';




abstract class Database {

}



class FirebaseDatabase implements Database {
  FirebaseDatabase({@required this.uid}) : assert(uid != null);
  final String uid;


}
