import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricinvestors/models/property.dart';
import 'package:ricinvestors/styleguide/colors.dart';
import 'package:ricinvestors/styleguide/text_styles.dart';


class ForumNameWidget extends StatelessWidget {

  final Property forum;

  ForumNameWidget({this.forum});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      borderRadius: BorderRadius.horizontal(left: Radius.zero ,right: Radius.circular(20.0), ),
      elevation: 10.0,
     // shape: CustomShapeBorder(),
      child: Container(
        width: 180.0,
        height: 30.0,

        child: FittedBox(

          fit: BoxFit.contain,
          child: Padding(
            padding: const EdgeInsets.only(top: 7.0, left: 10.0, right: 10.0, bottom: 5.0),
            child: Text(
              forum.pname,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomShapeBorder extends ShapeBorder {
  final double distanceFromWall = 12;
  final double controlPointDistanceFromWall = 2;

  @override
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return getClip(Size(130.0, 60.0));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
  }

  @override
  ShapeBorder scale(double t) {
    return null;
  }

  Path getClip(Size size) {
    Path clippedPath = Path();
    clippedPath.moveTo(0 + distanceFromWall, 0);
    clippedPath.quadraticBezierTo(0 + controlPointDistanceFromWall,
        0 + controlPointDistanceFromWall, 0, 0 + distanceFromWall);
    clippedPath.lineTo(0, size.height - distanceFromWall);
    clippedPath.quadraticBezierTo(
        0 + controlPointDistanceFromWall,
        size.height - controlPointDistanceFromWall,
        0 + distanceFromWall,
        size.height);
    clippedPath.lineTo(size.width - distanceFromWall, size.height);
    clippedPath.quadraticBezierTo(
        size.width - controlPointDistanceFromWall,
        size.height - controlPointDistanceFromWall,
        size.width,
        size.height - distanceFromWall);
    clippedPath.lineTo(size.width, size.height * 0.6);
    clippedPath.quadraticBezierTo(
        size.width - 1,
        size.height * 0.6 - distanceFromWall,
        size.width - distanceFromWall,
        size.height * 0.6 - distanceFromWall - 3);
    clippedPath.lineTo(0 + distanceFromWall + 6, 0);
    clippedPath.close();
    return clippedPath;
  }
}
