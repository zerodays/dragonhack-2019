import 'package:dragonhack_2019/api.dart';
import 'package:dragonhack_2019/teams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'plant_details.dart';

class MapWidget extends StatefulWidget {
  final int overlayIndex;

  MapWidget(this.overlayIndex);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  List<Marker> markers = [];
  List<CircleMarker> circles = [];

  @override
  void initState() {
    super.initState();
    getMarkers();
  }

  @override
  Widget build(BuildContext context) {
    TileLayerOptions tileLayerOptions;
    LayerOptions markerOptions;

    if (widget.overlayIndex == 0) {
      markerOptions = MarkerLayerOptions(
        markers: markers,
      );
    } else if (widget.overlayIndex == 1) {
      markerOptions = CircleLayerOptions(circles: circles);
    }

    if (widget.overlayIndex >= 2) {
      List names = [
        '',
        '',
        'TRAVNIK-OLD',
        'VISINA-PLANIKA',
        'VISINA-0-100',
        'VISINA-200-300',
        'VISINA-300-400',
        'VISINA-400-500',
        'VISINA-600-700',
        'VISINA-700-800',
        'VISINA-800-900',
        'VISINA-900-1000',
        'VISINA-1000-1500',
        'VISINA-1500-2000',
        'VISINA-2000-3000',
      ];

      tileLayerOptions = TileLayerOptions(
        opacity: 0.3,
        wms: true,
        urlTemplate:
            "https://services.sentinel-hub.com/ogc/wms/70b59b94-ad29-46a9-a0d3-716340829939?SERVICE={SERVICE}&VERSION={VERSION}&REQUEST={REQUEST}&layers={layers}&styles={styles}&srs={srs}&width={width}&height={height}&format={format}&bbox={bbox}&time={time}",
        additionalOptions: {
          'SERVICE': 'WMS',
          'VERSION': '1.1.1',
          'REQUEST': 'GetMap',
          'layers': names[widget.overlayIndex],
          'styles': '',
          'srs': 'EPSG:4326',
          'time': '2018-11-01/2019-05-18',
          'width': '100',
          'height': '100',
          'format': 'image/png'
        },
      );
    }

    return FlutterMap(
      options: MapOptions(
        center: LatLng(46.019269613810565, 14.392059200316794),
      ),
      layers: [
        TileLayerOptions(
            overlayTileOptions: tileLayerOptions,
            wms: true,
            urlTemplate:
                'http://ows.terrestris.de/${widget.overlayIndex >= 2 ? 'osm-gray' : 'osm'}/service?SERVICE={SERVICE}&VERSION={VERSION}&REQUEST={REQUEST}&layers={layers}&styles={styles}&srs={srs}&width={width}&height={height}&format={format}&bbox={bbox}',
            additionalOptions: {
              'SERVICE': 'WMS',
              'VERSION': '1.1.1',
              'REQUEST': 'GetMap',
              'layers': 'OSM-WMS',
              'styles': '',
              'srs': 'EPSG:4326',
              'width': '256',
              'height': '256',
              'format': 'image/png'
            }),
        markerOptions ?? MarkerLayerOptions()
      ],
    );
  }

  Future<void> getMarkers() async {
    List<Map<String, dynamic>> plants = await getHistoryScans();

    List<Marker> newMarkers = plants.map((Map<String, dynamic> plant) {
      Color color = teamToColor(intToTeam(plant['team']));

      return Marker(
          point: LatLng(plant['latitude'], plant['longitude']),
          builder: (BuildContext context) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => PlantDetails(plant)));
              },
              child: Icon(
                Icons.local_florist,
                color: color,
                size: 30.0,
              )));
    }).toList();

    setState(() {
      markers = newMarkers;
    });

    List<CircleMarker> newCircles = plants.map((Map<String, dynamic> plant) {
      Color color = teamToColor(intToTeam(plant['team']));

      return CircleMarker(
          point: LatLng(plant['latitude'], plant['longitude']),
          useRadiusInMeter: true,
          color: color.withOpacity(0.1),
          borderColor: Colors.red,
          borderStrokeWidth: 10.0,
          radius: 2000.0);
    }).toList();

    setState(() {
      circles = newCircles;
    });
  }
}
