import 'package:flutter/material.dart';
import 'package:ricinvestors/models/property.dart';
import 'package:ricinvestors/ui/Property_details.dart';
import 'package:ricinvestors/ui/forum_ui/dart/forum_details_widget.dart';
import 'package:ricinvestors/ui/forum_ui/dart/forum_name_widget.dart';


class ForumCard extends StatelessWidget {
  final Property property;

  ForumCard({this.property});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: property.pname,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PropertyScreen(property: property)));
        },
        child: SizedBox(
          width: 280.0,
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 60.0),
            elevation: 20.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(
                    property.avatarUrl,
                    fit: BoxFit.fitWidth,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: ForumDetailsWidget(forum: property),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 80.0,
                    child: ForumNameWidget(forum: property),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
