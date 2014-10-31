part of plato.paper.errors;

/**
 * The [PlatoPaperEventException] should be used when dealing with errors relating
 * to triggering events via Plato Paper elements.
 */
class PlatoPaperEventException extends PlatoPaperException {
  PlatoPaperEventException ([String theMessage = '']) : super (theMessage) {
    if (1 > theMessage.length) {
      message = 'An unknown event trigger exception has occurred.';
    }
  }
}
