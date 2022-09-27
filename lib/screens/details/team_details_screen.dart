import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/blocs/resource_status.dart';
import 'package:mobile_football/widgets/generics/loaders/screen_loader.dart';
import 'package:mobile_football/utility/network_image_provider.dart';

class TeamDetailScreen extends StatelessWidget {
  const TeamDetailScreen({
    super.key,
    required this.league,
    required this.season,
    required this.id,
  });

  final String league;
  final String season;
  final String id;

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
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
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
                          width: 360,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TeamDetailText('Fundado en el año ${team.founded}',),
                        const SizedBox(height: 8,),
                        TeamDetailText('Dirección del estadio: ${team.address}',),
                        const SizedBox(height: 8,),
                        TeamDetailText('Capacidad del estadio: ${team.stadiumCapacity} Personas',),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            TeamDetailText('Pais: ${team.country}',),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              /*
              RepositoryProvider<StatisticsRepository>(
                create: (context) => StatisticsRepository(null),
                child: BlocProvider<ResourceBloc<Statistics>>(
                  create: (context) => ResourceBloc(
                    repository: context.read<StatisticsRepository>(),
                  )..add(getStatistics(league, season, id)),
                  child: BlocBuilder<ResourceBloc<Statistics>, ResourceState<Statistics>>(
                    builder: (context, state) {
                      print(state.resources);
                      return Container(
                        child: Center(
                          child: const CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              */
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
        )..add(getTeamWithId(id)),
        child: BlocBuilder<ResourceBloc<Team>, ResourceState<Team>>(
          buildWhen: (_, current) => current.status.isSuccess,
          builder: (context, state) => _buildScreen(context, state),
        ),
      ),
    );
  }
}

class TeamDetailText extends StatelessWidget {
  const TeamDetailText(this.data, {super.key, this.fontSize = 18});

  final String data;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
