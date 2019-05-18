import 'package:flutter/material.dart';

enum Team { red, blue }

int teamToInt(Team team) {
  switch (team) {
    case Team.blue:
      return 0;
    case Team.red:
      return 1;
  }
  return 0;
}

Team intToTeam(int i) {
  switch (i) {
    case 0:
      return Team.blue;
    case 1:
      return Team.red;
    default:
      return Team.blue;
  }
}

Color teamToColor(Team team) {
  switch (team) {
    case Team.blue:
      return Colors.blue;
    case Team.red:
      return Colors.red;
  }
  return Colors.blue;
}