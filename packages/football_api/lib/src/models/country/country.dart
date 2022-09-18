import 'package:json_annotation/json_annotation.dart';
import '../../interfaces/deserializable.dart';

part 'country.g.dart';

/// Result from https://v3.football.api-sports.io/countries
/// {
///   "name": "Argentina"
///   "code": "AR"
///   "flag": "https://media.api-sports.io/flags/ar.svg"
/// }
@JsonSerializable()
class Country implements Deserializable {
  Country({
    required this.name,
    required this.code,
    required this.flag,
  });

  final String name;
  final String? code;
  final String? flag;

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  @override
  Country Function(Map<String, dynamic> object) get deserialize => Country.fromJson;
}