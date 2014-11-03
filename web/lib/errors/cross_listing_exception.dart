part of plato.paper.errors;

/// The [CrossListingException] should be used for errors relating to
/// cross-listings.
class CrossListingException extends PlatoPaperException {
  CrossListingException (
    [String message = 'An unknown cross-listing exception has occurred.']
  ) : super (message);
}
