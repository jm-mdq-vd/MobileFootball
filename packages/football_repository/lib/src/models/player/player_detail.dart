import 'package:equatable/equatable.dart';

class PlayerDetail extends Equatable {
  PlayerDetail({
    required this.id,
    required this.name,
    required this.firstname,
    required this.lastname,
    required this.age,
    required this.date,
    required this.place,
    required this.country,
    required this.nationality,
    required this.height,
    required this.weight,
    required this.photo,
  });

  final int id;
  final String name;
  final String firstname;
  final String lastname;
  final String age;
  final String date;
  final String place;
  final String country;
  final String nationality;
  final String height;
  final String weight;
  final String photo;

  @override
  List<Object> get props => [
    id,
    name,
    firstname,
    lastname,
  ];
}