import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ricinvestors/Widgets/circular_clipper.dart';
import 'package:ricinvestors/Widgets/content_scroll.dart';
import 'package:ricinvestors/models/property.dart';


class PropertyScreen extends StatefulWidget {
  final Property property;

  PropertyScreen({this.property});

  @override
  _PropertyScreenState createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                child: Hero(
                  tag: widget.property.avatarUrl,
                  child: ClipShadowPath(
                    clipper: CircularClipper(),
                    shadow: Shadow(blurRadius: 20.0),
                    child: Image.network(widget.property.avatarUrl,fit: BoxFit.cover,width: double.infinity,height: 400.0,),

                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(left: 30.0),
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30.0,
                    color: Colors.black,
                  ),
                  Image(
                    image: AssetImage('assets/logo.png'),
                    height: 60.0,
                    width: 60.0,
                  ),
                 Opacity(opacity: 0.0,
                   child: IconButton(
                     padding: EdgeInsets.only(left: 30.0),
                     onPressed: () => print('Add to Favorites'),
                     icon: Icon(Icons.favorite_border),
                     iconSize: 30.0,
                     color: Colors.black,
                   ),
                 ),
                ],
              ),
              Positioned.fill(
                bottom: 10.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child:   RawMaterialButton(
                    padding: EdgeInsets.all(10.0),
                    elevation: 12.0,
                    onPressed: () => print('Play Video'),
                    shape: CircleBorder(),
                    fillColor: Colors.white,

                    child: Icon(
                      Icons.play_arrow,
                      size: 60.0,
                      color: Colors.red,
                    ),
                  ),
                // InkWell(
                //   child: Container(
                //     width: ScreenUtil.getInstance().setWidth(330),
                //     height: ScreenUtil.getInstance().setHeight(100),
                //     decoration: BoxDecoration(
                //         gradient:
                //         LinearGradient(colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                //         borderRadius: BorderRadius.circular(6.0),
                //         boxShadow: [
                //           BoxShadow(
                //               color: Color(0xFF6078ea).withOpacity(.3),
                //               offset: Offset(0.0, 8.0),
                //               blurRadius: 8.0)
                //         ]),
                //     child: Material(
                //       color: Colors.transparent,
                //       child: InkWell(
                //         onTap: () {

                //           //_changeLoadingVisible();
                //         },
                //         child: Center(

                //           child: Text("SIGNIN",
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontFamily: "Poppins-Bold",
                //                   fontSize: 18,
                //                   letterSpacing: 1.0)),

                //         ),

                //       ),
                //     ),
                //   ),
                // ),


                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 20.0,
                child: IconButton(
                  onPressed: () => print('Add to My List'),
                  icon: Icon(Icons.add),
                  iconSize: 40.0,
                  color: Colors.black,
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 25.0,
                child: IconButton(
                  onPressed: () => print('Share'),
                  icon: Icon(Icons.share),
                  iconSize: 35.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.property.pname.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.0),
                Text(
                  widget.property.location,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  '⭐ ⭐ ⭐ ⭐',
                  style: TextStyle(fontSize: 25.0),
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'IRR',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          widget.property.IRR.toString(),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Tenure',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          widget.property.pattributes1.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Value',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          '\$ ${widget.property.mvalue}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.0),
                Container(
                  height: 120.0,
                  child: SingleChildScrollView(
                    child: Text(
                      widget.property.description,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ContentScroll(
            images: [
              widget.property.pictures1,
              widget.property.pictures2,
              widget.property.pictures3,
              widget.property.pictures4,
              widget.property.pictures5,
            ],
            title: 'Pictures',
            imageHeight: 200.0,
            imageWidth: 250.0,
          ),
        ],
      ),
    );
  }
}
