import 'dart:developer' as dev_tools;

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:mobile_football/screens/grid_screens/leagues_grid_screen.dart';

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
    }
  }
}