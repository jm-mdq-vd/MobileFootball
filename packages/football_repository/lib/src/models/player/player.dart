import 'package:equatable/equatable.dart';
import 'package:football_api/football_api.dart';

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
  final String position;
  final String? photo;

  @override
  List<Object> get props => [
    id,
    name,
    position,
  ];
}