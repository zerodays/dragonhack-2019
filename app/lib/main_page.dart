import 'package:flutter/material.dart';
import 'globals.dart';
import 'widgets/appbar.dart';
import 'camera_view.dart';
import 'widgets/map.dart';
import 'widgets/custom_bottombar.dart';
import 'util/colors.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> overlayOptions = [
    'Markers',
    'Grassfield',
    'Height Edelweiss',
    'Height 0 - 100 m',
    'Height 200 - 300 m',
    'Height 300 - 400 m',
    'Height 400 - 500 m',
    'Height 600 - 700 m',
    'Height 700 - 800 m',
    'Height 800 - 900 m',
    'Height 900 - 1000 m',
    'Height 1000 - 1500 m',
    'Height 1500 - 2000 m',
    'Height 2000 - 3000 m',
  ];

  int currentOverlayOption = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: MapWidget(currentOverlayOption),
          ),
          Align(alignment: Alignment.bottomCenter, child: CustomBottomBar()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: appBarHeight / 2),
              child: FloatingActionButton(
                child: const Icon(Icons.camera, color: Colors.white),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => CameraView()));
                },
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CustomAppBar(
                overlayOptions: overlayOptions,
                callback: (int newOption) async {
                  setState(() {
                    currentOverlayOption = newOption;
                  });
                },
                selected: currentOverlayOption),
          )
        ],
      ),
    );
  }
}
