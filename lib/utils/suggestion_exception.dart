class InputException implements Exception {
  String message;
  InputException({required this.message});

  @override
  String toString() => message;
}
