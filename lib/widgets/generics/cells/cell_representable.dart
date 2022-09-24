abstract class BaseCellRepresentable<T> {
  T get id;
  String get title;
}

abstract class CellRepresentable<T> implements BaseCellRepresentable<T> {
  T get id;
  String get title;
  String get semanticsLabel;
  String get imageURL;
  String get searchValue;
}
