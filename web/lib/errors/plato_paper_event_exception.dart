part of plato.paper.errors;

/// The [PlatoPaperEventException] should be used when dealing with errors relating
/// to triggering events via Plato Paper elements.
class PlatoPaperEventException extends PlatoPaperException {
  PlatoPaperEventException (
    [String message = 'An unknown Plato Paper event exception has occurred.']
  ) : super (message);
}
