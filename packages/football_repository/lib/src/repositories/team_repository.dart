import 'dart:async';
import 'package:football_api/football_api.dart' hide Team;
import 'package:football_repository/football_repository.dart';

import '../models/team/team.dart';
import '../extensions/list_extension.dart';

class TeamRepository implements Repository<Team> {
  TeamRepository() : _client = FootballAPIClient.shared;

  final FootballAPIClient _client;

  Future<List<Team>> getResource(Map<String, dynamic>? parameters) async {
    final response = await _client.getResponseFromEndpoint(Endpoint.teams, parameters,);
    final teamsInfo = response.response.castToType<TeamInfo>();
    return teamsInfo.map((teamInfo) => Team(
      id: teamInfo.team.id,
      stadiumId: teamInfo.venue.id,
      name: teamInfo.team.name,
      logo: teamInfo.team.logo,
      code: teamInfo.team.code,
      founded: teamInfo.team.founded,
      stadiumName: teamInfo.venue.name,
      city: teamInfo.venue.city,
      address: teamInfo.venue.address,
      stadiumCapacity: teamInfo.venue.capacity,
      stadiumImage: teamInfo.venue.image,
    )).toList();
  }
}