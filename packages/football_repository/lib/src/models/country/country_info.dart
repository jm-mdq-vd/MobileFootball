import 'package:equatable/equatable.dart';

class CountryInfo extends Equatable {
  CountryInfo({
    required this.name,
    required this.code,
    required this.flag,
  });

  final String name;
  final String? code;
  final String? flag;

  @override
  List<Object> get props => [name,];
}