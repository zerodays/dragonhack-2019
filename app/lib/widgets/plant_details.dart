import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'chart.dart';

class PlantDetails extends StatelessWidget {
  final Map<String, dynamic> plant;

  PlantDetails(this.plant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.only(top: 16.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width / 1.5 / 2.0,
                left: 16.0,
                right: 16.0,
                bottom: 16.0),
            child: Card(
              elevation:
                  Theme.of(context).brightness == Brightness.dark ? 7 : 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    8.0,
                    24.0 + MediaQuery.of(context).size.width / 1.5 / 2.0,
                    8.0,
                    8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        plant['name'],
                        style: TextStyle(
                            fontSize: 26.0, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.access_time,
                                size: 18.0, color: Colors.grey),
                            Container(width: 8.0),
                            Text(plant['date_scanned'],
                                style: TextStyle(fontSize: 13.0)),
                          ],
                        ),
                      ),
                      Divider(
                        height: 32.0,
                      ),
                      Text(
                        plant['description'],
                        style: TextStyle(color: Colors.grey),
                      ),
                      Divider(
                        height: 32.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.error_outline,
                              color:
                                  plant['invasive'] ? Colors.red : Colors.grey,
                              size: 18.0,
                            ),
                            Container(
                              width: 8.0,
                            ),
                            Text(
                              plant['invasive'] ? 'Invasive' : 'Not invasive',
                              style: TextStyle(fontSize: 13.0),
                            ),
                            //protected, invasive
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            plant['protected'] ? Icons.check : Icons.clear,
                            color:
                                plant['invasive'] ? Colors.green : Colors.grey,
                            size: 18.0,
                          ),
                          Container(
                            width: 8.0,
                          ),
                          Text(
                            plant['protected'] ? 'Protected' : 'Not protected',
                            style: TextStyle(fontSize: 13.0),
                          ),
                        ],
                      ),
                      Divider(
                        height: 32.0,
                      ),
                      Container(
                        height: Theme.of(context).brightness == Brightness.dark
                            ? 0.0
                            : 16.0,
                      ),
                      Theme.of(context).brightness == Brightness.dark
                          ? Container()
                          : Center(
                              child: Text(
                                'Average elevation over time',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0),
                              ),
                            ),
                      Theme.of(context).brightness == Brightness.dark
                          ? Container()
                          : Center(
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: 16.0,
                                    right: 16.0,
                                    left: 16.0,
                                    top: 8.0),
                                width:
                                    MediaQuery.of(context).size.width / 4 * 3,
                                height: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? 0
                                    : 200.0,
                                child: ElevationChart.withSampleData(
                                    Theme.of(context).brightness ==
                                        Brightness.dark),
                              ),
                            ),
                      Theme.of(context).brightness == Brightness.dark
                          ? Container()
                          : Divider(
                              height: 32.0,
                            ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.map,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite,
                                  color: Theme.of(context).accentColor),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.share,
                                  color: Theme.of(context).accentColor),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Hero(
              tag: plant['id'].toString(),
              child: Container(
                  height: MediaQuery.of(context).size.width / 1.5,
                  width: MediaQuery.of(context).size.width / 1.5,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image:
                              CachedNetworkImageProvider(plant['image_url'])))),
            ),
          )
        ],
      ),
    ));
  }
}
