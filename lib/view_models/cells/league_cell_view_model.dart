import 'package:football_repository/football_repository.dart';

import '../../widgets/generics/cells/cell_representable.dart';

class LeagueCellViewModel implements CellRepresentable {
  const LeagueCellViewModel({required League league}) : _league = league;

  final League _league;

  @override
  String get title => _league.name;

  @override
  String get id => _league.id.toString();

  @override
  String get semanticsLabel => _league.name;

  @override
  String get imageURL => _league.logo;

  @override
  String get searchValue => _league.name;

  bool get isCup => _league.isCup;

  List<LeagueSeason> get seasons => _league.seasons;
}