import 'package:football_api/football_api.dart' hide BasicPlayerInfo;

import '../models/fixtures/event.dart';
import '../models/player/player.dart';
import '../cache/cache_implementable.dart';

class EventRepository extends TimedClientCacheRepository<Event> {
  EventRepository(super.client);

  Future<List<Event>> getResource(Map<String, dynamic> parameters) async {
    final results = await getResults<FixtureEvent>(Endpoint.events, parameters,);
    final events = results.map((event) {
      return Event(
        time: '${event.time.elapsed} +${event.time.extra}',
        type: EventTypeX.fromString(event.type),
        team: event.team.name,
        logo: event.team.logo,
        player: BasicPlayerInfo(
          id: event.player.id?.toString() ?? '',
          name: event.player.name,
        ),
      );
    }).toList();

    return events;
  }
}