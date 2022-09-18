import 'package:equatable/equatable.dart';

import '../league/league.dart';

class MatchesStatistics {
  const MatchesStatistics({
    required this.totalPlayed,
    required this.totalWins,
    required this.totalDraws,
    required this.totalLoses,
  });

  final int totalPlayed;
  final int totalWins;
  final int totalDraws;
  final int totalLoses;
}

class Statistics extends Equatable {
  const Statistics({
    required this.league,
    required this.matchesStatistics,
  });

  final League league;
  final MatchesStatistics matchesStatistics;

  @override
  List<Object> get props => [
    league,
    matchesStatistics,
  ];
}