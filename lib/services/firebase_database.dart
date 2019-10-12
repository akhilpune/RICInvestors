import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:ricinvestors/models/property.dart';

class FirebaseDatabaseUtil {
  DatabaseReference _counterRef;
  DatabaseReference _userRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  FirebaseDatabase database = new FirebaseDatabase();
  int _counter;
  DatabaseError error;

  static final FirebaseDatabaseUtil _instance =
  new FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void initState() {
    // Demonstrates configuring to the database using a file
    _counterRef = FirebaseDatabase.instance.reference().child('counter');
    // Demonstrates configuring the database directly

    _userRef = database.reference().child('properties');
    database.reference().child('counter').once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef.keepSynced(true);

    _counterSubscription = _counterRef.onValue.listen((Event event) {
      error = null;
      _counter = event.snapshot.value ?? 0;
    }, onError: (Object o) {
      error = o;
    });
  }

  DatabaseError getError() {
    return error;
  }

  int getCounter() {
    return _counter;
  }

  DatabaseReference getProperty() {
    return _userRef;
  }

  addProperty(Property user) async {
    final TransactionResult transactionResult =
    await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });

    if (transactionResult.committed) {
      _userRef.push().set(<String, String>{
        "propId": user.propId,
        "pname": user.pname,
        "description": user.description,
        "avatarUrl": user.avatarUrl,
        "location": user.location,
        "yeild": user.yeild,
        "mvalue": user.mvalue,
        "IRR": user.IRR,
        "isCompleted": user.isCompleted,
        "pictures1": user.pictures1,
        "pictures2": user.pictures2,
        "pictures3": user.pictures3,
        "pictures4": user.pictures4,
        "pictures5": user.pictures5,
        "pattributes1": user.pattributes1,
        "pattributes2": user.pattributes2,
        "pattributes3": user.pattributes3,
        "pattributes4": user.pattributes4,
        "pattributes5": user.pattributes5,
      }).then((_) {
        print('Transaction  committed.');
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }

  void deleteProperty(Property user) async {
    await _userRef.child(user.id).remove().then((_) {
      print('Transaction  committed.');
    });
  }

  void updateProperty(Property user) async {
    await _userRef.child(user.id).update({
      // "name": "" + user.name,
      // "email": "" + user.email,
      // "mobile": "" + user.mobile,

      "propId": user.propId,
      "pname": user.pname,
      "description": user.description,
      "avatarUrl": user.avatarUrl,
      "location": user.location,
      "yeild": user.yeild,
      "mvalue": user.mvalue,
      "IRR": user.IRR,
      "isCompleted": user.isCompleted,
      "pictures1": user.pictures1,
      "pictures2": user.pictures2,
      "pictures3": user.pictures3,
      "pictures4": user.pictures4,
      "pictures5": user.pictures5,

      "pattributes1": user.pattributes1,
      "pattributes2": user.pattributes2,
      "pattributes3": user.pattributes3,
      "pattributes4": user.pattributes4,
      "pattributes5": user.pattributes5,
    }).then((_) {
      print('Transaction  committed.');
    });
  }

  void dispose() {
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }
}
