library plato.paper.modules.departments;

import 'dart:html';

import 'package:polymer/polymer.dart';

import 'plato-communicator.dart';
import 'plato-department-chooser.dart';

/// A Polymer-based element, using paper elements, to load via an Ajax call and
/// display departments.
@CustomTag('plato-departments-module')
class PlatoDepartmentsModule extends PolymerElement {
  /// The [PlatoDepartmentChooser] instance...
  PlatoDepartmentChooser _departmentChooser;

  /// The [PlatoCommunicator] instance for server communications.
  PlatoCommunicator _communicator;

  /// The [PlatoDepartmentsModule.created] constructor...
  PlatoDepartmentsModule.created() : super.created();

  /// The [ready] method...
  void ready() {
    super.ready();

    _departmentChooser = $['department-chooser'] as PlatoDepartmentChooser;

    _communicator = $['departments-communicator'] as PlatoCommunicator;
    _communicator.send();

    this.on['departments-loaded'].listen (departmentsLoaded);
    this.on['departments-failed'].listen (departmentsFailed);
  }

  /// The [departmentsLoaded] method...
  void departmentsLoaded (CustomEvent event) {
    Map<String, List> departments = event.detail as Map;

    departments['departments'].forEach ((Map department) {
      _departmentChooser.addDepartments (
        {department['code']: department['description']}
      );
    });
  }

  /// The [departmentsFailed] method...
  void departmentsFailed (CustomEvent event) {
    print ('got here, but departments load failed...');
  }

  /// The [addDepartments] method is used to add a [Map] of [String] key/value
  /// pairs representing departments, for which the keys correspond to the ID's
  /// and values correspond to the titles.
  void addDepartments (Map<String, String> someDepartments) {
    _departmentChooser.addDepartments (someDepartments);
  }
}
