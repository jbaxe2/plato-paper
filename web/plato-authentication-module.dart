library plato.paper.modules.authentication;

import 'dart:html';

import 'package:polymer/polymer.dart';

import 'plato-communicator.dart';

/// A Polymer-based element, using paper elements, to display section info for
/// those which are to be created within Plato.
@CustomTag('plato-authentication-module')
class PlatoAuthenticationModule extends PolymerElement {
  /// A [String] representing the URL endpoint for the authentication service.
  @published
  String get url => readValue (#url);
         set url (String aUrl) => writeValue (#url, aUrl);

  /// The [PlatoCommunicator] instance which will be used to communicate with the
  /// server for handling authentication against Plato.
  PlatoCommunicator _platoCommunicator;

  /// The [PlatoAuthenticationModule]'s [created] method...
  PlatoAuthenticationModule.created() : super.created() {
    _platoCommunicator = $['plato-auth-comm'] as PlatoCommunicator;

    // Listen for a Plato authentication attempt.
    this.on['plato-auth-attempted'].listen (handleAuthentication);

    // Listen for the response after signaling a Plato authentication attempt.
    this.on['plato-auth-success'].listen (handleAuthSuccess);
    this.on['plato-auth-error'].listen (handleAuthError);
  }

  /// The [handleAuthentication] method...
  void handleAuthentication (CustomEvent event) {
    _platoCommunicator
      ..addParams (event.detail)
      ..send ('POST');
  }

  /// The [handleAuthSuccess] method...
  void handleAuthSuccess (CustomEvent event) {
    print (event.detail);
  }

  /// The [handleAuthError] method...
  void handleAuthError (CustomEvent event) {
    print (event.detail);
  }
}
