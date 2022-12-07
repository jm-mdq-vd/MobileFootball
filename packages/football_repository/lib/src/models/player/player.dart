import 'package:equatable/equatable.dart';

enum Position {
  goalkeeper,
  defender,
  midfielder,
  attacker,
  unknown
}

extension PositionX on Position {
  static Position from(String position) {
    switch (position) {
      case "Goalkeeper":
        return Position.goalkeeper;
      case "Defender":
        return Position.defender;
      case "Midfielder":
        return Position.midfielder;
      case "Attacker":
        return Position.attacker;
      default:
        return Position.unknown;
    }
  }
}

class BasicPlayerInfo extends Equatable {
  BasicPlayerInfo({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  List<Object> get props => [
    id,
    name,
  ];
}

class Player extends BasicPlayerInfo {
  Player({
    required super.id,
    required super.name,
    required this.age,
    required this.number,
    required this.position,
    required this.photo,
  });

  final int? age;
  final int? number;
  final Position position;
  final String? photo;

  @override
  List<Object> get props => [
    id,
    name,
    position,
  ];
}