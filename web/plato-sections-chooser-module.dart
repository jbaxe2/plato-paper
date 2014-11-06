library plato.paper.modules.chooser.sections;

import 'dart:html';

import 'package:polymer/polymer.dart';

import 'plato-course-chooser.dart';
import 'plato-department-chooser.dart';
import 'plato-sections-chooser.dart';
import 'plato-term-chooser.dart';

/// A Polymer-based element, using paper elements, to display departments.
@CustomTag('plato-sections-chooser-module')
class PlatoSectionsChooserModule extends PolymerElement {
  @observable String term;
  @observable String department;

  PlatoDepartmentChooser _departments;

  PlatoTermChooser _terms;

  PlatoCourseChooser _courses;

  PlatoSectionsChooser _sections;

  PlatoSectionsChooserModule.created() : super.created();

  /// The [ready] method...
  void ready() {
    super.ready();

    _departments = $['department-chooser'] as PlatoDepartmentChooser;
    _terms = $['term-chooser'] as PlatoTermChooser;
    _courses = $['course-chooser'] as PlatoCourseChooser;
    _sections = $['sections-chooser'] as PlatoSectionsChooser;

    this.on['term-for-course'].listen ((CustomEvent event) {
      print ('term for course ${event.detail}');
      _courses.term = event.detail['key'];
    });

    this.on['department-for-course'].listen ((CustomEvent event) {
      print ('department for course ${event.detail}');
      _courses.department = event.detail['key'];
    });
  }

  /// The [sectionsLoaded] method...
  void sectionsLoaded (CustomEvent event) {}
}
