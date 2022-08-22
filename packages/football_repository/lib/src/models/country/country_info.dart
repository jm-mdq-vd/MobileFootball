import 'package:equatable/equatable.dart';

class Country extends Equatable {
  Country({
    required this.name,
    required this.code,
    required this.flag,
    required this.numberOfLeagues,
  });

  final String name;
  final String? code;
  final String? flag;
  final int numberOfLeagues;

  @override
  List<Object> get props => [name, numberOfLeagues];
}