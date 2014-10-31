part of plato.paper.errors;

/**
 * The [PlatoPaperException] is an abstract [Exception] class, and is the base
 * class for all of the Plato Paper exceptions.
 */
abstract class PlatoPaperException implements Exception {
  String message = 'An unknown Plato Paper exception has occurred.';

  PlatoPaperException ([String theMessage = '']) : super () {
    if (0 < theMessage.length) {
      this.message = theMessage;
    }
  }

  String toString() => message;
}
