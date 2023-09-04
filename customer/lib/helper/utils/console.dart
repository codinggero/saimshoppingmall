import 'dart:developer' as developer;

class Console {
  log(dynamic message) {
    developer.log('$message');
  }
}

Console console = Console();
