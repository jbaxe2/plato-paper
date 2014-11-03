part of plato.paper.errors;

/// The [PlatoPaperException] is an abstract [Exception] class, and is the base
/// class for all of the Plato Paper exceptions.
abstract class PlatoPaperException implements Exception {
  final String _message;

  PlatoPaperException (
    [this._message = 'An unknown Plato Paper error has occurred.']
  );

  String toString() => _message;
}
