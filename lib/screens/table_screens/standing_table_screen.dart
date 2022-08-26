import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';
import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/blocs/resource_status.dart';

class StandingTableScreen extends StatelessWidget {
  const StandingTableScreen({
    super.key,
    required this.leagueId,
    required this.season,
  });

  final String leagueId;
  final String season;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<StandingsRepository>(
      create: (context) => StandingsRepository(null),
      child: BlocProvider<ResourceBloc<StandingInfo>>(
        create: (context) => ResourceBloc(
          repository: context.read<StandingsRepository>(),
        )..add(getStanding(leagueId, season)),
        child: BlocBuilder<ResourceBloc<StandingInfo>, ResourceState<StandingInfo>>(
          buildWhen: (_, current) => current.status.isSuccess,
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text('League'),
              ),
              body: Container(
                child: ListView.builder(
                  itemCount: state.resources.length,
                  itemBuilder: (context, index) => Text(state.resources[index].name),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
