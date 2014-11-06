library plato.paper.chooser.courses;

import 'dart:html';

import 'package:polymer/polymer.dart';

import 'plato-communicator.dart';
import 'plato-simple-chooser.dart';

import './lib/errors/plato_paper_errors.dart' show PlatoPaperEventException;

/// A Polymer-based element, using paper elements, to display courses.
@CustomTag('plato-course-chooser')
class PlatoCourseChooser extends PolymerElement {
  /// The term ID this course is associated with.
  @published
  String get term => readValue (#term);
         set term (String theTerm) => writeValue (#term, theTerm);

  /// The department ID this course is associated with.
  @published
  String get department => readValue (#department);
         set department (String theDepartment) =>
           writeValue (#department, theDepartment);

  /// The [PlatoSimpleChooser] that will be used for choosing terms.
  PlatoSimpleChooser _simpleChooser;

  /// The [PlatoCommunicator] used to retrieve the list of departments from
  /// the server.
  PlatoCommunicator _communicator;

  /// The [PlatoTermChooser.created] method...
  PlatoCourseChooser.created() : super.created() {
    term = 'no-term';
    department = 'no-department';
  }

  /// The [ready] method...
  void ready() {
    super.ready();

    _simpleChooser = $['simple-chooser'] as PlatoSimpleChooser
      ..type = 'course'
      ..signal = 'course-selected'
      ..options['no-course'] = 'Please select a term and department first.';

    _communicator = $['courses-communicator'] as PlatoCommunicator;

    this.on['courses-loaded'].listen (coursesLoaded);
    this.on['courses-failed'].listen (coursesFailed);
    this.on['course-selected'].listen (courseSelected);
  }

  /// The [termChanged] method...
  void termChanged (String oldTerm) {
    if ('no-department' == department) {
      return;  // Not an error if the department has not yet been selected.
    }

    try {
      _loadCourses();
    } catch (_) {}
  }

  /// The [departmentChanged] method...
  void departmentChanged (String oldDepartment) {
    if ('no-term' == term) {
      return;  // Not an error if the term has not yet been selected.
    }

    try {
      _loadCourses();
    } catch (_) {}
  }

  /// The [_loadCourses] method...
  void _loadCourses() {
    print ('got here to _loadCourses with $term and $department');

    if (('no-term' == term) || ('no-department' == department)) {
      throw new PlatoPaperEventException (
        'Cannot retrieve a list of courses missing the department or term.'
      );
    }

    _communicator
      ..url += '?term=$term&dept=$department'
      ..send();
  }

  /// The [coursesLoaded] method...
  void coursesLoaded (CustomEvent event) {
    print ('got here to coursesLoaded with ${event.detail}');

    Map<String, List> courses = event.detail as Map;

    courses['courses'].forEach ((Map course) {
      _simpleChooser.addOption (
        {course['id']: course['title']}
      );
    });
  }

  /// The [coursesFailed] method...
  void coursesFailed (CustomEvent event) {
    _simpleChooser.options['no-course'] = 'Error loading courses.';
  }

  /// The [courseSelected] method...
  void courseSelected (CustomEvent event) {
    print ('got to course selected with ${event.detail}');
  }

  /// The [addCourses] method is used to add a [Map] of key/value [String]s,
  /// for which the key represents the course ID and the value represents
  /// the associating course titles.
  void addCourses (Map<String, String> someCourses) {
    _simpleChooser.options.addAll (someCourses);
  }
}
