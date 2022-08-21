import 'package:football_repository/football_repository.dart';

import '../../widgets/generics/cells/cell_representable.dart';

class TeamCellViewModel implements CellRepresentable {
  const TeamCellViewModel({required this.team});

  final Team team;

  @override
  String get title => team.name;

  @override
  String get id => team.id.toString();

  @override
  String get semanticsLabel => team.name;

  @override
  String get imageURL => team.logo;
}