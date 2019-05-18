import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PlantDetails extends StatelessWidget {
  final Map<String, dynamic> plant;

  PlantDetails(this.plant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.width / 1.5 / 2.0, left: 16.0, right: 16.0, bottom: 16.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            child: Padding(
              padding: EdgeInsets.fromLTRB(8.0, 24.0 + MediaQuery.of(context).size.width / 1.5 / 2.0, 8.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    plant['name'],
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    height: 32.0,
                  ),
                  Text(plant['description']),
                  Divider(
                    height: 32.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          plant['invasive'] ? Icons.error : Icons.error_outline,
                          color: plant['invasive'] ? Colors.red : Colors.grey,
                          size: 18.0,
                        ),
                        Container(
                          width: 4.0,
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
                        color: plant['invasive'] ? Colors.green : Colors.grey,
                        size: 18.0,
                      ),
                      Container(
                        width: 4.0,
                      ),
                      Text(
                        plant['protected'] ? 'Protected' : 'Not protected',
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ],
                  ),
                  
                  Expanded(child: Container(),),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.map, color: Theme.of(context).accentColor,),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite, color: Theme.of(context).accentColor),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.share, color: Theme.of(context).accentColor),
                        )
                      ],
                    ),
                  )
                ],
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
                        image: CachedNetworkImageProvider(plant['image_url'])))),
          ),
        )
      ],
    ));
  }
}
