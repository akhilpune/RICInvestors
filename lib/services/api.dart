import 'dart:convert';
import 'package:ricinvestors/models/property.dart';

class PropertyApi {
  static List<property> allCatsFromJson(String jsonData) {
    List<property> cats = [];
    json.decode(jsonData)['cats'].forEach((cat) => cats.add(_forMap(cat)));
    return cats;
  }

  static property _forMap(Map<String, dynamic> map) {
    return new property(
      externalId: map['id'],
      name: map['name'],
      description: map['description'],
      avatarUrl: map['image_url'],
      location: map['location'],
      likeCounter: map['like_counter'],
      isAdopted: map['adopted'],
      pictures: new List<String>.from(map['pictures']),
      cattributes: new List<String>.from(map['cattributes']),
    );
  }
}