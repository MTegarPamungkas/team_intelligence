abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  final int? statusCode;

  ServerFailure({required String message, this.statusCode}) : super(message);
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({required String message}) : super(message);
}

class NetworkFailure extends Failure {
  NetworkFailure({String message = 'Network error occurred'}) : super(message);
}

class CacheFailure extends Failure {
  CacheFailure({String message = 'Cache error occurred'}) : super(message);
}

class UnknownFailure extends Failure {
  UnknownFailure({String message = 'An unknown error occurred'})
    : super(message);
}
