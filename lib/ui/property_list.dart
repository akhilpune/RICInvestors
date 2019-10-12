import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';


import 'package:ricinvestors/Widgets/platform_alert_dialog.dart';
import 'package:ricinvestors/models/property.dart';
import 'package:ricinvestors/services/auth.dart';


import 'package:ricinvestors/customIcons.dart';
import 'package:ricinvestors/data.dart';
import 'package:ricinvestors/services/firebase_database.dart';
import 'package:ricinvestors/styleguide/text_styles.dart';
import 'package:ricinvestors/ui/Property_details.dart';
import 'package:ricinvestors/ui/forum_ui/dart/forum_card.dart';
import 'package:ricinvestors/ui/forum_ui/dart/forum_details_widget.dart';
import 'package:ricinvestors/ui/forum_ui/dart/forum_name_widget.dart';

import 'package:ricinvestors/ui/sign_in/sign_in_page.dart';
import 'package:ricinvestors/utils/routes.dart';

import 'package:ricinvestors/utils/state_widget.dart';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';

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


  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  // finally {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => LandingPage()));
  // }
  }

  @override
  _PropertyListState createState() => new _PropertyListState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

//=============================================================================================

class _PropertyListState extends State<PropertyList> {



  final List<String> labels = [
    'Funds',
    'OnGoing',
    'Completed',
  ];

  PageController _pageController;
  static int counter= 4; //databaseUtil.getCounter();
  var currentPage = counter - 1.0;

  List<Property> _properties;
  var padding = 20.0;
  var verticalInset = 20.0;
  bool _loadingVisible = false;
  StreamSubscription<Event> _onNoteAddedSubscription;
  static FirebaseDatabaseUtil databaseUtil = new FirebaseDatabaseUtil();
  DatabaseReference ref = databaseUtil.getProperty();


  @override
  void initState() {
    super.initState();
    databaseUtil = new FirebaseDatabaseUtil();
    databaseUtil.initState();
    _properties = new List();
    DatabaseReference ref = databaseUtil.getProperty();
    _onNoteAddedSubscription = ref.onChildAdded.listen(_onNoteAdded);
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }



  @override
  void dispose() {
    //databaseUtil.dispose();
    super.dispose();

   //_onNoteAddedSubscription.cancel();
  }

 void _onNoteAdded(Event event) {
   setState(() {
     _properties.add(new Property.fromSnapshot(event.snapshot));
   });
 }

 Size screen(BuildContext context){
    return MediaQuery.of(context).size;
  }

  _movieSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 270.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PropertyScreen(property: _properties[index]),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Hero(
                    tag: _properties[index].avatarUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(_properties[index].avatarUrl,height: 220.0,fit: BoxFit.cover,)

                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30.0,
              bottom: 40.0,
              child: Container(
                width: 250.0,
                child: Text(
                  _properties[index].pname.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }






  // _reloadCats() async {
  //   if (_api != null) {
  //     final prop = await _api.getAllProperties();
  //     setState(() {
  //       _properties = prop;
  //     });
  //   }
  // }


  @override
  Widget build(BuildContext context) {

    PageController controller = PageController(initialPage: counter - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

//   appState = StateWidget
//       .of(context)
//       .state;
//   if (!appState.isLoading &&
//       (appState.firebaseUserAuth == null ||
//           appState.user == null ||
//           appState.settings == null)) {
//     return SignInScreen();
//   } else {
//     if (appState.isLoading) {
//       _loadingVisible = true;
//     } else {
//       _loadingVisible = false;
//     }

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
                      onPressed: () => widget._confirmSignOut(context),
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
        /// start++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


              FutureBuilder(
                future: databaseUtil.getProperty().once(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {

                  if (snapshot.hasData) {

                    return new  Stack(
                          children: <Widget>[

                            CardScrollWidget(currentPage,_properties,counter),

                            Positioned.fill(
                              child: PageView.builder(
                                itemCount: counter,
                                controller: controller,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  Property prop= _properties[index];

                                  return Container(
                                    child: GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => PropertyScreen(property: _properties[index]),
                                          ),
                                        ),


                                    ),


                                  );
                                },
                              ),
                            )
                          ],
                        );


                    } else {
                        return new CircularProgressIndicator();
                    }
                  },





              ),
    ///end++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
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

                    Text(" ", style: TextStyle(color: Colors.blueAccent))
                  ],
                ),
              ),

              ///********************************************************************************
              FutureBuilder(
                future: databaseUtil.getProperty().once(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {

                  if (snapshot.hasData) {

                    return new    Row(
                      children: <Widget>[
                        Container(
                          height: 280.0,
                          width: screen(context).width ,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: counter,
                            itemBuilder: (BuildContext context, int index) {
                              return _movieSelector(index);
                            },
                          ),
                        ),

                      ],
                    );


                  } else {
                    return new CircularProgressIndicator();
                  }
                },
              ),


              ///*****************************************************************
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Future Projects",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 44.0,
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

                    Text(" ", style: TextStyle(color: Colors.blueAccent))
                  ],
                ),
              ),
