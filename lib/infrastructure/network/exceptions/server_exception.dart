
class ServerException implements Exception {
  final String? message;
  ServerException({this.message});
}

class NetworkException implements Exception {}

class DatabaseException implements Exception {
  final String message;
  DatabaseException(this.message);
}
