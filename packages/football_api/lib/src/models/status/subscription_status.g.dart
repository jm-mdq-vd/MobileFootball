// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Requests _$RequestsFromJson(Map<String, dynamic> json) => Requests(
      current: json['current'] as int,
      limitDay: json['limitDay'] as int,
    );

Map<String, dynamic> _$RequestsToJson(Requests instance) => <String, dynamic>{
      'current': instance.current,
      'limitDay': instance.limitDay,
    };

SubscriptionStatus _$SubscriptionStatusFromJson(Map<String, dynamic> json) =>
    SubscriptionStatus(
      requests: Map<String, int>.from(json['requests'] as Map),
    );

Map<String, dynamic> _$SubscriptionStatusToJson(SubscriptionStatus instance) =>
    <String, dynamic>{
      'requests': instance.requests,
    };
