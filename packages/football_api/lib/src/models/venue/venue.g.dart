// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseVenue _$BaseVenueFromJson(Map<String, dynamic> json) => BaseVenue(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$BaseVenueToJson(BaseVenue instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Venue _$VenueFromJson(Map<String, dynamic> json) => Venue(
      id: json['id'] as int?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      capacity: json['capacity'] as int?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$VenueToJson(Venue instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'city': instance.city,
      'capacity': instance.capacity,
      'image': instance.image,
    };
