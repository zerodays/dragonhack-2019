enum Team {
  red, blue
}

int teamToInt(Team team) {
  switch (team) {
    case Team.blue:
      return 0;
    case Team.red:
      return 1;
  }
  return 0;
}

Team currentTeam = Team.blue;