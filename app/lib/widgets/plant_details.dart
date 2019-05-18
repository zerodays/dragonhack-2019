import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PlantDetails extends StatelessWidget {
  final Map<String, dynamic> plant;

  PlantDetails(this.plant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        AspectRatio(
            aspectRatio: 3 / 4,
            child:
                Image(image: CachedNetworkImageProvider(plant['image_url']))),
        Column(
          children: <Widget>[
            Text(
              plant['name'],
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            Text(plant['description'])
          ],
        )
      ],
    ));
  }
}
