library plato.paper.communicator;

import 'dart:convert';
import 'dart:html';

import 'package:polymer/polymer.dart';

import 'package:core_elements/core_ajax_dart.dart';

import './lib/errors/plato_paper_errors.dart' show CommunicationsException;

/// A Polymer-based element, using paper elements, to handle server communications.
@CustomTag('plato-communicator')
class PlatoCommunicator extends PolymerElement {
  /// A [String] representing the URL for the service or resource endpoint.
  @published
  String get url => readValue (#url);
         set url (String theUrl) => writeValue (#url, theUrl);

  /// A [String] representing the event name to fire when a successful response
  /// from the server has been received.
  @published
  String get successSignal => readValue (#successSignal);
         set successSignal (String theSuccessSignal) =>
           writeValue (#successSignal, theSuccessSignal);

  /// A [String] representing the event name to fire when an error response from
  /// the server has been recieved, or communications with the server failed.
  @published
  String get errorSignal => readValue (#errorSignal);
         set errorSignal (String theErrorSignal) =>
           writeValue (#errorSignal, theErrorSignal);

  /// A [String] representing the HTTP method to use in server communications;
  /// currently only 'GET' and 'POST' will be supported.
  @observable String method;

  /// A JSON-encoded [String] possessing the possible parameters to send during
  /// some Ajax call to the server.
  @observable String params;

  /// A JSON-encoded [String] possessing the possible body to send via POST during
  /// some Ajax call to the server.
  @observable String body;

  /// A [Map] of key/value pairs to be used as parameters for an Ajax call, which
  /// will become JSON-encoded at the time the call is sent.
  Map<String, dynamic> _params;

  /// The [CoreAjax] custom element used for Ajax calls to the server.
  CoreAjax platoAjax;

  /// The underlying raw [HttpRequest] object used for Ajax communications.
  HttpRequest _rawXhr;

  /// The [PlatoCommunicator.created] method...
  PlatoCommunicator.created() : super.created() {
    method = 'GET';
    _params = new Map<String, dynamic>();
  }

  /// The [ready] method overrides Polymer's method, since receiving the CoreAjax
  /// instance for this element will not be available when the element is created.
  void ready() {
    super.ready();

    platoAjax = $['ajax'] as CoreAjax;
  }

  /// The [setUrl] method may be used to set the URL of the server-based service
  /// or resource, although typically this should be set via the element's attribute.
  void setUrl (String aUrl) {
    url = Uri.parse (aUrl).toString();
  }

  /// The [setSignals] method may be used to set the success and error signals
  /// that will be used to trigger events after receiving the Ajax response.
  void setSignals (String success, String error) {
    successSignal = success;
    errorSignal = error;
  }

  /// The [addParams] method is used to set the parameters of the Ajax call, if
  /// any are to be used.  The parameters are passed as a map argument whereby
  /// the keys will be strings, and the values will be some JSON-encodable type.
  /// If the values are not JSON-encodable, a [CommunicationsException] will be
  /// thrown.
  void addParams (Map<String, dynamic> someParams) {
    if (0 == someParams.length) {
      throw new CommunicationsException (
        'Cannot add an empty map for use as the Ajax parameters.'
      );
    }

    // Verify the values passed for parameters are JSON-encodable.
    try {
      someParams.values.every (
        (var someValue) {
          JSON.encode (someValue);
          return true;
        }
      );
    } catch (e) {
      throw new CommunicationsException (
        'Values used for parameters sent to the server must be JSON-encodable.'
      );
    }

    _params.addAll (someParams);
  }

  /// The [send] method is used to send the Ajax request to the server.  An optional
  /// HTTP method may be passed, which defaults to 'GET' (currently only supports
  /// 'GET' and 'POST' methods).  If there are parameters to be sent, but which are
  /// not JSON-encodable, a [CommunicationsException] instance will be thrown.
  void send ([String theMethod='GET']) {
    if (0 < _params.length) {
      try {
        String jsonParams = JSON.encode (_params);

        if ((0 < theMethod.length) && ('POST' == theMethod.toUpperCase())) {
          method = 'POST';
          body = jsonParams;
        } else {
          params = jsonParams;
        }
      } catch (e) {
        throw new CommunicationsException (
          'Unable to encode the Ajax params as JSON data.'
        );
      }
    }

    _rawXhr = platoAjax.go();
  }

  /// The [handleResponse] method is automatically invoked when a response from
  /// the server has been received.  A custom event is fired depending on the
  /// success and error signals provided, passing along the response.
  void handleResponse() {
    String signalWhich =
      (platoAjax.isSuccess (_rawXhr)) ? successSignal : errorSignal;

    this.fire (signalWhich, detail: platoAjax.response);
  }
}
