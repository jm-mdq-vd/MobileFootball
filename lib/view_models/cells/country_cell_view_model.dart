import 'package:football_repository/football_repository.dart';

import '../../widgets/generics/cells/cell_representable.dart';

class CountryCellViewModel implements CellRepresentable {
  const CountryCellViewModel({required this.country});

  final CountryInfo country;

  @override
  String get title => country.name;

  @override
  String get id => country.code ?? 'Unknown';

  @override
  String get semanticsLabel => country.name;

  @override
  String get imageURL => country.flag ?? '';
}