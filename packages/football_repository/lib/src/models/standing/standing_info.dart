import 'package:equatable/equatable.dart';

import '../team/team.dart';

enum StatusForm {
  win,
  draw,
  lose
}

extension StatusFormX on StatusForm {
  static StatusForm from(String letter) {
    switch (letter) {
      case "W":
        return StatusForm.win;
      case "D":
        return StatusForm.draw;
      case "L":
        return StatusForm.lose;
      default:
        throw 'Fatal error: Invalid string used to build an MatchStatus instance';
    }
  }
}

enum Status {
  up,
  same,
  down
}

extension StatusX on Status {
  static Status from(String? status) {
    switch (status) {
      case "same":
        return Status.same;
      case "up":
        return Status.up;
      case "down":
        return Status.down;
      default:
        return Status.same;
    }
  }
}

extension StringToStatusForm on String {
  List<StatusForm> toStatusForm() {
    return runes.map((element) => StatusFormX.from(String.fromCharCode(element))).toList();
  }
}

class MatchesResult extends Equatable {
  MatchesResult({
    required this.played,
    required this.win,
    required this.draw,
    required this.lose,
  });

  final int played;
  final int win;
  final int draw;
  final int lose;

  @override
  List<Object> get props => [
    played,
    win,
    draw,
    lose,
  ];
}

class GeneralTeamInfo extends Equatable {
  GeneralTeamInfo({
    required this.rank,
    required this.points,
    required this.team,
    required this.status,
    required this.results,
    required this.group,
  });

  final int rank;
  final int points;
  final Team team;
  final Status status;
  final MatchesResult results;
  final String? group;

  @override
  List<Object> get props => [
    rank,
    points,
    team,
    status,
  ];
}

class StandingInfo extends Equatable {
  StandingInfo({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.flag,
    required this.season,
    required this.teams,
  });

  final int id;
  final String name;
  final String country;
  final String logo;
  final String flag;
  final int season;
  final List<List<GeneralTeamInfo>> teams;

  @override
  List<Object> get props => [
    id,
    name,
    country,
    logo,
    flag,
    season,
  ];
}