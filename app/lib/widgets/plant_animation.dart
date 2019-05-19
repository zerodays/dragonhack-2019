import 'package:flutter/material.dart';

class PlantAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PlantAnimationState();
  }

}

class PlantAnimationState extends State<PlantAnimation> with SingleTickerProviderStateMixin {
  AnimationController _animController;
  CurvedAnimation _curvedAnimation;
  Tween<double> _moveX;
  Tween<double> _scale;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [] + _getAnimatedChildren(),
    );
  }

  List<Widget> _getAnimatedChildren() {
    List<Widget> _animPlants = [];
    return _animPlants;
  }

}