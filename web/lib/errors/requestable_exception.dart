part of plato.paper.errors;

/**
 * The [RequestableException] should be used when dealing with errors relating to
 * course sections or sandboxes.
 */
class RequestableException extends PlatoPaperException {
  RequestableException ([String theMessage = '']) : super (theMessage) {
    if (1 > theMessage.length) {
      message = 'An unknown requestable related exception has occurred.';
    }
  }
}
