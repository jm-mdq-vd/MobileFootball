import 'package:equatable/equatable.dart';

import '../team/team.dart';
import '../player/player.dart';

class Squad extends Equatable {
  Squad({
    required this.team,
    required this.players,
  });

  final Team team;
  final List<Player> players;

  @override
  List<Object> get props => [
    team,
    players,
  ];
}