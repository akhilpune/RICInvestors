import 'package:ricinvestors/models/property.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final dynamic cattributeLookup = {
  "pattributes1": {"name": "Time Period", "icon": FontAwesomeIcons.clock},
  "pattributes2": {"name": "Multiple", "icon": FontAwesomeIcons.times},
  "pattributes3": {"name": "Investors", "icon": FontAwesomeIcons.users},

};

class CattributesShowcase extends StatelessWidget {
  final Property cat;

  CattributesShowcase(this.cat);

  _createCircleBadge(
      IconData iconData, Color bgColor, Color iconColor, String text) {
    return new Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: new Stack(
          children: <Widget>[
            new CircleAvatar(
              backgroundColor: bgColor,
              child: new Icon(
                iconData,
                color: iconColor,
                size: 36.0,
              ),
              radius: 36.0,
            ),
            new Positioned(
              child: new Text(
                text,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0,
                  color: iconColor,
                ),
              ),
            ),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    var items = <Widget>[
    _createCircleBadge(
        cattributeLookup["pattributes1"]['icon'],
        Colors.white12,
        Colors.white,
        cat.pattributes1.toString(),
      ),
    _createCircleBadge(
    cattributeLookup["pattributes2"]['icon'],
    Colors.white12,
    Colors.white,
    cat.pattributes2.toString()
    ),
      _createCircleBadge(
        cattributeLookup["pattributes3"]['icon'],
        Colors.white12,
        Colors.white,
        cat.pattributes3.toString(),
      ),
      Text(cat.pattributes4.toString()),
      Text(cat.pattributes5.toString()),

    ];

//    for (var i = 0; i < cat.pattributes.length; i++) {
//      var badge = _createCircleBadge(
//        cattributeLookup[cat.pattributes[i]]['icon'],
//        Colors.white12,
//        Colors.white,
//        cattributeLookup[cat.pattributes[i]]['name'],
//      );
//
//      items.add(badge);
//    }

    var delegate = new SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
    );

    return new GridView(
        padding: const EdgeInsets.only(top: 16.0),
        gridDelegate: delegate,
        children: items
    );
  }
}