import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/blocs/resource_status.dart';
import 'package:mobile_football/screens/table_screens/squad_table_screen.dart';
import 'package:mobile_football/screens/screen_requirements.dart';
import 'package:mobile_football/widgets/generics/loaders/screen_loader.dart';
import 'package:mobile_football/widgets/buttons/action_button.dart';
import 'package:mobile_football/utility/network_image_provider.dart';

class TeamDetailScreenRequirements implements ScreenRequirements {
  TeamDetailScreenRequirements({required Map<String, dynamic> values}) : _values = values;

  static String get teamIdKey => 'teamId';
  static String get leagueKey => 'leagueId';
  static String get seasonKey => 'season';

  @override
  Map<String, dynamic> _values;

  String get teamId => _values[teamIdKey];
  String get leagueId => _values[leagueKey];
  String get season => _values[seasonKey];
}

class TeamDetailScreen extends StatelessWidget {
  const TeamDetailScreen({
    super.key,
    required TeamDetailScreenRequirements requirements,
  }) : _requirements = requirements;

  final TeamDetailScreenRequirements _requirements;

  Widget _buildScreen(BuildContext context, ResourceState<Team> state) {
    if (state.status.isLoading) {
      return ScreenLoader(message: 'Cargando informacion del equipo',);
    }

    if (state.status.isSuccess) {
      final team = state.resources.first;
      return Scaffold(
        appBar: AppBar(
          title: Text(team.name),
          backgroundColor: Colors.black,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 280,
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                child: NetworkImageProvider.image(team.stadiumImage ?? ''),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 340,
                          child: Text(
                            team.stadiumName ?? '',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          child: Image.network(team.logo),
                        )
                      ],
                    ),
                    Text(
                      team.city ?? '',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 8,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xF0F5F5F5),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0.25, 0.25),
                            blurRadius: 5,
                            blurStyle: BlurStyle.inner,
                          ),
                        ],
                      ),
                      child: TeamInfoCard(team: team),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ActionButton(
                      action: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SquadTableScreen(requirements: _requirements,),
                          ),
                        );
                      },
                      labelText: 'VER PLANTEL',
                      style: ActionButton.defaultStyle.copyWith(fontSize: 24,),
                    ),
                    const SizedBox(width: 16,),
                    const Icon(FontAwesomeIcons.peopleGroup),
                  ],
                ),
              ),
              // StatisticsCard(league: league, season: season, id: id),
            ],
          ),
        ),
      );
    }

    return ScreenLoader(message: 'Cargando informacion del equipo',);
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<TeamRepository>(
      create: (context) => TeamRepository(null),
      child: BlocProvider<ResourceBloc<Team>>(
        create: (context) => ResourceBloc(
          repository: context.read<TeamRepository>(),
        )..add(getTeamWithId(_requirements.teamId)),
        child: BlocBuilder<ResourceBloc<Team>, ResourceState<Team>>(
          builder: (context, state) => _buildScreen(context, state),
        ),
      ),
    );
  }
}

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({
    Key? key,
    required this.league,
    required this.season,
    required this.id,
  }) : super(key: key);

  final String league;
  final String season;
  final String id;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<StatisticsRepository>(
      create: (context) => StatisticsRepository(null),
      child: BlocProvider<ResourceBloc<Statistics>>(
        create: (context) => ResourceBloc(
          repository: context.read<StatisticsRepository>(),
        )..add(getStatistics(league, season, id)),
        child: BlocBuilder<ResourceBloc<Statistics>, ResourceState<Statistics>>(
          builder: (context, state) {
            if (state.status.isInitial || state.status.isLoading) {
              return Container(
                child: Center(
                  child: const CircularProgressIndicator(color: Colors.black,),
                ),
              );
            }

            if (state.status.isError) return const Text('Something wrong happened');

            if (state.status.isSuccess) {
              Container(
                height: 100,
                width: 100,
                color: Colors.blueAccent,
              );
            }

            return Container(
              child: Center(
                child: const CircularProgressIndicator(color: Colors.black,),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TeamInfoCard extends StatelessWidget {
  const TeamInfoCard({
    Key? key,
    required this.team,
  }) : super(key: key);

  final Team team;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TeamDetailText('Fundado en el año: ${team.founded}',),
        const SizedBox(height: 8,),
        TeamDetailText('Dirección del estadio: ${team.address}',),
        const SizedBox(height: 8,),
        TeamDetailText('Capacidad del estadio: ${team.stadiumCapacity} Personas',),
        const SizedBox(height: 8,),
        TeamDetailText('Pais: ${team.country}',),
        const SizedBox(height: 8,),
        TeamDetailText('Ciudad: ${team.city}',),
      ],
    );
  }
}

class TeamDetailText extends StatelessWidget {
  const TeamDetailText(this.data, {super.key, this.fontSize = 18});

  final String data;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        data,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
