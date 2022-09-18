import 'package:football_api/football_api.dart';
import 'package:football_repository/src/extensions/list_extension.dart';

import 'repository.dart';
import '../models/fixtures/match_fixture.dart';

class FixtureRepository implements Repository<MatchFixture> {
  FixtureRepository(ApiClient? client)
      : _client = client != null ? client : FootballAPIClient.shared;

  final ApiClient _client;

  Future<List<MatchFixture>> getResource(Map<String, dynamic> parameters) async {
    final response = await _client.getResponseFromEndpoint(
      Endpoint.fixtures,
      parameters,
    );
    final parsedResponse = response.response.castToType<FixturesInfo>();
    var fixtures = parsedResponse.map((fixtures) {
      return MatchFixture(
        id: fixtures.fixture.id,
        referee: fixtures.fixture.referee,
        date: DateTime.parse(fixtures.fixture.date),
        elapsedTime: fixtures.fixture.status.elapsed ?? 0,
        leagueName: fixtures.league.name,
        round: fixtures.league.round,
        home: MatchTeam(
          id: fixtures.teams.home.id,
          name: fixtures.teams.home.name,
          logo: fixtures.teams.home.logo,
          winner: fixtures.teams.home.winner ?? false,
          goals: fixtures.goals.home ?? -1,
        ),
        away: MatchTeam(
          id: fixtures.teams.away.id,
          name: fixtures.teams.away.name,
          logo: fixtures.teams.away.logo,
          winner: fixtures.teams.away.winner ?? false,
          goals: fixtures.goals.away ?? -1,
        ),
      );
    }).toList();
    return fixtures;
  }
}