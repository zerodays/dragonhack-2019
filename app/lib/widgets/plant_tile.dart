import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'plant_details.dart';

class PlantTile extends StatelessWidget {
  final Map<String, dynamic> plant;

  PlantTile(this.plant);

  @override
  Widget build(BuildContext context) {
    Widget invasiveAndProtected;

    if (MediaQuery.of(context).size.width >= 390) {
      invasiveAndProtected = Center(
        child: Row(
          children: <Widget>[
            Icon(
              plant['invasive'] ? Icons.error : Icons.error_outline,
              color: plant['invasive'] ? Colors.red : Colors.grey,
              size: 18.0,
            ),
            Container(width: 4.0,),
            Text(plant['invasive'] ? 'Invasive' : 'Not invasive', style: TextStyle(fontSize: 13.0),),
            Expanded(child: Container(),),
            Icon(
              plant['protected'] ? Icons.check : Icons.clear,
              color: plant['invasive'] ? Colors.green : Colors.grey,
              size: 18.0,
            ),
            Container(width: 4.0,),
            Text(plant['protected'] ? 'Protected' : 'Not protected', style: TextStyle(fontSize: 13.0),),
            Container(width: 4.0,)
            //protected, invasive
          ],
        ),
      );
    } else {
      invasiveAndProtected = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  plant['invasive'] ? Icons.error : Icons.error_outline,
                  color: plant['invasive'] ? Colors.red : Colors.grey,
                  size: 18.0,
                ),
                Container(width: 4.0,),
                Text(plant['invasive'] ? 'Invasive' : 'Not invasive', style: TextStyle(fontSize: 13.0),), //protected, invasive
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  plant['protected'] ? Icons.check : Icons.clear,
                  color: plant['invasive'] ? Colors.green : Colors.grey,
                  size: 18.0,
                ),
                Container(width: 4.0,),
                Text(plant['protected'] ? 'Protected' : 'Not protected', style: TextStyle(fontSize: 13.0),),
              ],
            )
          ],
      );
    }

    return Material(
        child: InkWell(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => PlantDetails(plant))),
            child: AspectRatio(
                aspectRatio: 2 / 1,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 6.0),
                      child: Card(
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 6.0 + 8.0, top: 16.0, bottom: 16.0, right: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        plant['name'],
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w600),
                                        softWrap: true,
                                      ),
                                    ),
                                    Container(height: 12.0,),
                                    Text(plant['description'], maxLines: 2, softWrap: true, overflow: TextOverflow.ellipsis,),
                                    Flexible(child: Container()),
                                    invasiveAndProtected
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Container(
                            height: MediaQuery.of(context).size.width / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: CachedNetworkImageProvider(plant['image_url'])))),
                      ),
                    ),
                  ],
                ))));
  }
}
