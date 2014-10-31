library plato.paper.authenticator;

import 'dart:html';

import 'package:polymer/polymer.dart';

import 'package:paper_elements/paper_input.dart';
import 'package:paper_elements/paper_toast.dart';

/// A Polymer-based element, using paper elements, to display username/password
/// authentication controls for logging into Plato.
@CustomTag('plato-authenticator')
class PlatoAuthenticator extends PolymerElement {
  /// A [String] representing the username for the Plato user.
  @published
  String get username => readValue (#username);
         set username (String theUsername) => writeValue (#username, theUsername);

  /// A [String] representing the password for the Plato user.
  @published
  String get password => readValue (#password);
         set password (String thePassword) => writeValue (#password, thePassword);

  /// The [PlatoAuthenticator.created] method...
  PlatoAuthenticator.created() : super.created() {
    if (null == username) {
      username = '';
    }

    if (null == password) {
      password = '';
    }
  }

  /// The [handleUsernameChange] and [handlePasswordChange] methods are used as
  /// workarounds for currently-broken two-way data binding in paper elements.
  String handleUsernameChange() => username = ($['username'] as PaperInput).value;
  String handlePasswordChange() => password = ($['password'] as PaperInput).value;

  /// The [signalAuthentication] method is used to trigger an event for which the
  /// user is attempting to authenticate his or her Learn account.  It does not
  /// perform the actual authentication, nor communicate with the server.
  void signalAuthentication (Event e, var detail, Node target) {
    String toastText = '';

    if (0 == username.length || 0 == password.length) {
      toastText = "Both username and password are required to authenticate.";
    } else {
      toastText = "Attempting to authenticate into Plato...one moment, please.";

      this.fire (
        'plato-auth-attempted',
        detail: {'username': username, 'password': password}
      );
    }

    ($['authToast'] as PaperToast)
      ..text = toastText
      ..show();
  }

  /// The [clearAuthentication] method is used to clear the username/password fields.
  void clearAuthentication (Event e, var detail, Node target) {
    username = '';
    password = '';

    ($['authToast'] as PaperToast)
      ..text = "Username and password fields cleared."
      ..show();
  }
}
