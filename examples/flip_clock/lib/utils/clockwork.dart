class Clockwork {
  late DateTime _current;

  Stream<DateTime> wind(DateTime initial) {
    _current = initial;

    return Stream.periodic(Duration(seconds: 1), (_) {
      _current = _current.add(Duration(seconds: 1));
      return _current;
    });
  }
}
