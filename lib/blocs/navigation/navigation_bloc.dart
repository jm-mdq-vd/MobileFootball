import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:mobile_football/screens/grid_screens/leagues_grid_screen.dart';
import 'package:mobile_football/screens/table_screens/seasons_table_screen.dart';
import 'package:mobile_football/screens/main_screens/main_season_tabs_screen.dart';
import 'package:mobile_football/screens/screen_requirements.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc({required this.context}) : super(InCountrySelection()) {
    on<NavigationEvent>(_mapEventToState);
  }

  final BuildContext context;

  void _mapEventToState(NavigationEvent event, Emitter<NavigationState> emit) async {
    if (event is GoToLeague) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LeaguesGridScreen(
              requirements: LeaguesGridScreenRequirements(
                values: {
                  LeaguesGridScreenRequirements.titleKey: event.parameters[LeaguesGridScreenRequirements.titleKey],
                  LeaguesGridScreenRequirements.countryKey: event.parameters[LeaguesGridScreenRequirements.countryKey],
                },
              ),
            );
          },
        ),
      );
      emit(InLeagueSelection());
    }

    if (event is GoToSeasonSelection) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SeasonsTableScreen(selectedItem: event.parameters['league'],);
          },
        ),
      );
      emit(InSeasonSelection());
    }

    if (event is GoToMainScreen) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return MainSeasonTabScreen(
              requirements: LeagueSeasonRequirements(
                values: {
                  LeagueSeasonRequirements.titleKey: event.parameters['title'],
                  LeagueSeasonRequirements.leagueKey: event.parameters['leagueId'],
                  LeagueSeasonRequirements.seasonKey: event.parameters['season'],
                },
              ),
              isCup: event.parameters['isCup'],
            );
          },
        ),
      );
      emit(InMainScreen());
    }
  }
}