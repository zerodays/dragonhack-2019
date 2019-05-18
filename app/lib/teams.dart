enum Team {
  red, blue
}

String teamToString(Team team) {
  switch (team) {
    case Team.blue:
      return 'blue';
    case Team.red:
      return 'red';
  }
}

Team currentTeam = Team.blue;