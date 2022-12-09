import 'dart:developer' as dev_tools;

import 'package:football_api/football_api.dart';

import '../models/player/player_detail.dart';
import '../cache/cache_implementable.dart';

class PlayerRepository extends TimedClientCacheRepository<PlayerDetail> {
  PlayerRepository(super.client);

  Future<List<PlayerDetail>> getResource(Map<String, dynamic> parameters) async {
    final result = await getResults<PlayerInfo>(Endpoint.players, parameters,);
    final info = result.first;

    dev_tools.log('${result.first}');

    final detail = PlayerDetail(
      id: info.player.id ?? 0,
      name: info.player.name,
      firstname: info.player.firstname,
      lastname: info.player.lastname,
      age: info.player.age.toString() ?? 'No Disponible',
      date: info.player.birth.date ?? 'No Disponible',
      place: info.player.birth.place ?? 'No Disponible',
      country: info.player.birth.country ?? 'No Disponible',
      nationality: info.player.nationality,
      height: info.player.height,
      weight: info.player.weight,
      photo: info.player.photo,
    );

    save(
      Endpoint.players,
      parameters,
      result,
    );

    return [detail];
  }
}





