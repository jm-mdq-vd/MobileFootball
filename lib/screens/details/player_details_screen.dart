import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/screens/resource_status_screen.dart';
import 'package:mobile_football/utility/network_image_provider.dart';
import 'package:mobile_football/screens/screen_requirements.dart';

class PlayerDetailsScreenRequirements extends ScreenRequirements {
  PlayerDetailsScreenRequirements({required Map<String, dynamic> values}) : _values = values;

  static String get titleKey => 'title';
  static String get playerIdKey => 'playerId';
  static String get seasonKey => 'season';

  @override
  Map<String, dynamic> _values;

  String get title => _values[titleKey];
  String get playerId => _values[playerIdKey];
  String get season => _values[seasonKey];
}

class PlayerDetailsScreen extends StatelessWidget {
  const PlayerDetailsScreen({
    super.key,
    required PlayerDetailsScreenRequirements requirements,
  }) : _requirements = requirements;

  final PlayerDetailsScreenRequirements _requirements;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<PlayerRepository>(
      create: (context) => PlayerRepository(null),
      child: BlocProvider<ResourceBloc<PlayerDetail>>(
        create: (context) => ResourceBloc(
          repository: context.read<PlayerRepository>(),
        )..add(getPlayerDetails(_requirements.playerId, _requirements.season,),),
        child: BlocBuilder<ResourceBloc<PlayerDetail>, ResourceState<PlayerDetail>>(
          builder: (context, state) {
            return ResourceStatusScreen(
              state: state,
              loaderMessage: 'Cargando informacion de ${_requirements.title}',
              successWidget: Scaffold(
                appBar: AppBar(
                  title: Text(_requirements.title),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
