import 'package:equatable/equatable.dart';

import '../player/player.dart';

enum EventType { goal, card, substitution, referee_var, unknown }

extension EventTypeX on EventType {
  static EventType fromString(String value) {
    switch (value) {
      case 'Goal':
        return EventType.goal;
      case 'Card':
        return EventType.card;
      case 'Subst':
        return EventType.substitution;
      case 'Var':
        return EventType.referee_var;
      default:
        return EventType.unknown;
    }
  }
}

class Event extends Equatable {
  Event({
    required this.time,
    required this.type,
    required this.team,
    required this.logo,
    required this.player,
  });

  final String time;
  final EventType type;
  final String team;
  final String logo;
  final BasicPlayerInfo player;

  @override
  List<Object> get props => [
    time,
    type,
    team,
    logo,
    player,
  ];
}