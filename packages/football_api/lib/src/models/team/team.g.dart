// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicTeamInfo _$BasicTeamInfoFromJson(Map<String, dynamic> json) =>
    BasicTeamInfo(
      id: json['id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String,
    );

Map<String, dynamic> _$BasicTeamInfoToJson(BasicTeamInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
    };

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      id: json['id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String,
      code: json['code'] as String?,
      country: json['country'] as String,
      founded: json['founded'] as int?,
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'code': instance.code,
      'country': instance.country,
      'founded': instance.founded,
    };
