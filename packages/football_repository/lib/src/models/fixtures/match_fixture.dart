import 'package:equatable/equatable.dart';

class MatchTeam extends Equatable {
  MatchTeam({
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

class MatchFixture extends Equatable {
  MatchFixture({
    required this.id,
    required this.referee,
    required this.date,
    required this.elapsedTime,
    required this.leagueName,
    required this.round,
    required this.home,
    required this.away,
  });

  final int id;
  final String? referee;
  final DateTime date;
  final int elapsedTime;
  final String leagueName;
  final String round;
  final MatchTeam home;
  final MatchTeam away;


  @override
  List<Object> get props => [
    id,
    date,
    elapsedTime,
    leagueName,
    round,
    home,
    away,
  ];
}