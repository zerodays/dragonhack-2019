import 'package:dragonhack_2019/api.dart';
import 'package:dragonhack_2019/teams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'plant_details.dart';

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    getMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(46.232410, 15.459820),
      ),
      layers: [
        TileLayerOptions(
          wms: true,
          urlTemplate:
              "https://services.sentinel-hub.com/ogc/wms/70b59b94-ad29-46a9-a0d3-716340829939?SERVICE={SERVICE}&VERSION={VERSION}&REQUEST={REQUEST}&layers={layers}&styles={styles}&srs={srs}&width={width}&height={height}&format={format}&bbox={bbox}&time={time}",
          additionalOptions: {
            'SERVICE': 'WMS',
            'VERSION': '1.1.1',
            'REQUEST': 'GetMap',
            'layers': 'TRAVNIK',
            'styles': '',
            'srs': 'EPSG:4326',
            'time': '2016-11-01/2017-05-18',
            'width': '256',
            'height': '256',
            'format': 'image/png'
          },
        ),
        MarkerLayerOptions(
          markers: markers,
        ),
      ],
    );
  }

  Future<void> getMarkers() async {
    List<Map<String, dynamic>> plants = await getHistoryScans();

    List<Marker> newMarkers = plants.map((Map<String, dynamic> plant) {
      Color color = teamToColor(intToTeam(plant['team']));

      return Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(plant['latitude'], 15.459820),
          builder: (BuildContext context) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlantDetails(plant)));
              },
              child: Image.asset(
                'assets/marker.png',
                color: color,
              )));
    }).toList();

    setState(() {
      markers = newMarkers;
    });
  }
}
