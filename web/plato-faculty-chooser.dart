library plato.paper.chooser.faculty;

import 'package:polymer/polymer.dart';

import 'plato-simple-chooser.dart';

/// A Polymer-based element, using paper elements, to display faculty members.
@CustomTag('plato-faculty-chooser')
class PlatoFacultyChooser extends PlatoSimpleChooser {
  /// The [PlatoTermChooser]'s [created] method sets the simple chooser's type
  /// to 'faculty', the signal to 'faculty-selected', and establishes an empty
  /// state for the select element.
  PlatoFacultyChooser.created() : super.created() {
    type = 'faculty';
    signal = 'faculty-selected';

    options['no-faculty'] = 'Select a faculty member...';
  }

  /// The [addFaculty] method is used to add a [Map] of [String] key/value pairs,
  /// whereby the keys represent the faculty ID's (A#) and the values represent
  /// the full names of the faculty members.
  void addFaculty (Map<String, String> someFaculty) {
    options.addAll (someFaculty);
  }
}
