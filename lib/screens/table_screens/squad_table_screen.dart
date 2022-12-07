import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/blocs/navigation/navigation_bloc.dart';
import 'package:mobile_football/blocs/resource_status.dart';
import 'package:mobile_football/widgets/generics/tables/table_representation.dart';
import 'package:mobile_football/widgets/generics/messages_screens.dart';

import 'package:mobile_football/widgets/generics/tables/unordered_list.dart';
import 'package:mobile_football/screens/resource_status_screen.dart';
import 'package:mobile_football/view_models/cells/player_cell_view_model.dart';

class SquadTableScreen extends StatelessWidget {
  const SquadTableScreen({
    super.key,
    required String teamId,
  }) : _teamId = teamId;

  final String _teamId;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<SquadsRepository>(
      create: (context) => SquadsRepository(null),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ResourceBloc<Squad>>(
            create: (context) => ResourceBloc(
              repository: context.read<SquadsRepository>(),
            )..add(getSquadByTeam(_teamId)),
          ),
          BlocProvider<NavigationBloc>(
            create: (context) => NavigationBloc(context: context),
          ),
        ],
        child: BlocBuilder<ResourceBloc<Squad>, ResourceState<Squad>>(
          builder: (context, state) {
            if (state.status.isInitial || state.status.isLoading) return ScreenLoader(message: 'Cargando Plantel...',);

            Map<Position, String> positions = {
              Position.goalkeeper : 'Arqueros',
              Position.defender : 'Defensores',
              Position.midfielder : 'Mediocampistas',
              Position.attacker : 'Atacantes',
            };

            return ResourceStatusScreen(
              state: state,
              loaderMessage: 'Cargando Plantel...',
              successWidget: Scaffold(
                appBar: AppBar(
                  title: const Text('Plantel',),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: positions.entries.map((entry) {
                      return SingleChildScrollView(
                        primary: false,
                        child: Column(
                          children: [
                            SectionHeader(title: entry.value,),
                            UnorderedList(
                              representation: TableRepresentation(
                                id: _teamId,
                                title: '',
                                content: state.resources.first.players
                                    .where((player) => player.position == entry.key)
                                    .map((player) => PlayerCellViewModel(player: player)).toList(),
                              ),
                              onSelection: (selectedItem) {

                              },
                              isScrollable: false,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required String title,
  }) : _title = title;

  final String _title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF6F6F6),
      height: 60,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16,),
        child: Text(
          _title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 26,
          ),
        ),
      ),
    );
  }
}

