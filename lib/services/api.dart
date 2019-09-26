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
      pname: map['pname'],
      description: map['description'],
      avatarUrl: map['image_url'],
      location: map['location'],
      preturn: map['preturn'],
      mvalue: map['mvlaue'],
      ovalue: map['ovalue'],
      isCompleted: map['completed'],
      pictures: new List<String>.from(map['pictures']),
      pattributes: new List<String>.from(map['pattributes']),
    );
  }
}