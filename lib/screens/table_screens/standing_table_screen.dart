import 'dart:developer' as devlog;

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
          StandingsHeader(),
          Column(
            children: state.resources.first.teams.map((team) {
              final index = state.resources.first.teams.indexOf(team);
              devlog.log('$index');
              return GestureDetector(
                onTap: () {
                  print(team.team.id);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: index % 2 == 0 ? Color(0xFFF6F6F6) : Color(0xFFE2E1E1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BoldText(team.rank.toString(),),
                      const SizedBox(width: 16,),
                      Container(
                        width: 30,
                        height: 30,
                        child: Image.network(team.team.logo,),
                      ),
                      const SizedBox(width: 16,),
                      _statusToIcon(team.status),
                      const SizedBox(width: 8,),
                      FittedBox(
                        child: BoldText(team.team.name,),
                      ),
                      const Spacer(),
                      const Spacer(),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(width: 16,),
                          BoldText(team.results.played.toString(),),
                          const SizedBox(width: 16,),
                          BoldText(team.results.win.toString(),),
                          const SizedBox(width: 16,),
                          BoldText(team.results.draw.toString(),),
                          const SizedBox(width: 16,),
                          BoldText(team.results.lose.toString(),),
                          const SizedBox(width: 16,),
                        ],
                      ),
                      const SizedBox(width: 24,),
                      BoldText(team.points.toString(),),
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

class StandingsHeader extends StatelessWidget {
  const StandingsHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          height: 60,
          color: Color(0xFFF6F6F6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const UnderlinedBoldText('CLUB',),
              const Spacer(),
              const Spacer(),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 16,),
                  const UnderlinedBoldText('J',),
                  const SizedBox(width: 16,),
                  const UnderlinedBoldText('G',),
                  const SizedBox(width: 16,),
                  const UnderlinedBoldText('E',),
                  const SizedBox(width: 16,),
                  const UnderlinedBoldText('P',),
                  const SizedBox(width: 16,),
                ],
              ),
              const SizedBox(width: 24,),
              const UnderlinedBoldText('PTS',),
            ],
          ),
        ),
        Container(height: 1, color: Colors.grey,)
      ],
    );
  }
}

class UnderlinedBoldText extends StatelessWidget {
  const UnderlinedBoldText(this.data, {super.key,});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        overflow: TextOverflow.fade,
      ),
    );
  }
}

class BoldText extends StatelessWidget {
  const BoldText(this.data, {super.key,});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: TextAlign.end,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.fade,
      ),
    );
  }
}