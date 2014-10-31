library plato.paper.chooser.sections;

import 'dart:html';

import 'package:polymer/polymer.dart';

import 'package:paper_elements/paper_checkbox.dart';

/// A Polymer-based element, using paper elements, to display sections.
@CustomTag('plato-sections-chooser')
class PlatoSectionsChooser extends PolymerElement {
  /// A [Map] of [String] key/value pairs serving as the data model for this custom
  /// element, for which the keys represent section ID's and the values represent
  /// section titles.
  @observable Map<String, String> sections;

  /// A [List] of [PaperCheckbox] instances used by the user to specify which sections
  /// should be selected as part of a dynamic listing.
  List<PaperCheckbox> _sectionsSelected;

  PlatoSectionsChooser.created() : super.created() {
    sections = new Map<String, String>();

    _sectionsSelected = new List<PaperCheckbox>();
  }

  /// The [addSections] method is used to add a [Map] of [String] key/value pairs,
  /// for which the keys represent section ID's and the values represent section
  /// titles.
  void addSections (Map<String, String> someSections) {
    sections.addAll (someSections);
  }

  /// The [toggleSectionSelected] method is used to either add to (checked) or remove
  /// from (unchecked) the list of those selected, the corresponding section.
  void toggleSectionSelected (Event event, var details, PaperCheckbox target) {
    if (_sectionsSelected.contains (target) && !target.checked) {
      _sectionsSelected.remove (target);
    }

    if (!_sectionsSelected.contains (target) && target.checked) {
      _sectionsSelected.add (target);
    }
  }

  /// The [signalSectionsSelected] method is invoked automatically when a user
  /// clicks the button that the appropriate sections have been selected, which
  /// fires the 'sections-selected' event.
  void signalSectionsSelected (Event event, var details, Element target) {
    if (0 < _sectionsSelected.length) {
      this.fire ('sections-selected', detail: {'sections': _sectionsSelected});
    }
  }
}
