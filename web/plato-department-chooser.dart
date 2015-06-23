library plato.paper.chooser.departments;

import 'dart:html';

import 'package:polymer/polymer.dart';

import 'plato-communicator.dart';
import 'plato-simple-chooser.dart';

/// A Polymer-based element, using paper elements, to display departments.
@CustomTag('plato-department-chooser')
class PlatoDepartmentChooser extends PolymerElement {
  /// The [PlatoSimpleChooser] that will be used for choosing departments.
  PlatoSimpleChooser _simpleChooser;

  /// The [PlatoCommunicator] used to retrieve the list of departments from
  /// the server.
  PlatoCommunicator _communicator;

  /// The [PlatoDepartmentChooser.created] method...
  PlatoDepartmentChooser.created() : super.created();

  /// The [ready] method retrieves the elements for [PlatoSimpleChooser] and
  /// [PlatoCommunicator] from the DOM, and initializes some setup.  The
  /// communicator requests the list of departments from the server.  Some
  /// event listeners for departments loading, failure, and selection are
  /// established.
  void ready() {
    super.ready();

    _simpleChooser = $['simple-chooser'] as PlatoSimpleChooser
      ..type = 'department'
      ..signal = 'department-selected'
      ..options['no-department'] = 'Please select a department...';

    _communicator = $['departments-communicator'] as PlatoCommunicator
      ..send();

    this.on['departments-loaded'].listen (departmentsLoaded);
    this.on['departments-failed'].listen (departmentsFailed);
    this.on['department-selected'].listen (departmentSelected);
  }

  /// The [addDepartment] method is used to add a [Map] of [String] key/value
  /// pair representing a department, for which the key corresponds to the ID
  /// and value corresponds to the title.
  void addDepartment (Map<String, String> someDepartments) {
    _simpleChooser.addOption (someDepartments);
  }

  /// The [departmentsLoaded] method is invoked once the departments list has
  /// been retrieved from the server.  The departments are then loaded into the
  /// DOM for the select options.
  void departmentsLoaded (CustomEvent event) {
    Map<String, List> departments = event.detail as Map;

    departments['departments'].forEach ((Map department) {
      _simpleChooser.addOption (
        {department['code']: department['description']}
      );
    });
  }

  /// The [departmentsFailed] method is invoked if communications with the server
  /// resulted in an error of some sort.
  void departmentsFailed (CustomEvent event) {
    _simpleChooser.options['no-department'] = 'Error loading departments.';
  }

  /// The [departmentSelected] method...
  void departmentSelected (CustomEvent event) {
    this.fire ('department-for-course', detail: event.detail, onNode: this.parent);
  }
}
