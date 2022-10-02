import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/screens/resource_status_screen.dart';
import 'package:mobile_football/screens/screen_requirements.dart';
import 'package:mobile_football/utility/network_image_provider.dart';

class EventTableScreenRequirements implements ScreenRequirements {
  EventTableScreenRequirements({required Map<String, dynamic> values}) : _values = values;

  static String get fixtureIdKey => 'fixtureId';

  Map<String, dynamic> _values;

  String get fixtureId => _values[fixtureIdKey];
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
                    title: const Text('Cronología'),
                ),
                body: Container(
                  color: const Color(0xB9EEECEC),
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
              ),
            );
          },
        ),
      ),
    );
  }
}