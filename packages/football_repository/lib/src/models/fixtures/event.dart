import 'package:equatable/equatable.dart';

import '../player/player.dart';

enum EventType { goal, yellow_card, red_card, substitution, referee_var, unknown }

extension EventTypeX on EventType {
  static EventType fromString(String value, String detail) {
    switch (value.toLowerCase()) {
      case 'goal':
        return EventType.goal;
      case 'card':
        return detail == "Yellow Card" ? EventType.yellow_card : EventType.red_card;
      case 'subst':
        return EventType.substitution;
      case 'var':
        return EventType.referee_var;
      default:
        return EventType.unknown;
    }
  }

  String get description {
    switch (this) {
      case EventType.goal:
        return 'Gol';
      case EventType.yellow_card:
        return 'Tarjeta Amarilla';
      case EventType.red_card:
        return 'Tarjeta Roja';
      case EventType.substitution:
        return 'Substitucion';
      case EventType.referee_var:
        return 'VAR';
      default:
        return '';
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