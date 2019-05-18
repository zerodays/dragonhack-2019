import 'package:flutter/material.dart';
import 'custom_notched_rectangle.dart';
import 'package:flutter/foundation.dart';

class CustomBottomBar extends StatelessWidget {
  ValueListenable<ScaffoldGeometry> geometryListenable;

  CustomBottomBar();

  @override
  Widget build(BuildContext context) {
    geometryListenable = Scaffold.geometryOf(context);

    CustomClipper<Path> clipper = CustomBottomAppBarClipper(
      geometry: geometryListenable,
      shape: CustomCircularNotchedRectangle(context),
      notchMargin: 4.0,
    );

    return SafeArea(
      child: Container(
        height: 46.0,
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: clipper,
              child: Container(color: Colors.white,),
            ),ClipPath(
              clipper: clipper,
              child: Row(
                children: <Widget>[
                  _getPercentageRect(64.0, true),
                  _getPercentageRect(36.0, false),
                ],
              ),
            ),
            BottomAppBar(
              elevation: 0.0,
              color: Colors.transparent,
              shape: CustomCircularNotchedRectangle(context),
              notchMargin: 6.0,
              child: Container(
                height: 46.0,
                child: Row(
                  children: <Widget>[
                    _getPercentageDisplay(64.2, true),
                    Expanded(
                      child: Container(),
                    ),
                    _getPercentageDisplay(35.8, false)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getPercentageDisplay(double percentage, bool blue) {
    return Expanded(
      child: Container(
        height: 46.0,
        child: Center(
          child: Text(
            '$percentage %',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  _getPercentageRect(double percentage, bool blue) {
    return Expanded(
      flex: percentage.round(),
      child: Container(
        height: 46.0,
        color: blue ? Colors.blue.withOpacity(0.5) : Colors.red.withOpacity(0.5),
      ),
    );
  }
}
