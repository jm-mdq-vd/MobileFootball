import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/blocs/resource_status.dart';
import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/view_models/cells/country_cell_view_model.dart';

import 'grid_screen.dart';
import 'leagues_grid_screen.dart';

class CountriesGridScreen extends StatelessWidget {
  const CountriesGridScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<CountryRepository>(
      create: (context) => CountryRepository(null),
      child: BlocProvider<ResourceBloc<CountryInfo>>(
        create: (context) => ResourceBloc(
          repository: context.read<CountryRepository>(),
        )..add(getCountries()),
        child: BlocBuilder<ResourceBloc<CountryInfo>, ResourceState<CountryInfo>>(
          buildWhen: (_, current) => current.status.isSuccess,
          builder: (context, state) {
            return GridScreen<CountryInfo>(
              state: state,
              title: 'Seleccionar Pais',
              loaderMessage: 'Obteniendo todos los paises disponibles...',
              content: state.resources.map((country) => CountryCellViewModel(country: country)).toList(),
              itemSpacing: 8,
              crossAxisCount: 3,
              onSelection: (selectedItem) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LeaguesGridScreen(
                    requirements: LeaguesGridScreenRequirements(
                        values: {
                          LeaguesGridScreenRequirements.titleKey: selectedItem.title,
                          LeaguesGridScreenRequirements.countryKey: selectedItem.id,
                        }
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}