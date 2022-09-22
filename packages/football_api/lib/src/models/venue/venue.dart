import 'package:football_api/football_api.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../interfaces/deserializable.dart';

part 'venue.g.dart';

@JsonSerializable()
class BaseVenue implements Deserializable {
  BaseVenue({
    required this.id,
    required this.name,
  });

  final int? id;
  final String? name;

  factory BaseVenue.fromJson(Map<String, dynamic> json) => _$BaseVenueFromJson(json);

  @override
  BaseVenue Function(Map<String, dynamic> object) get deserialize => BaseVenue.fromJson;
}

@JsonSerializable()
class Venue extends BaseVenue implements Deserializable {
  Venue({
    required super.id,
    required super.name,
    required this.address,
    required this.city,
    required this.capacity,
    required this.image,
  });

  final String? address;
  final String? city;
  final int? capacity;
  final String? image;

  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);

  @override
  Venue Function(Map<String, dynamic> object) get deserialize => Venue.fromJson;
}