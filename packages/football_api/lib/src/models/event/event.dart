import 'package:json_annotation/json_annotation.dart';

import '../team/team.dart';
import '../../interfaces/deserializable.dart';

part 'event.g.dart';

@JsonSerializable()
class Time implements Deserializable {
  final int? elapsed;
  final int? extra;

  Time({
    required this.elapsed,
    required this.extra,
  });

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);

  @override
  Time Function(Map<String, dynamic> object) get deserialize => Time.fromJson;
}