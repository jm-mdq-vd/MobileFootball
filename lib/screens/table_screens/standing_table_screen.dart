import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/blocs/resource_status.dart';
import 'package:mobile_football/widgets/generics/loaders/screen_loader.dart';
import 'package:mobile_football/widgets/generics/messages/no_results.dart';

class StandingTableScreen extends StatelessWidget {
  const StandingTableScreen({
    super.key,
    required this.title,
    required this.leagueId,
    required this.season,
  });

  final String title;
  final String leagueId;
  final String season;

  Icon _statusToIcon(Status status) {
    switch (status) {
      case Status.same:
        return Icon(
          Icons.remove,
          color: Colors.grey,
        );
      case Status.up:
        return Icon(
          Icons.arrow_drop_up,
          color: Colors.green,
        );
      case Status.down:
        return Icon(
          Icons.arrow_drop_down,
          color: Colors.red,
        );
    }
  }

  Widget _widgetForState(ResourceState<StandingInfo> state) {
    if (state.status.isLoading) {
      return ScreenLoader(message: 'Loading',);
    }

    if (state.status.isSuccess) {
      if (state.resources.isEmpty) {
        return const NoResults();
      }

      return ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: 60,
            color: Color(0xFFC9C7C7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Club',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  'Pts',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: state.resources.first.teams.map((team) {
              return GestureDetector(
                onTap: () {
                  print(team.team.id);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        team.rank.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 16,),
                      Container(
                        width: 30,
                        height: 30,
                        child: Image.network(team.team.logo,),
                      ),
                      SizedBox(width: 16,),
                      _statusToIcon(team.status),
                      SizedBox(width: 8,),
                      Text(
                        team.team.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        team.points.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ]
      );
    }

    return ScreenLoader(message: 'Loading standings for ${title}...',);
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<StandingsRepository>(
      create: (context) => StandingsRepository(null),
      child: BlocProvider<ResourceBloc<StandingInfo>>(
        create: (context) => ResourceBloc(
          repository: context.read<StandingsRepository>(),
        )..add(getStanding(leagueId, season)),
        child: BlocBuilder<ResourceBloc<StandingInfo>, ResourceState<StandingInfo>>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(title),
                backgroundColor: Colors.black,
              ),
              body: Container(
                child: _widgetForState(state),
              ),
            );
          },
        ),
      ),
    );
  }
}
