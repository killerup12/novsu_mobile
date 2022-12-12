abstract class MemoryException implements Exception {
  final String message;
  final String prefix;

  MemoryException(this.message, this.prefix);

  @override
  String toString() {
    return '$prefix : $message';
  }

  String getPrefix() => prefix;
}

class NotFoundInDeviceMemoryException extends MemoryException {
  NotFoundInDeviceMemoryException([message = ''])
    : super(message, 'Can not find something in this section! Check if did you write data there? Did you accidentally delete them earlier?');
}