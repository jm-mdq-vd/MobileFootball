import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta_weather_api/src/models/league/league_info.dart';

import '../models/models.dart';
import '../interfaces/deserializable.dart';

extension DateHelpers on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }
}

enum Endpoint {
  countries,
  leagues,
  teams,
  fixtures,
  venues,
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

class APIService {
  final String _getMethod = 'GET';
  final String _scheme = 'https';
  final String _host = 'v3.football.api-sports.io';
  final String _key = '0611975160523abb8507536bfd83172c';
  final String _apiHeaderKey = 'x-apisports-key';

  final int _maxRequestPerDay = 100;
  int _numberOfRequest = 0;
  DateTime _lastRequestDate = DateTime.now();

  APIService._privateConstructor();

  static final APIService _instance = APIService._privateConstructor();

  static APIService get shared => _instance;

  Future<APIResponse> getTeams(Map<String, dynamic>? parameters) {
    return _getResponseFromEndpoint(
      Endpoint.teams,
      parameters, // {'league': leagueId.toString(), 'season': season.toString()},
          (object) => TeamInfo.fromJson(object),
    );
  }

  Future<APIResponse> getLeaguesByCountry(Map<String, dynamic>? parameters) async {
    return _getResponseFromEndpoint(
      Endpoint.leagues,
      parameters, // {'code': countryId},
          (object) => LeagueInfo.fromJson(object),
    );
  }

  Future<APIResponse> getCountries(Map<String, dynamic>? parameters) async {
    return _getResponseFromEndpoint(
      Endpoint.countries,
      parameters, // {if (searchTerm != null) 'search': searchTerm},
          (object) => Country.fromJson(object),
    );
  }

  Future<APIResponse> _getResponseFromEndpoint<T extends Deserializable>(
      Endpoint endpoint,
      Map<String, dynamic>? parameters,
      T Function(Map<String, dynamic> object) fromJson,
      ) async {
    final endpointPath = _endpointPath(endpoint);
    return _get<T>(
      endpointPath,
      parameters,
          (list) => List<T>.from(list.map((object) => fromJson(object))),
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

    final streamedResponse = await request.send();
    if (streamedResponse.statusCode == 200) {
      final response = await http.Response.fromStream(streamedResponse);
      final decodedJson = jsonDecode(response.body);
      return APIResponse.fromJson(decodedJson, fromJson);
    } else {
      throw ServiceError(streamedResponse.statusCode);
    }
  }

  String _endpointPath(Endpoint endpoint) {
    switch (endpoint) {
      case Endpoint.countries:
        return 'countries';
      case Endpoint.leagues:
        return 'leagues';
      case Endpoint.teams:
        return 'teams';
      case Endpoint.fixtures:
        return 'fixtures';
      case Endpoint.venues:
        return 'venues';
    }
  }
}