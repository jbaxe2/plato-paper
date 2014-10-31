part of plato.paper.errors;

/**
 * The [PreviousContentException] should be used for errors relating to previous
 * content, either from Learn or Vista.
 */
class PreviousContentException extends PlatoPaperException {
  PreviousContentException ([String theMessage = '']) : super (theMessage) {
    if (1 > theMessage.length) {
      message = 'An unknown previous content exception has occurred.';
    }
  }
}
