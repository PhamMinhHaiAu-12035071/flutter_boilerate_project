class FetchDataException implements Exception {
  const FetchDataException({this.message});

  final String? message;

  @override
  String toString() => message ?? 'Error During Communication';
}
