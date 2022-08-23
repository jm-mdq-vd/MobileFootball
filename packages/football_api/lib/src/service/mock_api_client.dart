import 'dart:convert';

import 'api_client.dart';
import 'endpoint.dart';
import '../models/models.dart';

final _countries = """
{
  "get": "countries",
  "results": 6,
  "paging": 
  {
    "current": 1,
    "total": 1
  },
  "response": [
    {
      "name": "Argentina",
      "code": "AR",
      "flag": "https://media.api-sports.io/flags/ar.svg"
    },
    {
      "name": "Argentina",
      "code": "AR",
      "flag": "https://media.api-sports.io/flags/ar.svg"
    },
    {
      "name": "Argentina",
      "code": "AR",
      "flag": "https://media.api-sports.io/flags/ar.svg"
    },
    {
      "name": "Argentina",
      "code": "AR",
      "flag": "https://media.api-sports.io/flags/ar.svg"
    },
    { 
      "name": "Argentina",
      "code": "AR",
      "flag": "https://media.api-sports.io/flags/ar.svg"
    },
    {
      "name": "Argentina",
      "code": "AR",
      "flag": "https://media.api-sports.io/flags/ar.svg"
    }
  ]
}
""";

final _leagues = """
{
  "get": "leagues",
  "results": 1,
  "paging": 
  {
    "current": 1,
    "total": 1
  },
 "response": [
    {
      "league": 
      {
        "id": 134,
        "name": "Torneo Federal A",
        "type": "League",
        "logo": "https://media.api-sports.io/football/leagues/134.png"
      },
      "country": {
        "name": "Argentina",
        "code": "AR",
        "flag": "https://media.api-sports.io/flags/ar.svg"
      },
      "seasons": 
      [
        {
          "year": 2022,
          "start": "2022-02-12",
          "end": "2022-10-01",
          "current": true,
          "coverage": {
            "fixtures": {
              "events": true,
              "lineups": true,
              "statistics_fixtures": false,
              "statistics_players": false
            },
            "standings": true,
            "players": true,
            "odds": true,
            "predictions": true
          }
        }
      ]
    }      
 ]
}
""";

final _teams = """
{
  "get": "teams",
  "results": 1,
  "paging": 
  {
    "current": 1,
    "total": 1
  },
  "response": [
    {
      "team": {
        "id": 434,
        "name": "Gimnasia L.P.",
        "code": "GIM",
        "country": "Argentina",
        "founded": 1887,
        "national": false,
        "logo": "https://media.api-sports.io/football/teams/434.png"
      },
      "venue": {
        "id": 77,
        "name": "Estadio Juan Carmelo Zerillo",
        "address": "Avenida 60 y 118",
        "city": "La Plata, Provincia de Buenos Aires",
        "capacity": 24544,
        "surface": "grass",
        "image": "https://media.api-sports.io/football/venues/77.png"
      }
    }
  ]
}
""";

class MockAPIClient implements ApiClient {
  Future<APIResponse> getResponseFromEndpoint<T>(Endpoint endpoint, Map<String, dynamic>? parameters,) async {
    var decodedJson;

    switch (endpoint) {
      case Endpoint.countries:
        decodedJson = jsonDecode(_countries);
        break;
      case Endpoint.leagues:
        decodedJson = jsonDecode(_leagues);
        break;
      case Endpoint.teams:
        decodedJson = jsonDecode(_teams);
        break;
      default:
        decodedJson = {};
    }

    return Future.delayed(Duration(seconds: 1), () {
      return APIResponse.fromJson(
        decodedJson,
            (list) => List<T>.from(list.map((object) => endpoint.parser(object))),
      );
    });
  }
}