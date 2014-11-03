part of plato.paper.errors;

/// The [PlatoPaperEventException] should be used when dealing with errors
/// relating to events triggered by Plato Paper elements.
class CommunicationsException extends PlatoPaperException {
  CommunicationsException (
    [String message = 'An unknown communications exception has occurred.']
  ) : super (message);
}
