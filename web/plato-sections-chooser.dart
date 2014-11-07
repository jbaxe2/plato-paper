library plato.paper.chooser.sections;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_checkbox.dart';

import 'plato-communicator.dart';

/// A Polymer-based element, using paper elements, to display sections.
@CustomTag('plato-sections-chooser')
class PlatoSectionsChooser extends PolymerElement {
  /// A [Map] of [String] key/value pairs serving as the data model for this
  /// custom element, for which the keys represent section ID's and the values
  /// represent section titles.
  @observable Map<String, String> sections;

  /// A [Map] of [String] and [PaperCheckbox] instances used by the user to
  /// specify which sections should be selected as part of a dynamic listing.
  Map<String, PaperCheckbox> _sectionsSelected;

  /// The [PlatoCommunicator] instance retrieves the list of available sections.
  PlatoCommunicator _communicator;

  PlatoSectionsChooser.created() : super.created() {
    sections = toObservable (new Map<String, String>());

    _sectionsSelected = new Map<String, PaperCheckbox>();
  }

  /// The [ready] method...
  void ready() {
    super.ready();

    this.on['sections-loaded'].listen (sectionsLoaded);
    this.on['sectiosn-failed'].listen (sectionsFailed);
  }

  /// The [addSection] method is used to add a [Map] of [String] key/value
  /// pair, for which the key represents section ID and the value represents
  /// the section title.
  void addSection (Map<String, String> someSections) {
    sections.addAll (someSections);
  }

  /// The [loadSections] method...
  void loadSections (String term, String course) {
    _communicator = $['sections-communicator'] as PlatoCommunicator
      ..addParams ({'term': term, 'course': course})
      ..send();
  }

  /// The [sectionsLoaded] method...
  void sectionsLoaded (CustomEvent event) {
    event.detail['sections'].forEach ((Map<String, String> sectionInfo) {
      addSection ({sectionInfo['id']: sectionInfo['title']});
    });
  }

  /// The [sectionsFailed] method...
  void sectionsFailed (CustomEvent event) {
    print ('Sections load failed:  ${event.detail}');
  }

  /// The [toggleSectionSelected] method is used to either add to (checked) or remove
  /// from (unchecked) the list of those selected, the corresponding section.
  void toggleSectionSelected (Event event, Object details, PaperCheckbox target) {
    String courseId = target.id.split ('_').first;

    if (_sectionsSelected.containsValue (target) && !target.checked) {
      _sectionsSelected.remove (courseId);
    }

    if (!_sectionsSelected.containsValue (target) && target.checked) {
      _sectionsSelected.addAll ({courseId: target});
    }
  }

  /// The [signalSectionsSelected] method is invoked automatically when a user
  /// clicks the button that the appropriate sections have been selected, which
  /// fires the 'sections-selected' event.
  void signalSectionsSelected (Event event, Object details, Element target) {
    if (0 < _sectionsSelected.length) {
      print (_sectionsSelected.keys);

      this.fire (
        'sections-selected',
        detail: {'sections': _sectionsSelected.keys},
        onNode: this.parent
      );
    }
  }
}
