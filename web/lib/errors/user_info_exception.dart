part of plato.paper.errors;

/// The [UserInfoException] should be used with dealing with errors relating
/// to the user's information.
class UserInfoException extends PlatoPaperException {
  UserInfoException (
    [String message = 'An unknown user information exception has occurred.']
  ) : super (message);
}
