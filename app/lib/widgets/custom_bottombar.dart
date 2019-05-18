import 'package:flutter/material.dart';
import '../globals.dart';
import '../util/custom_notched_rectangle.dart';

class CustomBottomBar extends StatelessWidget {
  static const height = appBarHeight;
  CustomBottomBar();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            BottomAppBar(
              elevation: 0.0,
              shape: CustomCircularNotchedRectangle(context),
              notchMargin: 6.0,
              child: Container(
                height: height,
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
        height: height,
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
        height: height,
//        color: blue ? Colors.blue.withOpacity(0.5) : Colors.red.withOpacity(0.5),
        color: Colors.white
      ),
    );
  }
}
