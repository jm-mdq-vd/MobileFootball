import 'package:football_repository/football_repository.dart';

import '../../widgets/generics/cells/cell_representable.dart';

class LeagueCellViewModel implements CellRepresentable {
  const LeagueCellViewModel({required this.league});

  final League league;

  @override
  String get title => league.name;

  @override
  String get id => league.id.toString();

  @override
  String get semanticsLabel => league.name;

  @override
  String get imageURL => league.logo;
}