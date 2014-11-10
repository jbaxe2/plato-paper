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
  /// The term ID for the courses and sections.
  @observable String term;

  /// The department ID for the courses and sections.
  @observable String department;

  /// The 'plato-department-chooser' element for choosing the department.
  PlatoDepartmentChooser _departments;

  /// The 'plato-term-chooser' element for choosing the term.
  PlatoTermChooser _terms;

  /// The 'plato-course-chooser' element for choosing the course.
  PlatoCourseChooser _courses;

  /// The 'plato-sections-chooser' element for choosing sections.
  PlatoSectionsChooser _sections;

  /// The [PlatoSectionsChooserModule.created] constructor...
  PlatoSectionsChooserModule.created() : super.created();

  /// The [ready] method...
  void ready() {
    super.ready();

    _departments = $['department-chooser'] as PlatoDepartmentChooser;
    _terms = $['term-chooser'] as PlatoTermChooser;
    _courses = $['course-chooser'] as PlatoCourseChooser;
    _sections = $['sections-chooser'] as PlatoSectionsChooser;

    this.on['term-for-course'].listen ((CustomEvent event) {
      _courses.term = event.detail['key'];
    });

    this.on['department-for-course'].listen ((CustomEvent event) {
      _courses.department = event.detail['key'];
    });

    this.on['course-for-sections'].listen ((CustomEvent event) {
      _sections.loadSections (event.detail['term'], event.detail['course']);
    });

    this.on['sections-selected'].listen ((CustomEvent event) {
      sectionsSelected (event.detail['sections']);
    });
  }

  /// The [sectionsSelected] method...
  void sectionsSelected (List<String> sections) {}
}
