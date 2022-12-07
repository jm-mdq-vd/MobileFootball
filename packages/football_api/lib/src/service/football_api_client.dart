import 'dart:convert';
import 'dart:core';
import 'dart:developer' as dev_tools;
import 'package:http/http.dart' as http;

import 'endpoint.dart';
import 'api_client.dart';
import '../models/models.dart';

extension DateHelpers on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isYesterday {
    final now = DateTime.now();
    return (now.day - 1) == day && now.month == month && now.year == year;
  }

  bool get isTomorrow {
    final now = DateTime.now();
    return (now.day + 1) == day && now.month == month && now.year == year;
  }

  static DateTime get endOfCurrentWeek {
    final daysToAdd = 7 - DateTime.now().weekday;
    return DateTime.now().add(Duration(days: daysToAdd));
  }

  static DateTime get startOfCurrentWeek {
    final daysToSubtract = DateTime.now().weekday - 1;
    return DateTime.now().subtract(Duration(days: daysToSubtract));
  }

  DateTime get endOfWeek {
    final daysToAdd = 7 - weekday;
    return add(Duration(days: daysToAdd));
  }

  DateTime get startOfWeek {
    final daysToSubtract = weekday - 1;
    return subtract(Duration(days: daysToSubtract));
  }

  bool get isThisWeek {
    return this.isAfter(startOfCurrentWeek) && this.isBefore(endOfCurrentWeek);
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

APIStatusCode _parseStatusCode(int statusCode) {
  switch (statusCode) {
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

  FootballAPIClient._privateConstructor();

  static final FootballAPIClient _instance = FootballAPIClient._privateConstructor();

  static FootballAPIClient get shared => _instance;

  Future<APIResponse> getResponseFromEndpoint<T>(Endpoint endpoint, Map<String, dynamic>? parameters,) async {
    final endpointPath = endpoint.path;
    return _get<T>(
      endpointPath,
      parameters,
          (list) => List<T>.from(list.map((object) => endpoint.parser(object),),),
    );
  }

  Future<APIResponse> _get<T>(
      String path,
      Map<String, dynamic>? parameters,
      List<T> Function(List list) fromJson,) async {

    /*
    final http.BaseRequest statusRequest = _buildRequest(
      'status',
      parameters,
    );

    final statusResponse = await statusRequest.send();
    final status = await _decodeStatusResponse(statusResponse);
    
    if (status.maxRequestsReached) {
      throw MaxNumberOfRequestsReached();
    }
    */

    final http.BaseRequest request = _buildRequest(
      path,
      parameters,
    );

    request.headers.addAll({_apiHeaderKey: _key});
    dev_tools.log(request.url.toString());

    final streamedResponse = await request.send();
    return _decodeResponse(streamedResponse, fromJson);
  }
  
  http.BaseRequest _buildRequest(String path, Map<String, dynamic>? parameters,) {
    return http.Request(
      _getMethod,
      Uri(
        scheme: _scheme,
        host: _host,
        path: path,
        queryParameters: parameters ?? {},
      ),
    );
  }

  Future<SubscriptionStatus> _decodeStatusResponse(http.StreamedResponse streamedResponse) async {
    if (streamedResponse.statusCode == 200) {
      final response = await http.Response.fromStream(streamedResponse);
      final decodedJson = jsonDecode(response.body);
      return APIResponse.status(decodedJson, Status.fromJson).response.first as SubscriptionStatus;
    } else {
      throw ServiceError(streamedResponse.statusCode);
    }
  }

  Future<APIResponse> _decodeResponse<T>(
      http.StreamedResponse streamedResponse,
      List<T> Function(List list) fromJson) async {

    if (streamedResponse.statusCode == 200) {
      final response = await http.Response.fromStream(streamedResponse);
      final decodedJson = jsonDecode(response.body);
      return APIResponse.fromJson(decodedJson, fromJson);
    } else {
      throw ServiceError(streamedResponse.statusCode);
    }
  }
}