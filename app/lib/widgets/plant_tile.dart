import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'plant_details.dart';

class PlantTile extends StatelessWidget {
  final Map<String, dynamic> plant;

  PlantTile(this.plant);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => PlantDetails(plant))),
            child: AspectRatio(
                aspectRatio: 4 / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Image(
                          image:
                              CachedNetworkImageProvider(plant['image_url'])),
                      Container(
                        height: 64.0,
                        color: Colors.green.withOpacity(0.5),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(child: Text(plant['name']))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
