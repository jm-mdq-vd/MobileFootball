import 'dart:developer' as dev_tools;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/blocs/resource_status.dart';
import 'package:mobile_football/screens/resource_status_screen.dart';
import 'package:mobile_football/widgets/generics/messages_screens.dart';
import 'package:mobile_football/widgets/texts/texts.dart';
import 'package:mobile_football/widgets/buttons/action_button.dart';
import 'package:mobile_football/screens/details/team_details_screen.dart';
import 'package:mobile_football/view_models/team_rank_row_view_model.dart';
import 'package:mobile_football/utility/network_image_provider.dart';
import 'package:mobile_football/screens/screen_requirements.dart';

class StandingTableScreen extends StatelessWidget {
  const StandingTableScreen({
    super.key,
    required LeagueSeasonRequirements requirements,
  }) : _requirements = requirements;

  final LeagueSeasonRequirements _requirements;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<StandingsRepository>(
      create: (context) => StandingsRepository(null),
      child: BlocProvider<ResourceBloc<StandingInfo>>(
        create: (context) => ResourceBloc(
          repository: context.read<StandingsRepository>(),
        )..add(getStanding(_requirements.leagueId, _requirements.season)),
        child: BlocBuilder<ResourceBloc<StandingInfo>, ResourceState<StandingInfo>>(
          builder: (context, state) {
            if (state.status.isInitial || state.status.isLoading) return ScreenLoader(message: 'Cargando posiciones para ${_requirements.title}...',);

            final standing = state.resources.first;
            List<StandingsGroupView> standingViews = standing.teams.map((group) {
              return StandingsGroupView(
                headline: group.first.group,
                requirements: _requirements,
                teams: group,
              );
            }).toList();

            return ResourceStatusScreen(
              state: state,
              loaderMessage: 'Cargando posiciones para ${_requirements.title}...',
              successWidget: Container(
                color: Color(0xFFDCDCDC),
                child: ListView(
                  children: standingViews,
                ),
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
    super.key,
    required this.title,
    this.groupDescription,
  });

  final String title;
  final String? groupDescription;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFFF6F6F6),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFDDDDDD),
                blurRadius: 40,
                offset: Offset(1, -2.5,),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 195,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4,),
                    if (groupDescription != null)
                      Text(
                        '(${groupDescription!})',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4,),
                    const UnderlinedBoldText('CLUB',),
                  ],
                ),
              ),
              Container(
                width: 120,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const UnderlinedBoldText('J',),
                      const UnderlinedBoldText('G',),
                      const UnderlinedBoldText('E',),
                      const UnderlinedBoldText('P',),
                    ],
                  ),
                ),
              ),
              Container(
                width: 30,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: const UnderlinedBoldText('PTS',),
                ),
              ),
            ],
          ),
        ),
        Container(height: 1, color: Colors.grey,),
      ],
    );
  }
}

class RankRow extends StatelessWidget {
  RankRow({
    super.key,
    required this.representation,
    required this.index,
  });

  final int index;
  final RankRowRepresentable representation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: index % 2 == 0 ? Color(0xFFF6F6F6) : Color(0xFFE2E1E1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 18,
            child: BoldText(representation.rank,),
          ),
          Container(
            width: 30,
            height: 30,
            child: NetworkImageProvider.image(representation.logo,),
          ),
          _statusToIcon(representation.status),
          Container(
            width: 100,
            child: ActionButton(
              action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeamDetailScreen(
                      requirements: TeamDetailScreenRequirements(
                        values: {
                          TeamDetailScreenRequirements.teamIdKey: representation.id,
                          TeamDetailScreenRequirements.leagueKey: (representation as TeamRankRowViewModel).leagueId,
                          TeamDetailScreenRequirements.seasonKey: (representation as TeamRankRowViewModel).seasonId
                        },
                      ),
                    ),
                  ),
                );
              },
              labelText: representation.name,
            ),
          ),
          Container(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BoldText(representation.played,),
                BoldText(representation.win,),
                BoldText(representation.draw,),
                BoldText(representation.lose,),
              ],
            ),
          ),
          Container(
            width: 30,
            child: Align(
              alignment: Alignment.centerRight,
              child: BoldText(representation.points,),
            ),
          ),
        ],
      ),
    );
  }

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
}

class StandingsGroupView extends StatelessWidget {
  const StandingsGroupView({
    super.key,
    required String? headline,
    required LeagueSeasonRequirements requirements,
    required List<GeneralTeamInfo> teams,
  }) : _headline = headline,  _requirements = requirements, _teams = teams;

  final String? _headline;
  final LeagueSeasonRequirements _requirements;
  final List<GeneralTeamInfo> _teams;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 80,),
          StandingsHeader(
            title: '${_requirements.title} ${_requirements.season}',
            groupDescription: _headline,
          ),
          Column(
            children: _teams.map((team) {
              final index = _teams.indexOf(team);
              return RankRow(
                representation: TeamRankRowViewModel(
                  team: team,
                  leagueId: _requirements.leagueId,
                  seasonId: _requirements.season,
                ),
                index: index,
              );
            }).toList(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 24
            ),
            height: 108,
            decoration: BoxDecoration(
              color: Color(0xFFF6F6F6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1.5,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    BoldText('J: Partidos Jugados'),
                    SizedBox(height: 16,),
                    BoldText('G: Ganados'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    BoldText('E: Empates'),
                    SizedBox(height: 16,),
                    BoldText('P: Perdidos'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    BoldText('PTS: Puntos'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
