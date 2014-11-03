part of plato.paper.errors;

/// The [RequestableException] should be used when dealing with errors relating
/// to course sections or sandboxes.
class RequestableException extends PlatoPaperException {
  RequestableException (
    [String message = 'An unknown requestable related exception has occurred.']
  ) : super (message);
}
