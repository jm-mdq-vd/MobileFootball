import '../cells/cell_representable.dart';

class TableRepresentation {
  final String title;
  final List<BaseCellRepresentable> content;

  TableRepresentation({
    required this.content,
    required this.title,
  });
}