import 'package:flutter/material.dart';
import '../globals.dart';
import '../util/custom_notched_rectangle.dart';
import '../util/colors.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(blue ? 'BLUE' : 'RED', style: TextStyle(color: AppColors.primary[700], fontSize: 14.0, fontWeight: FontWeight.w700),),
              Container(height: 4.0,),
              Text(
                '$percentage %',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }
}
