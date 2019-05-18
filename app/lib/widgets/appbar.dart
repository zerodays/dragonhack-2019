import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:dragonhack_2019/history_page.dart';
import '../util/colors.dart';

import '../globals.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final double height;

  CustomAppBar({
    Key key,
    this.height = appBarHeight,
  }) : preferredSize = Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            height: height,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32.0),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: 0.0,
                    bottom: 0.0,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                        child: Container(
                          alignment: Alignment.center,
                          color: AppColors.bcgColor.withOpacity(0.5),
                          child: Text(
                            'RED TEAM',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 22.0,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0.0,
                    top: 0.0,
                    bottom: 0.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(32.0),
                          bottomRight: Radius.circular(32.0)),
                      child: Container(
                        height: 56.0,
                        width: 56.0,
                        color: AppColors.primary,
                        child: IconButton(
                            icon: Icon(Icons.history),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => HistoryPage()));
                            }),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0.0,
                    top: 0.0,
                    bottom: 0.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          bottomLeft: Radius.circular(32.0)),
                      child: Container(
                        height: 56.0,
                        width: 56.0,
                        color: AppColors.primary,
                        child: IconButton(
                            icon: Icon(Icons.layers),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => HistoryPage()));
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
