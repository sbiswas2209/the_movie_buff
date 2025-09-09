extension ListExtension<T> on List<T> {
  T? get firstOrNull {
    if (isEmpty) {
      throw StateError('No elements');
    }
    return first;
  }
}
