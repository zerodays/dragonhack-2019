import 'package:flutter/material.dart';
import '../globals.dart';
import '../util/custom_notched_rectangle.dart';
import '../util/colors.dart';
import 'package:dragonhack_2019/api.dart';

class CustomBottomBar extends StatefulWidget {
  static const height = appBarHeight;

  CustomBottomBar();

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  // 0 = blue, 1 = red
  String _redPercentage = '-';
  String _bluePercentage = '-';

  @override
  void initState() {
    super.initState();

    getPercentage().then((data) {
      setState(() {
        _bluePercentage = "${data['0']} %";
        _redPercentage = "${data['1']} %";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: CustomBottomBar.height,
        child: Stack(
          children: <Widget>[
            BottomAppBar(
              elevation: 0.0,
              shape: CustomCircularNotchedRectangle(context),
              notchMargin: 6.0,
              child: Container(
                height: CustomBottomBar.height,
                child: Row(
                  children: <Widget>[
                    _getPercentageDisplay(_bluePercentage, true),
                    Expanded(
                      child: Container(),
                    ),
                    _getPercentageDisplay(_redPercentage, false)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getPercentageDisplay(String value, bool blue) {
    return Expanded(
      child: Container(
        height: CustomBottomBar.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                blue ? 'BLUE' : 'RED',
                style: TextStyle(
                    color: AppColors.primary[700],
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700),
              ),
              Container(
                height: 4.0,
              ),
              Text(
                value,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }
}
