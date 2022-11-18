class NetworkException implements Exception {
  final String message;
  final String prefix;

  NetworkException(this.message, this.prefix);

  @override
  String toString() {
    return '$prefix : $message';
  }

  String getPrefix() => prefix;
}

class FetchDataException extends NetworkException {
  FetchDataException([message])
      : super(message, 'Error During Communication');
}

class BadRequestException extends NetworkException {
  BadRequestException([message]) : super(message, 'Bad Request');
}

class UnauthorizedException extends NetworkException {
  UnauthorizedException([message]) : super(message, 'Unauthorized');
}

class NotFoundException extends NetworkException {
  NotFoundException([message]) : super(message, 'Not Found');
}

class ServerErrorException extends NetworkException {
  ServerErrorException([message]) : super(message, 'Internal Server Error');
}

class UnavailableErrorException extends NetworkException {
  UnavailableErrorException([message]) : super(message, 'Unavailable data');
}

class NoInternetConnectionException extends NetworkException {
  NoInternetConnectionException([message])
      : super(message, 'No internet connection');
}

class UnknownException extends NetworkException {
  UnknownException([message]) : super(message, 'Unknown error');
}