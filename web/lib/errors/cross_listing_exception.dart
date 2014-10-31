part of plato.paper.errors;

/**
 * The [CrossListingException] should be used for errors relating to cross-listings.
 */
class CrossListingException extends PlatoPaperException {
  CrossListingException ([String theMessage = '']) : super (theMessage) {
    if (1 > theMessage.length) {
      message = 'An unknown cross-listing exception has occurred.';
    }
  }
}
