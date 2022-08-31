import 'package:football_repository/football_repository.dart';

abstract class RankRowRepresentable {
  String get id;
  String get rank;
  String get name;
  String get logo;
  String get played;
  String get win;
  String get draw;
  String get lose;
  String get points;
  Status get status;
}

class TeamRankRowViewModel implements RankRowRepresentable {
  TeamRankRowViewModel({required this.team});

  final GeneralTeamInfo team;

  @override
  String get draw => team.results.draw.toString();

  @override
  String get id => team.team.id.toString();

  @override
  String get logo => team.team.logo;

  @override
  String get lose => team.results.lose.toString();

  @override
  String get name => team.team.name;

  @override
  String get played => team.results.played.toString();

  @override
  String get points => team.points.toString();

  @override
  String get rank => team.rank.toString();

  @override
  Status get status => team.status;

  @override
  String get win => team.results.win.toString();
}