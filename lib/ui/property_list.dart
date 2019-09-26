import 'dart:async';

import 'package:provider/provider.dart';


import 'package:ricinvestors/services/auth.dart';


import 'package:flutter/material.dart';
import 'package:ricinvestors/customIcons.dart';
import 'package:ricinvestors/data.dart';
import 'dart:math';



import 'property_details/details_page.dart';






//----------------------------------------------------------------------------------------------------------------------------

//class _PropertyListState extends State<PropertyList> {


//  List<property> _properties = [];
//
//  @override
//  void initState() {
//    super.initState();
//    _loadCats();
//  }
//
//  _loadCats() async {
//    String fileData = await DefaultAssetBundle.of(context).loadString("assets/properties.json");
//    setState(() {
//      _properties = PropertyApi.allCatsFromJson(fileData);
//    });
//  }

// Widget _buildCatItem(BuildContext context, int index) {
//   property cat = _properties[index];
//
//   return new Container(
//     margin: const EdgeInsets.only(top: 5.0),
//     child: new Card(
//       child: new Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           new ListTile(
//             onTap: () => _navigateToCatDetails(cat, index),
//             leading: new Hero(
//               tag: index,
//               child: new CircleAvatar(
//                 backgroundImage: new NetworkImage(cat.avatarUrl),
//               ),
//             ),
//             title: new Text(
//               cat.pname,
//               style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
//             ),
//             subtitle: new Text(cat.description),
//             isThreeLine: true, // Less Cramped Tile
//             dense: false, // Less Cramped Tile
//           ),
//         ],
//       ),
//     ),
//   );
// }

// _navigateToCatDetails(property cat, Object avatarTag) {
//   Navigator.of(context).push(
//     new FadePageRoute(
//       builder: (c) {
//         return new CatDetailsPage(cat, avatarTag: avatarTag);
//       },
//       settings: new RouteSettings(),
//     ),
//   );
// }

//  Widget _getAppTitleWidget() {
//    return new Text(
//      'Cats',
//      style: new TextStyle(
//        color: Colors.white,
//        fontWeight: FontWeight.bold,
//        fontSize: 32.0,
//      ),
//    );
//  }

// Widget _buildBody() {
//   return new Container(
//     margin: const EdgeInsets.fromLTRB(
//         8.0,  // A left margin of 8.0
//         56.0, // A top margin of 56.0
//         8.0,  // A right margin of 8.0
//         0.0   // A bottom margin of 0.0
//     ),
//     child: new Column(
//       // A column widget can have several
//       // widgets that are placed in a top down fashion
//       children: <Widget>[
//         _getAppTitleWidget(),
//         _getListViewWidget()
//       ],
//     ),
//   );
// }

//  Future<Null> refresh() {
//    _loadCats();
//    return new Future<Null>.value();
//  }

//  Widget _getListViewWidget() {
//    return new Flexible(
//        child: new RefreshIndicator(
//            onRefresh: refresh,
//            child: new ListView.builder(
//                physics: const AlwaysScrollableScrollPhysics(),
//                itemCount: _properties.length,
//                itemBuilder: _buildCatItem
//            )
//        )
//    );
//  }

  // @override
// Widget build(BuildContext context) {
//   return new Scaffold(
//     backgroundColor: Colors.blue,
//     body: _buildBody(),
//   );
// }
// }

//--------------------------------------------------------------------------------------------------------------------

class PropertyList extends StatefulWidget {


  @override
  _PropertyListState createState() => new _PropertyListState();
}


var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class  _PropertyListState extends State<PropertyList> {


  var currentPage = images.length - 1.0;
  //List<property> _properties = [];


  Future<void> _signOut() async{
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }



  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFF1b1e44),
                Color(0xFF2d3447),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 30.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        CustomIcons.menu,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: _signOut,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("FUND-1",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 46.0,
                          fontFamily: "Calibre-Semibold",
                          letterSpacing: 1.0,
                        )),


                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 20.0,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFff6e6e),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 6.0),
                          child: Text("Hyderabad",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text("4+ Properties",
                        style: TextStyle(color: Colors.blueAccent))
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  CardScrollWidget(currentPage),
                  Positioned.fill(
                    child: PageView.builder(
                      itemCount: images.length,
                      controller: controller,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Container();
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Properties",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 46.0,
                          fontFamily: "Calibre-Semibold",
                          letterSpacing: 1.0,
                        )),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 20.0,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 6.0),
                          child: Text("High Return",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(" ",
                        style: TextStyle(color: Colors.blueAccent))
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 18.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset("assets/image_02.jpg",
                          width: 296.0, height: 222.0),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;



  CardScrollWidget(this.currentPage);



  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < images.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(images[i], fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(title[i],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: "SF-Pro-Text-Regular")),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, bottom: 12.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Text("Property "+ (i+1).toString(),
                                    style: TextStyle(color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}