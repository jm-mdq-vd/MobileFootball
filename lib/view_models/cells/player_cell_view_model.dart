import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/widgets/generics/cells/cell_representable.dart';

class PlayerCellViewModel implements BaseCellRepresentable {
  const PlayerCellViewModel({required Player player}) : _player = player;

  final Player _player;

  @override
  String get title => _player.name;

  @override
  String get id => _player.id;

  String? get photo => _player.photo;
  String get age => _player.age.toString() ?? 'No Disponible';
}