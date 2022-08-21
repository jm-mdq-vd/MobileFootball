import '../cells/cell_representable.dart';

class GridRepresentation {
  final String title;
  final List<CellRepresentable> content;

  GridRepresentation({
    required this.content,
    required this.title,
  });
}
