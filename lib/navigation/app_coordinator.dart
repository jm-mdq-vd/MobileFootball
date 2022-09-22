import 'package:flutter/material.dart';

import 'package:mobile_football/screens/grid_screens/countries_grid_screen.dart';
import 'package:mobile_football/screens/grid_screens/leagues_grid_screen.dart';
import 'package:mobile_football/screens/screen_requirements.dart';
import 'package:mobile_football/screens/table_screens/seasons_table_screen.dart';
import 'package:mobile_football/screens/main_screens/main_season_tabs_screen.dart';
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
        requirements: LeaguesGridScreenRequirements(
          values: {
            LeaguesGridScreenRequirements.titleKey: country.title,
            LeaguesGridScreenRequirements.countryKey: country.id,
          }
        ),
      ),
    );
  }

  void goToMainSeason(BuildContext context, CellRepresentable league, BaseCellRepresentable season, bool isCup) {
    _pushScreen(
      context,
      MainSeasonTabScreen(
        isCup: isCup,
        requirements: LeagueSeasonRequirements(
          values: {
            LeagueSeasonRequirements.titleKey: league.title,
            LeagueSeasonRequirements.leagueKey: league.id,
            LeagueSeasonRequirements.seasonKey: season.id.toString(),
          }
        ),
      ),
    );
  }

  void _pushScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen,),
    );
  }
}