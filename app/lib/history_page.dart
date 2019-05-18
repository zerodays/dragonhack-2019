import 'package:flutter/material.dart';

import 'api.dart';
import 'widgets/plant_tile.dart';

class HistoryPage extends StatefulWidget {
  @override
  HistoryPageState createState() {
    return HistoryPageState();
  }
}

class HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> plants;

  @override
  void initState() {
    super.initState();

    getPlants();
  }

  Future<void> getPlants() async {
    var newPlants = await getHistoryScans();

    setState(() {
      plants = newPlants;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: plants == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              padding: EdgeInsets.all(16.0),
              itemBuilder: plantsBuilder,
              itemCount: plants.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3 / 4, crossAxisSpacing: 16.0, mainAxisSpacing: 16.0),
            ),
    );
  }

  Widget plantsBuilder(BuildContext context, int index) {
    return PlantTile(plants[index]);
  }
}
