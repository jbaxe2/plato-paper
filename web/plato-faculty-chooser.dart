library plato.paper.chooser.faculty;

import 'dart:html';

import 'package:polymer/polymer.dart';

import 'plato-communicator.dart';
import 'plato-simple-chooser.dart';

/// A Polymer-based element, using paper elements, to display faculty members.
@CustomTag('plato-faculty-chooser')
class PlatoFacultyChooser extends PolymerElement {
  /// The [PlatoSimpleChooser] that will be used for choosing faculty.
  PlatoSimpleChooser _simpleChooser;

  /// The [PlatoCommunicator] used to retrieve the faculty from the server.
  PlatoCommunicator _communicator;

  /// The [PlatoFacultyChooser.created] method...
  PlatoFacultyChooser.created() : super.created();

  /// The [ready] method...
  void ready() {
    _simpleChooser = $['simple-chooser'] as PlatoSimpleChooser
      ..type = 'faculty'
      ..signal = 'faculty-selected'
      ..options['no-faculty'] = 'Select a faculty member...';

    _communicator = $['faculty-communicator'] as PlatoCommunicator;

    this.on['faculty-loaded'].listen (facultyLoaded);
    this.on['faculty-failed'].listen (facultyFailed);
    this.on['faculty-selected'].listen (facultySelected);
  }

  /// The [addFaculty] method is used to add a [Map] of [String] key/value pair,
  /// whereby the key represents the faculty ID (A#) and the value represents
  /// the full name of the faculty member.
  void addFaculty (Map<String, String> someFaculty) {
    _simpleChooser.options.addAll (someFaculty);
  }

  /// The [facultyLoaded] method...
  void facultyLoaded (CustomEvent event) {
    ;
  }

  /// The [facultyFailed] method...
  void facultyFailed (CustomEvent event) {
    _simpleChooser.options['no-faculty'] = 'Error loading faculty members.';
  }

  /// The [facultySelected] method...
  void facultySelected (CustomEvent event) {
    ;
  }
}
