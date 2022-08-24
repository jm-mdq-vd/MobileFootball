import '../cells/cell_representable.dart';

class TableRepresentation {
  final String id;
  final String title;
  final List<BaseCellRepresentable> content;

  TableRepresentation({
    required this.id,
    required this.content,
    required this.title,
  });
}