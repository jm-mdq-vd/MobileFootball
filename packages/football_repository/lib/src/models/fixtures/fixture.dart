import 'package:equatable/equatable.dart';

class FixtureTeamInfo extends Equatable {
  FixtureTeamInfo({
    required this.id,
    required this.name,
    required this.logo,
    required this.winner,
    required this.goals,
  });

  final int id;
  final String name;
  final String logo;
  final bool winner;
  final int goals;

  @override
  List<Object> get props => [
    id,
    name,
    logo,
    winner,
    goals,
  ];
}

class Fixture extends Equatable {
  Fixture({
    required this.id,
    required this.referee,
    required this.date,
    required this.elapsedTime,
    required this.leagueName,
    required this.round,
    required this.home,
    required this.away,
    required this.stadium,
    required this.isFinished,
  });

  final int id;
  final String? referee;
  final DateTime date;
  final int elapsedTime;
  final String leagueName;
  final String round;
  final FixtureTeamInfo home;
  final FixtureTeamInfo away;
  final String stadium;
  final bool isFinished;


  @override
  List<Object> get props => [
    id,
    date,
    elapsedTime,
    leagueName,
    round,
    home,
    away,
    stadium,
    isFinished,
  ];
}