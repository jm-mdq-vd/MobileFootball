import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/screens/resource_status_screen.dart';
import 'package:mobile_football/screens/screen_requirements.dart';
import 'package:mobile_football/screens/table_screens/representations/fixture_cell_representation.dart';
import 'package:mobile_football/utility/network_image_provider.dart';
import 'package:mobile_football/widgets/views/team_view.dart';

class EventTableScreenRequirements implements ScreenRequirements {
  EventTableScreenRequirements({required Map<String, dynamic> values}) : _values = values;

  static String get fixtureKey => 'fixture';

  Map<String, dynamic> _values;

  FixtureCellRepresentation get fixture => _values[fixtureKey];

  String get fixtureId => fixture.id;
}

class EventTableScreen extends StatelessWidget {
  const EventTableScreen({
    super.key,
    required EventTableScreenRequirements requirements,
  }) : _requirements = requirements;

  final EventTableScreenRequirements _requirements;

  Widget _iconForType(EventType type) {
    switch (type) {
      case EventType.goal:
        return Icon(Icons.sports_soccer,);
      case EventType.yellow_card:
        return Container(
          width: 16,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.yellowAccent,
            borderRadius: BorderRadius.all(Radius.circular(2),),
          ),
        );
      case EventType.red_card:
        return Container(
          width: 16,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.all(Radius.circular(2),),
          ),
        );
      case EventType.substitution:
        return Icon(
          Icons.compare_arrows,
          color: Colors.deepOrangeAccent,
        );
      case EventType.referee_var:
        return Icon(
          Icons.tv,
          color: Colors.deepOrangeAccent,
        );
      default:
        return Icon(
          Icons.remove,
          color: Colors.grey,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<EventRepository>(
      create: (context) => EventRepository(null),
      child: BlocProvider<ResourceBloc<Event>>(
        create: (context) => ResourceBloc(
          repository: context.read<EventRepository>(),
        )..add(getEventsFromFixture(_requirements.fixtureId,),),
        child: BlocBuilder<ResourceBloc<Event>, ResourceState<Event>>(
          builder: (context, state) {
            return ResourceStatusScreen(
              state: state,
              loaderMessage: 'Cargando Eventos...',
              successWidget: Scaffold(
                appBar: AppBar(
                    title: const Text('Cronolog??a'),
                ),
                body: Container(
                  color: const Color(0xB9EEECEC),
                  child: Column(
                    children: [
                      EventTableHeader(representation: _requirements.fixture,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 8, left: 4, right: 4, bottom: 4),
                        child: Text(
                          'Cronolog??a del Partido',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.resources.length,
                          itemBuilder: (context, index) {
                            final event = state.resources[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8),),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFDDDDDD),
                                      blurRadius: 15.0,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: NetworkImageProvider.image(event.logo),
                                          ),
                                          const SizedBox(width: 16,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(event.player.name),
                                              Text(
                                                event.team,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          _iconForType(event.type),
                                          SizedBox(width: 8,),
                                          Text(event.time,),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class EventTableHeader extends StatelessWidget {
  const EventTableHeader({
    super.key,
    required FixtureCellRepresentation representation,
  }) : _representation = representation;

  final FixtureCellRepresentation _representation;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 12,),
          Text(
            _representation.stadium,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TeamView(
                team: _representation.home,
                size: 120,
              ),
              SizedBox(width: 16,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _representation.homeTeamGoals,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 16,),
                      Text(
                        'VS',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 16,),
                      Text(
                        _representation.awayTeamGoals,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 16,),
              TeamView(
                team: _representation.away,
                size: 120,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
