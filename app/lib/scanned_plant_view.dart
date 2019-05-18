import 'package:flutter/material.dart';

class ScannedPlantView extends StatefulWidget {
  final Map<String, dynamic> plant;

  ScannedPlantView(this.plant);

  @override
  State<StatefulWidget> createState() {
    return ScannedPlantViewState();
  }
}

class ScannedPlantViewState extends State<ScannedPlantView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Image.network(widget.plant['image_url']),
          Text(
            widget.plant['name']
          )
        ],
      ),
    );
  }
}