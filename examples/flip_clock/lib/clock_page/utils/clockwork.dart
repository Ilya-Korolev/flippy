class Clockwork {
  late DateTime _current;

  Stream<DateTime> wind(DateTime initial) {
    _current = initial;

    return Stream.periodic(const Duration(seconds: 1), (_) {
      _current = _current.add(const Duration(seconds: 1));
      return _current;
    });
  }
}
