class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class CacheException implements Exception {
  final String message;
  const CacheException(this.message);
}

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);
}

class UploadException implements Exception {
  final String message;
  const UploadException(this.message);
}

class ValidationException implements Exception {
  final String message;
  const ValidationException(this.message);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}