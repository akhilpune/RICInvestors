import 'dart:async';

import 'package:ricinvestors/models/property.dart';
import 'package:ricinvestors/services/api.dart';
import 'package:ricinvestors/ui/property_details/details_page.dart';
import 'package:ricinvestors/utils/routes.dart';
import 'package:flutter/material.dart';



import 'property_details/details_page.dart';

class PropertyList extends StatefulWidget {
  @override
  _PropertyListState createState() => new _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  List<property> _properties = [];

  @override
  void initState() {
    super.initState();
    _loadCats();
  }

  _loadCats() async {
    String fileData = await DefaultAssetBundle.of(context).loadString("assets/properties.json");
    setState(() {
      _properties = PropertyApi.allCatsFromJson(fileData);
    });
  }

  Widget _buildCatItem(BuildContext context, int index) {
    property cat = _properties[index];

    return new Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              onTap: () => _navigateToCatDetails(cat, index),
              leading: new Hero(
                tag: index,
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(cat.avatarUrl),
                ),
              ),
              title: new Text(
                cat.name,
                style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              subtitle: new Text(cat.description),
              isThreeLine: true, // Less Cramped Tile
              dense: false, // Less Cramped Tile
            ),
          ],
        ),
      ),
    );
  }

  _navigateToCatDetails(property cat, Object avatarTag) {
    Navigator.of(context).push(
      new FadePageRoute(
        builder: (c) {
          return new CatDetailsPage(cat, avatarTag: avatarTag);
        },
        settings: new RouteSettings(),
      ),
    );
  }

  Widget _getAppTitleWidget() {
    return new Text(
      'Cats',
      style: new TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 32.0,
      ),
    );
  }

  Widget _buildBody() {
    return new Container(
      margin: const EdgeInsets.fromLTRB(
          8.0,  // A left margin of 8.0
          56.0, // A top margin of 56.0
          8.0,  // A right margin of 8.0
          0.0   // A bottom margin of 0.0
      ),
      child: new Column(
        // A column widget can have several
        // widgets that are placed in a top down fashion
        children: <Widget>[
          _getAppTitleWidget(),
          _getListViewWidget()
        ],
      ),
    );
  }

  Future<Null> refresh() {
    _loadCats();
    return new Future<Null>.value();
  }

  Widget _getListViewWidget() {
    return new Flexible(
        child: new RefreshIndicator(
            onRefresh: refresh,
            child: new ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: _properties.length,
                itemBuilder: _buildCatItem
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blue,
      body: _buildBody(),
    );
  }
}