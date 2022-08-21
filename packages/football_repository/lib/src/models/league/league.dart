import 'package:equatable/equatable.dart';

class League extends Equatable {
  final int id;
  final String name;
  final String logo;
  final String country;

  League({
    required this.id,
    required this.name,
    required this.logo,
    required this.country,
  });

  @override
  List<Object> get props => [
    id,
    name,
    logo,
    country,
  ];
}