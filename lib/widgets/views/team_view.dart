import 'package:flutter/material.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/utility/network_image_provider.dart';

class TeamView extends StatelessWidget {
  const TeamView({
    super.key,
    required FixtureTeamInfo team,
    double size = 100,
  }) : _team = team, _size = size;

  final FixtureTeamInfo _team;
  final double _size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: _size / 2,
            height: _size / 2,
            child: NetworkImageProvider.image(_team.logo,),
          ),
          SizedBox(height: 12,),
          Text(
            _team.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              overflow: TextOverflow.fade,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}