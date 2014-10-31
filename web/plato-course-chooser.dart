library plato.paper.chooser.courses;

import 'package:polymer/polymer.dart';

import 'plato-simple-chooser.dart';

/// A Polymer-based element, using paper elements, to display courses.
@CustomTag('plato-course-chooser')
class PlatoCourseChooser extends PlatoSimpleChooser {
  /// The [PlatoTermChooser]'s [created] method sets the simple chooser's type
  /// to 'course', the signal to 'course-selected', and establishes an empty state
  /// for the select element.
  PlatoCourseChooser.created() : super.created() {
    type = 'course';
    signal = 'course-selected';

    options['no-course'] = 'Select a course...';
  }

  /// The [addCourses] method is used to add a [Map] of key/value [String]s, for
  /// which the keys represent the course ID's and the values represent the
  /// associating course titles.
  void addCourses (Map<String, String> someCourses) {
    options.addAll (someCourses);
  }
}
