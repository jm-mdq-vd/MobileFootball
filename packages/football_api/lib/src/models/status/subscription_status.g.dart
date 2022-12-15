// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Requests _$RequestsFromJson(Map<String, dynamic> json) => Requests(
      current: json['current'] as int,
      limitDay: json['limit_day'] as int,
    );

Map<String, dynamic> _$RequestsToJson(Requests instance) => <String, dynamic>{
      'current': instance.current,
      'limit_day': instance.limitDay,
    };

SubscriptionStatus _$SubscriptionStatusFromJson(Map<String, dynamic> json) =>
    SubscriptionStatus(
      requests: Requests.fromJson(json['requests'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubscriptionStatusToJson(SubscriptionStatus instance) =>
    <String, dynamic>{
      'requests': instance.requests,
    };
