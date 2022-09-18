import 'package:equatable/equatable.dart';

class Team extends Equatable {
  Team({
    required this.id,
    required this.name,
    required this.logo,
    required this.country,
    this.stadiumId = null,
    this.code = null,
    this.founded = null,
    this.stadiumName = null,
    this.city = null,
    this.address = null,
    this.stadiumCapacity = null,
    this.stadiumImage = null,
  });

  final int id;
  final int? stadiumId;
  final String name;
  final String logo;
  final String? code;
  final int? founded;
  final String? stadiumName;
  final String? city;
  final String country;
  final String? address;
  final int? stadiumCapacity;
  final String? stadiumImage;

  @override
  List<Object> get props => [
    id,
    name,
    logo,
    country,
  ];
}