library plato.paper.chooser;

import 'dart:html';

import 'package:polymer/polymer.dart';

import './lib/errors/plato_paper_errors.dart' show PlatoPaperEventException;

/// A Polymer-based element, using paper elements, to display semester terms.
@CustomTag('plato-simple-chooser')
class PlatoSimpleChooser extends PolymerElement {
  /// A [Map] of [String] key/value pairs serving the data model for this custom
  /// element, whereby the keys represent the ID's for the options and the values
  /// represent the descriptions.
  @observable Map<String, String> options;

  /// A [String] representing the type of chooser.
  @observable String type;

  /// A [String] to name the signal that should be triggered once an option has
  /// been selected; this should be provided via subclasses or explicitly
  /// through a setter.
  String signal;

  /// The [PlatoSimpleChooser]'s [created] method initializes the options model
  /// that will be used for this element's select element's options children.
  PlatoSimpleChooser.created() : super.created() {
    options = new Map<String, String>();
  }

  /// The [addOptions] method is used to add a [Map] of [String] key/value pairs,
  /// whereby the keys represent the ID's of some option and the values represent the
  /// corresponding descriptions.
  void addOptions (Map<String, String> someTerms) {
    options.addAll (someTerms);
  }

  /// The [triggerOptionSelected] method is invoked automatically once a user has
  /// selected a term, firing the event specified by a subclass's signal field.
  void triggerOptionSelected (Event event, var details, Element target) {
    if (null == signal) {
      throw new PlatoPaperEventException (
        'Cannot trigger an event signal that has not been specified.'
      );
    }

    SelectElement optionsSelect = $['selectId'];

    String selectedOptionsKey = options.keys.elementAt (optionsSelect.selectedIndex);
    String selectedOptionsValue = options.values.elementAt (optionsSelect.selectedIndex);

    if (0 < optionsSelect.selectedIndex) {
      this.fire (
        signal,
        detail: {'key': selectedOptionsKey, 'value': selectedOptionsValue}
      );
    }
  }
}
