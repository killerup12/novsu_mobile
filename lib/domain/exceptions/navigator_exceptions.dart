class RouteNotFoundException implements Exception {
  late final String message;

  RouteNotFoundException(String route) {
    message = "The route \"$route\" not found!";
  }
}

class RouteDoesNotExistException implements Exception {
  final String message = 'The route has not been specified!';
}