///FFFFFFFFUUUUUUUUUUTTTTTTTTTUUUUUUUURRRRRRRREEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
              FutureBuilder(
                future: databaseUtil.getProperty().once(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {

                  if (snapshot.hasData) {

                    return new    Column(
                      children: <Widget>[
                       // Container(
                       //   height:400.0,
                       //   width: screen(context).width ,
                       //   child: PageView.builder(
                       //     itemCount: counter,
                       //     itemBuilder: (BuildContext context, int index) {
                       //       return ForumCard( property:_properties[index] );
                       //     },
                       //   ),
                       // ),

                        Container(


                          height: screen(context).height*.5,
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            scrollDirection: Axis.horizontal,
                            itemCount: counter,
                            itemBuilder: (BuildContext context, int index) {
                              Property prop= _properties[index];

                              return Container(

                                margin: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 20.0,
                                ),
                                width: screen(context).width*.55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54,
                                      offset: Offset(0.0, 4.0),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PropertyScreen(property: _properties[index]),
                                    ),
                                  ),

                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Stack(
                                        fit: StackFit.expand,
                                        children: <Widget>[
                                    //Image.network(prop[i].avatarUrl, fit: BoxFit.cover),
                                        Image.network(prop.avatarUrl,fit: BoxFit.cover),
                                          Positioned(
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            child: ForumDetailsWidget(forum: prop),
                                          ),
                                          Positioned(
                                            left: 0,
                                            bottom: 55.0,
                                            child: ForumNameWidget(forum: prop),
                                          ),
                                     ],   //child: Image.network(prop.avatarUrl,fit: BoxFit.cover),
                                    ),

                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                      ],
                    );


                  } else {
                    return new CircularProgressIndicator();
                  }
                },
              ),







            ],
          ),
        ),
      ),


    );
  }



  _navigateToCatDetails(Property prop, Object avatarTag) {
      Navigator.of(context).push(
      new FadePageRoute(
        builder: (c) {
          return new CatDetailsPage(prop, avatarTag: avatarTag);
        },
        settings: new RouteSettings(),
      ),
    );
  }


}//PropertyList






class CardScrollWidget extends StatelessWidget {

  var padding = 20.0;
  var verticalInset = 20.0;

  var currentPage;
  List<Property> _properties;
  int counter;


  CardScrollWidget(this.currentPage,this._properties,this.counter);



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
        var widthOfPrimaryCard =
            heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < counter; i++) {
           Property prop= _properties[i];

          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset *
                          -delta *
                          (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
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
                        //Image.network(prop[i].avatarUrl, fit: BoxFit.cover),
                        Image.network(prop.avatarUrl,fit: BoxFit.fill),


                         Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(


                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 8.0),


                                child: Text(prop.pname,
                                    style: forumNameTextStyle),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, bottom: 12.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 22.0,
                                      vertical: 6.0),
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius:
                                      BorderRadius.circular(
                                          20.0)),
                                  child: Text(
                                      "Return: " +
                                          prop.IRR+"%",
                                      style: TextStyle(
                                          color: Colors.white)),
                                ),
                              ),

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








