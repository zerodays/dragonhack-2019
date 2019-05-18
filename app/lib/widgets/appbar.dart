import 'package:flutter/material.dart';

Widget getAppBar() {
  return AppBar(
    backgroundColor: Colors.red,
    title: Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.satellite),
          onPressed: () => {},
        ),
        Expanded(
          child: Text(
            'RED TEAM',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0),
          ),
        ),
        IconButton(
          icon: Icon(Icons.satellite),
          onPressed: () => {},
        )
      ],
    ),
  );
}
