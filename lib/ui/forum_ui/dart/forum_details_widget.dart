import 'package:flutter/material.dart';
import 'package:ricinvestors/models/property.dart';
import 'package:ricinvestors/styleguide/text_styles.dart';
import 'package:ricinvestors/ui/forum_ui/dart/label_value_widget.dart';




class ForumDetailsWidget extends StatelessWidget {

  final Property forum;

  ForumDetailsWidget({this.forum});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      //clipper: MyCustomClipper(),
      child: Container(









        height: 65.0,
        padding: const EdgeInsets.only(
            left: 20.0, right: 16.0, top: 15.0, bottom: 2.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
        //  Align(
        //    alignment: Alignment.topRight,
        //    child: Column(
        //      children: <Widget>[
        //        Container(
        //          decoration: BoxDecoration(
        //            shape: BoxShape.circle,
        //            border: Border.all(
        //                color: Colors.grey.withOpacity(0.4), width: 2.0),
        //          ),
        //          height: 40.0,
        //          width: 40.0,
        //          child: Center(
        //              child: Text(
        //                forum.IRR,
        //                style: rankStyle,
        //              )),
        //        ),
        //        Text("IRR", style: labelTextStyle),
        //      ],
        //    ),
        //  ),
        //  SizedBox(
        //    height: 40.0,
        //  ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                LabelValueWidget(
                  value: forum.pattributes1.toString(),
                  label: "tenure",

                  labelStyle: labelTextStyle,
                  valueStyle: valueTextStyle,
                ),
                LabelValueWidget(
                  value: forum.pattributes2,
                  label: "multiple",
                  labelStyle: labelTextStyle,
                  valueStyle: valueTextStyle,
                ),
                LabelValueWidget(
                  value: forum.IRR,
                  label: "IRR",
                  labelStyle: labelTextStyle,
                  valueStyle: valueTextStyle,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  final double distanceFromWall = 12;
  final double controlPointDistanceFromWall = 2;

  @override
  Path getClip(Size size) {
    final double height = size.height;
    final double halfHeight = size.height * 0.5;
    final double width = size.width;

    Path clippedPath = Path();
    clippedPath.moveTo(0, halfHeight);
    clippedPath.lineTo(0, height - distanceFromWall);
    clippedPath.quadraticBezierTo(0 + controlPointDistanceFromWall,
        height - controlPointDistanceFromWall, 0 + distanceFromWall, height);
    clippedPath.lineTo(width, height);
    clippedPath.lineTo(width, 0 + 30.0);
    clippedPath.quadraticBezierTo(width - 5, 0 + 5.0, width - 35, 0 + 15.0);
    clippedPath.close();
    return clippedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}
