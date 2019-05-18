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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: MapWidget(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomBar()
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: appBarHeight/2),
              child: FloatingActionButton(
                child: const Icon(Icons.local_florist, color: Colors.white),
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
            child: CustomAppBar(),
          )
        ],
      ),
    );
  }
}
