import 'package:json_annotation/json_annotation.dart';

part 'subscription_status.g.dart';

@JsonSerializable()
class Requests {
  Requests({
    required this.current,
    required this.limitDay,
  });

  final int current;
  final int limitDay;

  factory Requests.fromJson(Map<String, dynamic> json) => _$RequestsFromJson(json);
}

@JsonSerializable()
class SubscriptionStatus {
  SubscriptionStatus({required this.requests});

  final Map<String, int> requests;

  bool get maxRequestsReached => requests['current']! >= requests['limit_day']!;

  factory SubscriptionStatus.fromJson(Map<String, dynamic> json) => _$SubscriptionStatusFromJson(json);
}