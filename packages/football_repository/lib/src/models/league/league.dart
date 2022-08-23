import 'package:equatable/equatable.dart';

import '../season/league_season.dart';

class League extends Equatable {
  const League({
    required this.id,
    required this.name,
    required this.logo,
    required this.country,
    required this.seasons,
  });

  final int id;
  final String name;
  final String logo;
  final String country;
  final List<LeagueSeason> seasons;

  @override
  List<Object> get props => [
    id,
    name,
    logo,
    country,
    seasons,
  ];
}