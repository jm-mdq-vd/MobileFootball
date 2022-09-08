import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/blocs/resource_status.dart';
import 'package:mobile_football/widgets/generics/loaders/screen_loader.dart';

class TeamDetailScreen extends StatelessWidget {
  const TeamDetailScreen({
    super.key,
    required this.id,
  });

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
            children: [
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: Image.network(team.stadiumImage ?? ''),
              ),
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
