import 'package:equatable/equatable.dart';
import 'package:football_repository/football_repository.dart';

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

enum FixtureStatus {
  inProgress,
  notStarted,
  cancelled,
  toBeDefined,
  finished,
  unknown
}

extension FixtureStatusX on FixtureStatus {
  static FixtureStatus fromValue(String value) {
    switch (value) {
      case 'TBD':
        return FixtureStatus.toBeDefined;
      case 'NS':
        return FixtureStatus.notStarted;
      case '1H':
      case '2H':
      case 'HT':
      case 'BT':
      case 'ET':
      case 'P':
      case 'LIVE':
        return FixtureStatus.inProgress;
      case 'FT':
      case 'AET':
      case 'PEN':
        return FixtureStatus.finished;
      case 'SUSP':
      case 'INT':
      case 'PST':
      case 'CANC':
      case 'ABN':
        return FixtureStatus.cancelled;
      default:
        return FixtureStatus.unknown;
    }
  }
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
    required this.status
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
  final FixtureStatus status;

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
    status,
  ];
}