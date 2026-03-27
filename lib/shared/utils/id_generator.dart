class IdGenerator {
  static int _sequence = 0;

  static String next(String prefix) {
    _sequence += 1;
    return '${prefix}_${DateTime.now().millisecondsSinceEpoch}_$_sequence';
  }
}
