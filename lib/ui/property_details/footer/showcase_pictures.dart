import 'package:ricinvestors/models/property.dart';
import 'package:flutter/material.dart';

class PicturesShowcase extends StatelessWidget {
    final Property cat;

  PicturesShowcase(this.cat);

// List<String> pictures=[
//   cat.pictures1.toString(),
//   cat.pictures2.toString(),
//   cat.pictures3.toString(),
//   cat.pictures4.toString(),
//   cat.pictures5.toString(),
// ];

  @override
  Widget build(BuildContext context) {
    var items = <Widget>[
      Image.network(cat.pictures1),
      Image.network(cat.pictures2),
      Image.network(cat.pictures3),
      Image.network(cat.pictures4),
      Image.network(cat.pictures5),

    ];

//   for (var i = 0; i < cat.pictures.length; i++) {
//     var image = new Image.network(
//       cat.pictures[i],
//       width: 200.0,
//       height: 200.0,
//     );
//     items.add(image);
//   }

    var delegate = new SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
    );

    return new GridView(
      padding: const EdgeInsets.only(top: 16.0),
      gridDelegate: delegate,
      children: items,
    );
  }
}