import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/utility/network_image_provider.dart';
import 'package:mobile_football/screens/resource_status_screen.dart';

class MatchTableScreen extends StatelessWidget {
  const MatchTableScreen({
    super.key,
    required this.title,
    required this.leagueId,
    required this.season,
  });

  final String title;
  final String leagueId;
  final String season;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<FixtureRepository>(
      create: (context) => FixtureRepository(null),
      child: BlocProvider<ResourceBloc<MatchFixture>>(
        create: (context) => ResourceBloc(
          repository: context.read<FixtureRepository>(),
        )..add(getFixturesByLeague(leagueId, season)),
        child: BlocBuilder<ResourceBloc<MatchFixture>, ResourceState<MatchFixture>>(
          builder: (context, state) {
            return ResourceStatusScreen(
              state: state,
              loaderMessage: 'Cargando Partidos...',
              successWidget: MatchTable(
                representation: MatchTableRepresentation(
                  content: state.resources.map((fixture) => MatchCellRepresentation(fixture: fixture)).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MatchTableRepresentation {
  MatchTableRepresentation({required this.content});

  final List<MatchCellRepresentation> content;
}

class MatchTable extends StatefulWidget {
  const MatchTable({
    super.key,
    required this.representation,
  });

  final MatchTableRepresentation representation;

  int get itemCount => representation.content.length;
  MatchCellRepresentation itemAtIndex(int index) => representation.content[index];

  @override
  State<MatchTable> createState() => _MatchTableState();
}

class _MatchTableState extends State<MatchTable> {
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
                    return ListTile(
                      title: MatchCell(
                        representation: widget.itemAtIndex(index),
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


class MatchCellRepresentation {
  MatchCellRepresentation({required this.fixture});

  final MatchFixture fixture;

  String get referee => fixture.referee ?? 'No Disponible';
  DateTime get date => fixture.date;
  String get leagueName => fixture.leagueName;
  MatchTeam get home => fixture.home;
  MatchTeam get away => fixture.away;
  String get homeTeamGoals => fixture.home.goals != -1 ? fixture.home.goals.toString() : '-';
  String get awayTeamGoals => fixture.away.goals != -1 ? fixture.away.goals.toString() : '-';
}

class MatchCell extends StatelessWidget {
  const MatchCell({
    super.key,
    required this.representation,
  });

  final MatchCellRepresentation representation;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(1, 1),
            blurRadius: 2,
            blurStyle: BlurStyle.outer,
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TeamView(team: representation.home),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  representation.leagueName,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            TeamView(team: representation.away),
          ],
        ),
      ),
    );
  }
}

class TeamView extends StatelessWidget {
  const TeamView({
    Key? key,
    required this.team,
  }) : super(key: key);

  final MatchTeam team;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
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
