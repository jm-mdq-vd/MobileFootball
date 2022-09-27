import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/blocs/resource_bloc.dart';
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
  final html = '''<!DOCTYPE html>
  <html>
  <body>
  <div id="wg-api-football-game"
    data-host="v3.football.api-sports.io"
    data-key="0611975160523abb8507536bfd83172c"
    data-id="831664"
    data-theme=""
    data-refresh="15"
    data-show-errors="false"
    data-show-logos="true">
  </div>
  <script
    type="module"
    src="https://widgets.api-sports.io/2.0.3/widgets.js">
  </script>
  </body>
  </html>''';

  void loadLocalHtml() async {
    final url = Uri.dataFromString(html, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString();
    // _controller.loadUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          color: const Color(0xB9EEECEC),
          child: Column(
            children: [
              Container(
                color: Color(0xFFE2E1E1),
                height: 50,
              ),
              SizedBox(height: 8,),
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

  final Fixture fixture;

  String get referee => fixture.referee ?? 'No Disponible';
  DateTime get date => fixture.date;
  String get leagueName => fixture.leagueName;
  FixtureTeamInfo get home => fixture.home;
  FixtureTeamInfo get away => fixture.away;
  String get homeTeamGoals => fixture.home.goals != -1 ? fixture.home.goals.toString() : '-';
  String get awayTeamGoals => fixture.away.goals != -1 ? fixture.away.goals.toString() : '-';
  String get stadium => fixture.stadium;
  String get round => fixture.round;
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
