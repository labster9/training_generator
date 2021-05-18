import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/part.dart';
import '../providers/exercise_provider.dart';

class PartItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final part = Provider.of<Part>(context);
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/part-exercises', arguments: part.title);
        },
        child: Image.network(
          part.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black38,
        title: Text(part.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
