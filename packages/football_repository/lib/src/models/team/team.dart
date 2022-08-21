import 'package:equatable/equatable.dart';

class Team extends Equatable {
  Team({
    required this.id,
    required this.stadiumId,
    required this.name,
    required this.logo,
    required this.code,
    required this.founded,
    required this.stadiumName,
    required this.city,
    required this.address,
    required this.stadiumCapacity,
    required this.stadiumImage,
  });

  final int id;
  final int? stadiumId;
  final String name;
  final String logo;
  final String? code;
  final int? founded;
  final String? stadiumName;
  final String? city;
  final String? address;
  final int? stadiumCapacity;
  final String? stadiumImage;

  @override
  List<Object> get props => [
    id,
    name,
    logo,
  ];
}