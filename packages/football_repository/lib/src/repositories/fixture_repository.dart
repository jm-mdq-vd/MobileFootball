import 'package:football_api/football_api.dart' hide Fixture;

import '../models/fixtures/fixture.dart';
import '../cache/cache_implementable.dart';

class FixtureRepository extends TimedClientCacheRepository<Fixture> {
  FixtureRepository(super.client);

  Future<List<Fixture>> getResource(Map<String, dynamic> parameters) async {
    final results = await getResults(Endpoint.fixtures, parameters,);
    var fixtures = results
        .where((fixture) => DateTime.parse(fixture.fixture.date).isTodayOrClosest)
        .map((fixture) {
      return Fixture(
        id: fixture.fixture.id,
        referee: fixture.fixture.referee,
        date: DateTime.parse(fixture.fixture.date),
        elapsedTime: fixture.fixture.status.elapsed ?? 0,
        leagueName: fixture.league.name,
        round: fixture.league.round,
        home: FixtureTeamInfo(
          id: fixture.teams.home.id,
          name: fixture.teams.home.name,
          logo: fixture.teams.home.logo,
          winner: fixture.teams.home.winner ?? false,
          goals: fixture.goals.home ?? -1,
        ),
        away: FixtureTeamInfo(
          id: fixture.teams.away.id,
          name: fixture.teams.away.name,
          logo: fixture.teams.away.logo,
          winner: fixture.teams.away.winner ?? false,
          goals: fixture.goals.away ?? -1,
        ),
        stadium: fixture.fixture.venue.name ?? 'No Disponible',
      );
    }).toList();

    save(
      Endpoint.fixtures,
      parameters,
      results,
      saveWithTimeout: true,
    );

    return fixtures;
  }
}