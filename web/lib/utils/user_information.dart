part of plato.paper.utils;

class UserInformation {
  /// The username and password for the user; could be empty [String]s for new
  /// users, but required for authenticating users.
  String _username, _password;

  /// The first and last names, e-mail, and user ID; required for all users.
  String _firstName, _lastName, _email, _userId;

  static UserInformation _instance;

  /// The [UserInformation] factory constructor helps to provide a Singleton
  /// pattern for the creation of an instance, since there should only be one
  /// context of the user within a Plato application's use.
  factory UserInformation() {
    if (null == _instance) {
      _instance = new UserInformation._internal();
    }

    return _instance;
  }

  /// The [UserInformation._internal] constructor is the private constructor
  /// which will create the actual instance of this class.
  UserInformation._internal() {
    _username = '';
    _password = '';
  }

  /// The setters for the UserInformation class' fields.
  set username (String username) => _username = username;
  set password (String password) => _password = password;
  set firstName (String firstName) => _firstName = firstName;
  set lastName (String lastName) => _lastName = lastName;
  set email (String email) => _email = email;
  set userId (String userId) => _userId = userId;

  /// The getters for the UserInformation class' fields.
  String get username => _username;
  String get password => _password;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get userId => _userId;

  /// The [toJson] method outputs an [Object] representation of the user
  /// information reflected by this class.
  Object toJson() {
    return {
      'username': _username,
      'password': _password,
      'firstName': _firstName,
      'lastName': _lastName,
      'email': _email,
      'userId': _userId
    };
  }
}
