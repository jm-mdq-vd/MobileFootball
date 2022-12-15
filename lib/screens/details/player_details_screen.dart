import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/blocs/resource_status.dart';
import 'package:mobile_football/utility/network_image_provider.dart';
import 'package:mobile_football/screens/screen_requirements.dart';
import 'package:mobile_football/widgets/generics/messages_screens.dart';
import 'package:mobile_football/widgets/generics/details/detail_text.dart';

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
            if (state.status.isInitial || state.status.isLoading) return ScreenLoader(message: 'Cargando informacion de ${_requirements.title}');

            if (state.status.isError) return ErrorScreen();

            if (state.status.isSuccess) {
              final player = state.resources.first;
              return  Scaffold(
                appBar: AppBar(
                  title: Text(player.name),
                ),
                body: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 24,
                        left: 8,
                        right: 8,
                      ),
                      height: 170,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(150 / 2,),
                              color: Colors.black,
                            ),
                            child: NetworkImageProvider.image(player.teamLogo),
                          ),
                          Container(
                            width: 150,
                            height: 150,
                            child: NetworkImageProvider.image(player.photo),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DetailBox(
                              representation: DetailBoxRepresentation(
                                title: 'edad',
                                value: player.age,
                              ),
                            ),
                            DetailBox(
                              representation: DetailBoxRepresentation(
                                title: 'peso',
                                value: player.weight,
                              ),
                            ),
                            DetailBox(
                              representation: DetailBoxRepresentation(
                                title: 'altura',
                                value: player.height,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0,),
                      child: Container(
                        padding: const EdgeInsets.all(16.0,),
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFEFEFEF),
                          borderRadius: BorderRadius.circular(16,),
                        ),
                        child: PlayerInfoCard(player: player,),
                      ),
                    )
                  ],
                ),
              );
            }

            throw 'Unknown status ${state.status}';
          },
        ),
      ),
    );
  }
}

class DetailBoxRepresentation {
  DetailBoxRepresentation({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;
}

class DetailBox extends StatelessWidget {
  const DetailBox({
    super.key,
    required DetailBoxRepresentation representation,
  }) : _representation = representation;

  final DetailBoxRepresentation _representation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      decoration: BoxDecoration(
        color: Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(16,),
      ),
      child: Stack(
        children: [
          Positioned(
            child: Text(
              _representation.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            top: 8,
            left: 8,
          ),
          Positioned(
            child: Text(
              _representation.value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            bottom: 8,
            right: 8,
          ),
        ],
      ),
    );
  }
}

class PlayerInfoCard extends StatelessWidget {
  const PlayerInfoCard({
    super.key,
    required PlayerDetail player,
  }) : _player = player;

  final PlayerDetail _player;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailText('Nombre: ${_player.firstname}',),
        const SizedBox(height: 8,),
        DetailText('Apellido: ${_player.lastname}',),
        const SizedBox(height: 8,),
        DetailText('Fecha de Nacimiento: ${_player.date}',),
        const SizedBox(height: 8,),
        DetailText('Ciudad: ${_player.place}',),
        const SizedBox(height: 8,),
        DetailText('Nacionalidad: ${_player.nationality}',),
      ],
    );
  }
}
