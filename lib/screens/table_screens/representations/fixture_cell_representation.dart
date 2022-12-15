import 'package:football_repository/football_repository.dart';

class FixtureCellRepresentation {
  FixtureCellRepresentation({required this.fixture});

  final Fixture fixture;

  String get id => fixture.id.toString();
  String get referee => fixture.referee ?? 'No Disponible';
  DateTime get date => fixture.date;
  String get leagueName => fixture.leagueName;
  FixtureTeamInfo get home => fixture.home;
  FixtureTeamInfo get away => fixture.away;
  String get homeTeamGoals => fixture.home.goals != -1 ? fixture.home.goals.toString() : '-';
  String get awayTeamGoals => fixture.away.goals != -1 ? fixture.away.goals.toString() : '-';
  String get stadium => fixture.stadium;
  String get round => fixture.round;
  bool get canSeeProgress => fixture.status == FixtureStatus.inProgress || fixture.status == FixtureStatus.finished;
}