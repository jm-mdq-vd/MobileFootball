import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

import '../interfaces/deserializable.dart';

part 'api_response.g.dart';

@JsonSerializable()
class Paging implements Deserializable {
  final int current;
  final int total;

  Paging({
    required this.current,
    required this.total,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => _$PagingFromJson(json);

  @override
  Paging Function(Map<String, dynamic> object) get deserialize => Paging.fromJson;
}

class APIResponse<T> {
  final String get;
  final int results;
  final Paging paging;
  List response;

  APIResponse({
    required this.get,
    required this.results,
    required this.paging,
    required this.response,
  });

  static APIResponse fromJson<T>(Map<String, dynamic> json, List<T> Function(List list) fromJson) {
    return APIResponse<T>(
      get: json['get'],
      results: json['results'],
      paging: Paging.fromJson(json['paging']),
      response: fromJson(List.from(json['response'])),
    );
  }
}