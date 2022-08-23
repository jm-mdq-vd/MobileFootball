import 'dart:convert';
import 'dart:developer' as devlog;
import 'package:http/http.dart' as http;

import 'endpoint.dart';
import 'api_client.dart';
import '../models/models.dart';

extension DateHelpers on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }
}

enum APIStatusCode {
  ok,
  noContent,
  timeOut,
  internalServerError,
  unknown,
}

String _statusCodeToString(int statusCode) {
  final apiStatusCode = _parseStatusCode(statusCode);

  switch (apiStatusCode) {
    case APIStatusCode.ok:
      return 'OK';
    case APIStatusCode.noContent:
      return 'No Content';
    case APIStatusCode.timeOut:
      return 'Time Out';
    case APIStatusCode.internalServerError:
      return 'Internal Server Error';
    case APIStatusCode.unknown:
      return 'Unknown';
  }
}

APIStatusCode _parseStatusCode(int statusCode)
{
  switch (statusCode)
  {
    case 200:
      return APIStatusCode.ok;
    case 204:
      return APIStatusCode.noContent;
    case 499:
      return APIStatusCode.timeOut;
    case 500:
      return APIStatusCode.internalServerError;
    default:
      return APIStatusCode.unknown;
  }
}

class ServiceError implements Exception {
  int statusCode;

  ServiceError(this.statusCode);

  @override
  String toString() => Exception(_statusCodeToString(statusCode)).toString();
}

class MaxNumberOfRequestsReached implements Exception {
  @override
  String toString() => Exception('The maximum request per day was reached').toString();
}

class FootballAPIClient implements ApiClient {
  final String _getMethod = 'GET';
  final String _scheme = 'https';
  final String _host = 'v3.football.api-sports.io';
  final String _key = '0611975160523abb8507536bfd83172c';
  final String _apiHeaderKey = 'x-apisports-key';

  final int _maxRequestPerDay = 100;
  int _numberOfRequest = 0;
  DateTime _lastRequestDate = DateTime.now();

  FootballAPIClient._privateConstructor();

  static final FootballAPIClient _instance = FootballAPIClient._privateConstructor();

  static FootballAPIClient get shared => _instance;

  Future<APIResponse> getResponseFromEndpoint<T>(Endpoint endpoint, Map<String, dynamic>? parameters,) async {
    final endpointPath = endpoint.path;
    return _get<T>(
      endpointPath,
      parameters,
          (list) => List<T>.from(list.map((object) => endpoint.parser(object))),
    );
  }

  Future<APIResponse> _get<T>(
      String path,
      Map<String, dynamic>? parameters,
      List<T> Function(List list) fromJson,) async {
    _numberOfRequest = !_lastRequestDate.isToday ? 0 : _numberOfRequest++;
    _lastRequestDate = DateTime.now();

    if (_numberOfRequest == _maxRequestPerDay) {
      throw MaxNumberOfRequestsReached();
    }

    final http.BaseRequest request = http.Request(
      _getMethod,
      Uri(
        scheme: _scheme,
        host: _host,
        path: path,
        queryParameters: parameters ?? {},
      ),
    );

    request.headers.addAll({_apiHeaderKey: _key});
    devlog.log(request.url.toString());

    final streamedResponse = await request.send();
    if (streamedResponse.statusCode == 200) {
      final response = await http.Response.fromStream(streamedResponse);
      final decodedJson = jsonDecode(response.body);
      return APIResponse.fromJson(decodedJson, fromJson);
    } else {
      throw ServiceError(streamedResponse.statusCode);
    }
  }
}