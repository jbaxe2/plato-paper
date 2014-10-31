library plato.paper.chooser.terms;

import 'package:polymer/polymer.dart';

import 'plato-simple-chooser.dart';

/// A Polymer-based element, using paper elements, to display semester terms.
@CustomTag('plato-term-chooser')
class PlatoTermChooser extends PlatoSimpleChooser {
  /// The [PlatoTermChooser]'s [created] method sets the simple chooser's type
  /// to 'term', the signal to 'term-selected', and establishes an empty state
  /// for the select element.
  PlatoTermChooser.created() : super.created() {
    type = 'term';
    signal = 'term-selected';

    options['no-term'] = 'Select a term...';
  }

  /// The [addTerms] method is used to add a [Map] of [String] key/value pairs,
  /// whereby the keys represent the term ID's and the values represent the
  /// term titles.
  void addTerms (Map<String, String> someTerms) {
    options.addAll (someTerms);
  }
}
