import 'package:equatable/equatable.dart';

class StandingInfo extends Equatable {
  StandingInfo({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.flag,
    required this.season,
  });

  final int id;
  final String name;
  final String country;
  final String logo;
  final String flag;
  final int season;

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