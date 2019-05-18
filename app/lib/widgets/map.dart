import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapWidget extends StatelessWidget {
  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    var markers = <Marker>[
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(51.5, -0.09),
        builder: (ctx) => Container(
          child: FlutterLogo(),
        ),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(53.3498, -6.2603),
        builder: (ctx) => Container(
          child: FlutterLogo(
            colors: Colors.green,
          ),
        ),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(48.8566, 2.3522),
        builder: (ctx) => Container(
          child: FlutterLogo(colors: Colors.purple),
        ),
      ),
    ];

    return FlutterMap(
      options: MapOptions(
        center: LatLng(46.019269613810565, 14.392059200316794),
      ),
      layers: [
        TileLayerOptions(
          wms: true,
          urlTemplate:
          "http://ows.terrestris.de/osm/service?SERVICE={SERVICE}&VERSION={VERSION}&REQUEST={REQUEST}&layers={layers}&styles={styles}&srs={srs}&width={width}&height={height}&format={format}&bbox={bbox}",
          additionalOptions: {
            'SERVICE': 'WMS',
            'VERSION': '1.1.1',
            'REQUEST': 'GetMap',
            'layers': 'TOPO-WMS',
            'styles': '',
            'srs': 'EPSG:4326',
            'width': '256',
            'height': '256',
            'format': 'image/png'
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 50.0,
              height: 50.0,
              point: LatLng(46.232410, 15.259820),
              builder: (ctx) => Container(
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.location_on,
                    size: 50.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        PolygonLayerOptions(
          polygons: _getPolygons(),
        )
      ],
    );
  }

  List<Polygon> _getPolygons() {
    List<Polygon> polygons = [];
    List<LatLng> coords = [
      LatLng(46.019269613810565, 14.392059200316794),
      LatLng(46.00019360812497, 14.617965572387106),
      LatLng(46.182100884605745, 14.680450313598044),
      LatLng(46.20396547808656, 14.325454586058981),
      LatLng(46.019269613810565, 14.392059200316794),
    ];
    for (int i = 0; i < 2; i++) {
      polygons.add(
        Polygon(
            points: coords
                .map((ll) =>
                LatLng(ll.latitude + 0.001 * i, ll.longitude + 0.001 * i))
                .toList(),
            color: Colors.green.withOpacity(0.5),
            borderColor: Colors.green,
            borderStrokeWidth: 2.0),
      );
    }
    return polygons;
  }
}