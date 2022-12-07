import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/blocs/navigation/navigation_bloc.dart';
import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/screens/resource_status_screen.dart';
import 'package:mobile_football/view_models/cells/country_cell_view_model.dart';

import 'grid_screen.dart';
import 'leagues_grid_screen.dart';

class CountriesGridScreen extends StatelessWidget {
  const CountriesGridScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<CountryRepository>(
      create: (context) => CountryRepository(null),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ResourceBloc<CountryInfo>>(
            create: (context) => ResourceBloc(
              repository: context.read<CountryRepository>(),
            )..add(getCountries()),
          ),
          BlocProvider<NavigationBloc>(
            create: (context) => NavigationBloc(context: context),
          ),
        ],
        child: BlocBuilder<ResourceBloc<CountryInfo>, ResourceState<CountryInfo>>(
          builder: (context, state) {
            return ResourceStatusScreen(
              state: state,
              loaderMessage: 'Obteniendo todos los paises disponibles...',
              successWidget: GridScreen(
                state: state,
                title: 'Seleccionar Pais',
                content: state.resources
                    .map((country) => CountryCellViewModel(country: country))
                    .toList(),
                itemSpacing: 8,
                crossAxisCount: 3,
                onSelection: (selectedItem) {
                  context.read<NavigationBloc>().add(
                    GoToLeague(
                      parameters: {
                        LeaguesGridScreenRequirements.titleKey: selectedItem.title,
                        LeaguesGridScreenRequirements.countryKey: selectedItem.id,
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
