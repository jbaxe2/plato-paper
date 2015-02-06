library plato.paper.chooser;

import 'dart:html';

import 'package:polymer/polymer.dart';

import './lib/errors/plato_paper_errors.dart' show PlatoPaperEventException;

/// A Polymer-based element, using paper elements, to display semester terms.
@CustomTag('plato-simple-chooser')
class PlatoSimpleChooser extends PolymerElement {
  /// A [Map] of [String] key/value pairs effectively serving as the data model
  /// for this custom element, whereby the keys represent the ID's for the
  /// options and the values represent the descriptions.
  @observable ObservableMap<String, String> options;

  /// A [String] representing the type of chooser.
  @observable String type;

  /// A [String] to name the signal that should be triggered once an option has
  /// been selected; this should be provided via subclasses or explicitly
  /// through a setter.
  String _signal;

  /// The signal getter/setter.
  String get signal => _signal;
         set signal (String theSignal) => _signal = theSignal;

  /// The [PlatoSimpleChooser.created] method initializes the options model
  /// that will be used for this element's select element's options children.
  PlatoSimpleChooser.created() : super.created() {
    options = new ObservableMap<String, String>();
  }

  /// The [addOption] method is used to add a [Map] of [String] key/value
  /// pairs, whereby the keys represent the ID's of some option and the values
  /// represent the corresponding descriptions.
  void addOption (Map<String, String> someOption) {
    options.addAll (someOption);
  }

  /// The [triggerOptionSelected] method is invoked automatically once a user
  /// has selected an option, firing the event specified by a subclass's signal
  /// field.
  void triggerOptionSelected (Event event, var details, Element target) {
    if (null == _signal) {
      throw new PlatoPaperEventException (
        'Cannot trigger an event signal that has not been specified.'
      );
    }

    SelectElement optionsSelect = $['selectId'] as SelectElement;

    String selectedOptionsKey = options.keys.elementAt (optionsSelect.selectedIndex);
    String selectedOptionsValue = options.values.elementAt (optionsSelect.selectedIndex);

    if (0 < optionsSelect.selectedIndex) {
      this.fire (
        _signal,
        detail: {'key': selectedOptionsKey, 'value': selectedOptionsValue}
      );
    }
  }
}
