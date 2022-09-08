import 'package:flutter/material.dart';

import 'package:mobile_football/screens/grid_screens/countries_grid_screen.dart';
import 'package:mobile_football/screens/grid_screens/leagues_grid_screen.dart';
import 'package:mobile_football/screens/table_screens/seasons_table_screen.dart';
import 'package:mobile_football/screens/main_screens/main_season_tabs_screen.dart';
import 'package:mobile_football/screens/details/team_details_screen.dart';
import 'package:mobile_football/widgets/generics/cells/cell_representable.dart';

class AppCoordinator {
  void goToSelectCountry(BuildContext context) {
    _pushScreen(
      context,
      CountriesGridScreen(),
    );
  }

  void goToLeaguesForCountry(BuildContext context, CellRepresentable country) {
    _pushScreen(
      context,
      LeaguesGridScreen(
        title: country.title,
        country: country.id,
        coordinator: this,
      ),
    );
  }

  void goToSeasons(BuildContext context, CellRepresentable league) {
    _pushScreen(
      context,
      SeasonsTableScreen(
        selectedItem: league,
        coordinator: this,
      ),
    );
  }

  void goToMainSeason(BuildContext context, CellRepresentable league, BaseCellRepresentable season, bool isCup) {
    _pushScreen(
      context,
      MainSeasonTabScreen(
        isCup: isCup,
        title: league.title,
        leagueId: league.id,
        season: season.id.toString(),
        coordinator: this,
      ),
    );
  }

  void goToTeam(BuildContext context, String id) {
    _pushScreen(
      context,
      TeamDetailScreen(id: id),
    );
  }

  void _pushScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen,),
    );
  }
}