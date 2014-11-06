library plato.paper.chooser.terms;

import 'dart:html';

import 'package:polymer/polymer.dart';

import 'plato-communicator.dart';
import 'plato-simple-chooser.dart';

/// A Polymer-based element, using paper elements, to display semester terms.
@CustomTag('plato-term-chooser')
class PlatoTermChooser extends PolymerElement {
  /// The [PlatoSimpleChooser] that will be used for choosing terms.
  PlatoSimpleChooser _simpleChooser;

  /// The [PlatoCommunicator] used to retrieve the terms from the server.
  PlatoCommunicator _communicator;

  /// The [PlatoTermChooser.created] method...
  PlatoTermChooser.created() : super.created();

  /// The [ready] method...
  void ready() {
    super.ready();

    _simpleChooser = $['simple-chooser'] as PlatoSimpleChooser
      ..type = 'term'
      ..signal = 'term-selected'
      ..options['no-term'] = 'Please select a term...';

    _communicator = $['terms-communicator'] as PlatoCommunicator
      ..send();

    this.on['terms-loaded'].listen (termsLoaded);
    this.on['terms-failed'].listen (termsFailed);
    this.on['term-selected'].listen (termSelected);
  }

  /// The [addTerm] method is used to add a [Map] of [String] key/value pairs,
  /// whereby the key represents the term ID and the value represents the term
  /// title.
  void addTerm (Map<String, String> someTerms) {
    _simpleChooser.options.addAll (someTerms);
  }

  /// The [termsLoaded] method...
  void termsLoaded (CustomEvent event) {
    Map<String, List> terms = event.detail as Map;

    terms['terms'].forEach ((Map term) {
      _simpleChooser.addOption (
        {term['code']: term['description']}
      );
    });
  }

  /// The [termsFailed] method...
  void termsFailed (CustomEvent event) {
    _simpleChooser.options['no-term'] = 'Error loading departments.';
  }

  /// The [termSelected] method...
  void termSelected (CustomEvent event) {
    this.fire ('term-for-course', detail: event.detail, onNode: this.parent);
  }
}
