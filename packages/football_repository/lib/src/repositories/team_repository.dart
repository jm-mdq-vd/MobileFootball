import 'dart:async';
import 'package:football_api/football_api.dart' hide Team;
import 'package:football_repository/football_repository.dart';

import '../models/team/team.dart';
import '../cache/cache_implementable.dart';

class TeamRepository extends ClientCacheRepository<Team> {
  TeamRepository(super.client);

  Future<List<Team>> getResource(Map<String, dynamic> parameters) async {
    final teamsInfo = await getResults(Endpoint.teams, parameters,);
    final teams = teamsInfo.map((teamInfo) => Team(
      id: teamInfo.team.id,
      stadiumId: teamInfo.venue.id,
      name: teamInfo.team.name,
      logo: teamInfo.team.logo,
      code: teamInfo.team.code,
      founded: teamInfo.team.founded,
      stadiumName: teamInfo.venue.name,
      city: teamInfo.venue.city,
      country: teamInfo.team.country,
      address: teamInfo.venue.address,
      stadiumCapacity: teamInfo.venue.capacity,
      stadiumImage: teamInfo.venue.image,
    )).toList();

    save(
      Endpoint.teams,
      parameters,
      teamsInfo,
    );

    return teams;
  }
}