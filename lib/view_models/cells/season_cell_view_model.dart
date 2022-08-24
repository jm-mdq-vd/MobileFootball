import 'package:football_repository/football_repository.dart';

import '../../widgets/generics/cells/cell_representable.dart';

class SeasonCellViewModel implements BaseCellRepresentable {
  const SeasonCellViewModel({required this.season});

  final LeagueSeason season;

  @override
  String get title => season.year.toString();

  @override
  String get id => season.year.toString();
}