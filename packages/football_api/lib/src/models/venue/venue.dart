import 'package:json_annotation/json_annotation.dart';
import '../../interfaces/deserializable.dart';

part 'venue.g.dart';

@JsonSerializable()
class Venue implements Deserializable {
  Venue({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.capacity,
    required this.image,
  });

  final int? id;
  final String? name;
  final String? address;
  final String? city;
  final int? capacity;
  final String? image;

  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);

  @override
  Venue Function(Map<String, dynamic> object) get deserialize => Venue.fromJson;
}