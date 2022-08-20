// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
      year: json['year'] as int,
      start: json['start'] as String,
      end: json['end'] as String,
      current: json['current'] as bool,
      coverage: Coverage.fromJson(json['coverage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      'year': instance.year,
      'start': instance.start,
      'end': instance.end,
      'current': instance.current,
      'coverage': instance.coverage,
    };
