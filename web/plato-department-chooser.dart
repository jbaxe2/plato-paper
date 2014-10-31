library plato.paper.chooser.departments;

import 'package:polymer/polymer.dart';

import 'plato-simple-chooser.dart';

/// A Polymer-based element, using paper elements, to display departments.
@CustomTag('plato-department-chooser')
class PlatoDepartmentChooser extends PlatoSimpleChooser {
  /// The [PlatoDepartmentChooser.created] method sets the simple chooser's type
  /// to 'department', the signal to 'department-selected', and establishes an
  /// empty state for the select element.
  PlatoDepartmentChooser.created() : super.created() {
    type = 'department';
    signal = 'department-selected';

    options['no-department'] = 'Select a department...';
  }

  /// The [addDepartments] method is used to add a [Map] of [String] key/value
  /// pairs representing departments, for which the keys correspond to the ID's
  /// and values correspond to the titles.
  void addDepartments (Map<String, String> someDepartments) {
    options.addAll (someDepartments);
  }
}
