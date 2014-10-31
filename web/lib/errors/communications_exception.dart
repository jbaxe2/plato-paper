part of plato.paper.errors;

/// The [PlatoPaperEventException] should be used when dealing with errors relating
/// to communicating with the server.
class CommunicationsException extends PlatoPaperException {
  CommunicationsException ([String theMessage = '']) : super (theMessage) {
    if (1 > theMessage.length) {
      message = 'An unknown communications exception has occurred.';
    }
  }
}
