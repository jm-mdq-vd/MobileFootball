import 'package:football_api/football_api.dart' hide BasicTeamInfo, Team, Player;

import '../models/team/team.dart';
import '../models/team/squad.dart';
import '../models/player/player.dart';
import '../cache/cache_implementable.dart';

class SquadsRepository extends TimedClientCacheRepository<Squad> {
  SquadsRepository(super.client);

  Future<List<Squad>> getResource(Map<String, dynamic> parameters) async {
    final result = await getResults<TeamSquad>(Endpoint.squads, parameters,);
    final squad = result.first;

    List<Player> players = squad.players.map((player) =>
        Player(
          id: player.id.toString(),
          name: player.name,
          age: player.age,
          number: player.number,
          position: PositionX.from(player.position),
          photo: player.photo,
        ),
    ).toList();

    save(
      Endpoint.squads,
      parameters,
      result,
    );

    return [
      Squad(
        team: Team(
          id: squad.team.id,
          name: squad.team.name,
          logo: squad.team.logo,
          country: '',
        ),
        players: players,
      ),
    ];
  }
}