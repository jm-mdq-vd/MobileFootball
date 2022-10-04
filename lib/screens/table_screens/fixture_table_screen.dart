import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/screens/table_screens/event_table_screen.dart';
import 'package:mobile_football/utility/extensions/date_extension.dart';
import 'package:mobile_football/utility/network_image_provider.dart';
import 'package:mobile_football/screens/resource_status_screen.dart';
import 'package:mobile_football/screens/screen_requirements.dart';

class FixtureTableScreen extends StatelessWidget {
  const FixtureTableScreen({
    super.key,
    required LeagueSeasonRequirements requirements,
  }) : _requirements = requirements;

  final LeagueSeasonRequirements _requirements;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<FixtureRepository>(
      create: (context) => FixtureRepository(null),
      child: BlocProvider<ResourceBloc<Fixture>>(
        create: (context) => ResourceBloc(
          repository: context.read<FixtureRepository>(),
        )..add(getFixturesByLeague(_requirements.leagueId, _requirements.season)),
        child: BlocBuilder<ResourceBloc<Fixture>, ResourceState<Fixture>>(
          builder: (context, state) {
            return ResourceStatusScreen(
              state: state,
              loaderMessage: 'Cargando Partidos...',
              successWidget: FixtureTable(
                representation: FixtureTableRepresentation(
                  content: state.resources.map((fixture) => FixtureCellRepresentation(fixture: fixture)).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FixtureTableRepresentation {
  FixtureTableRepresentation({required this.content});

  final List<FixtureCellRepresentation> content;
}

class FixtureTable extends StatefulWidget {
  const FixtureTable({
    super.key,
    required this.representation,
  });

  final FixtureTableRepresentation representation;

  int get itemCount => representation.content.length;
  FixtureCellRepresentation itemAtIndex(int index) => representation.content[index];

  @override
  State<FixtureTable> createState() => _FixtureTableState();
}

class _FixtureTableState extends State<FixtureTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          color: const Color(0xB9EEECEC),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 8.0,),
                      child: GestureDetector(
                        onTap: () {
                          if (widget.itemAtIndex(index).canSeeProgress) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventTableScreen(
                                  requirements: EventTableScreenRequirements(
                                    values: {
                                      EventTableScreenRequirements.fixtureKey: widget.itemAtIndex(index),
                                    },
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: FixtureCell(
                          representation: widget.itemAtIndex(index),
                        ),
                      ),
                    );
                  },
                  itemCount: widget.itemCount,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class FixtureCellRepresentation {
  FixtureCellRepresentation({required this.fixture});

  final Fixture fixture;

  String get id => fixture.id.toString();
  String get referee => fixture.referee ?? 'No Disponible';
  DateTime get date => fixture.date;
  String get leagueName => fixture.leagueName;
  FixtureTeamInfo get home => fixture.home;
  FixtureTeamInfo get away => fixture.away;
  String get homeTeamGoals => fixture.home.goals != -1 ? fixture.home.goals.toString() : '-';
  String get awayTeamGoals => fixture.away.goals != -1 ? fixture.away.goals.toString() : '-';
  String get stadium => fixture.stadium;
  String get round => fixture.round;
  bool get canSeeProgress => fixture.status == FixtureStatus.inProgress || fixture.status == FixtureStatus.finished;
}

class FixtureCell extends StatelessWidget {
  const FixtureCell({
    super.key,
    required this.representation,
  });

  final FixtureCellRepresentation representation;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12),),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            representation.stadium,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TeamView(team: representation.home),
              SizedBox(width: 16,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        representation.homeTeamGoals,
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
                        representation.awayTeamGoals,
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
              TeamView(team: representation.away),
            ],
          ),
          if (representation.canSeeProgress)
            Text(
              'VER RESULTADOS',
              style: TextStyle(
                color: Colors.blueAccent,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Fecha: ${representation.date.dayMonthYear}',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 20,),
              Text(
                'Round: ${representation.round}',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TeamView extends StatelessWidget {
  const TeamView({
    Key? key,
    required this.team,
  }) : super(key: key);

  final FixtureTeamInfo team;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            child: NetworkImageProvider.image(team.logo,),
          ),
          SizedBox(height: 8,),
          Text(
            team.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              overflow: TextOverflow.fade,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
