import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ricinvestors/models/property.dart';
import 'package:ricinvestors/services/auth.dart';

class PropertyApi {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = new GoogleSignIn();

  FirebaseUser firebaseUser;

  PropertyApi(FirebaseUser user) {
    this.firebaseUser = user;
  }

  static Future<PropertyApi> returnUser() async {

    FirebaseUser user = await _auth.currentUser();
    return new PropertyApi(user);
  }

//  Property _fromDocumentSnapshot(DocumentSnapshot snapshot) {
//
//
//    return new Property(
//        id: snapshot.documentID,
//        propId: snapshot.data['id'],
//        pname: snapshot.data['pname'],
//        description: snapshot.data['description'],
//        avatarUrl: snapshot.data['avatarUrl'],
//        location: snapshot.data['location'],
//        yeild: snapshot.data['yeild'],
//        mvalue: snapshot.data['mvalue'],
//        IRR: snapshot.data['IRR'],
//        isCompleted: snapshot.data['isCompleted'],
//        pictures: new List<String>.from(snapshot.data['pictures']),
//        pattributes: new List<String>.from(snapshot.data['pattributes']));
//  }

  Future likeCat(Property cat) async {
    await Firestore.instance
        .collection('likes')
        .document('${cat.id}:${this.firebaseUser.uid}')
        .setData({});
  }

  Future unlikeCat(Property cat) async {
    await Firestore.instance
        .collection('likes')
        .document('${cat.id}:${this.firebaseUser.uid}')
        .delete();
  }

  Future<bool> hasLikedCat(Property cat) async {
    final like = await Firestore.instance
        .collection('likes')
        .document('${cat.id}:${this.firebaseUser.uid}')
        .get();

    return like.exists;
  }

//  Future<List<Property>> getAllProperties() async {
//    return (await Firestore.instance.collection('Properties').getDocuments())
//        .documents
//        .map((snapshot) => _fromDocumentSnapshot(snapshot))
//        .toList();
//  }

// StreamSubscription watch(Property cat, void onChange(Property cat)) {
//   return Firestore.instance
//       .collection('Properties')
//       .document(cat.id)
//       .snapshots()
//       .listen((snapshot) => onChange(_fromDocumentSnapshot(snapshot)));
// }
}
