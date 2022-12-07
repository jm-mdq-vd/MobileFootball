import 'package:football_repository/football_repository.dart';

import '../../widgets/generics/cells/cell_representable.dart';

class CountryCellViewModel implements CellRepresentable {
  const CountryCellViewModel({required CountryInfo country}) : _country = country;

  final CountryInfo _country;

  @override
  String get title => _country.name;

  @override
  String get id => _country.code ?? 'Unknown';

  @override
  String get semanticsLabel => _country.name;

  @override
  String get imageURL => _country.flag ?? '';

  @override
  String get searchValue => _country.name;
}