extension ListX on List {
  List<T> castToType<T>() {
    return this.map((item) => item as T).toList();
  }
}