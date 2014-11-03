part of plato.paper.utils;

class Section extends Requestable {
  String _section;
  String _number;
  String _department;
  String _instructor;
  String _time;
  String _term;

  /// The [Section] constructor uses named parameters for implementing the data
  /// structure's fields, and sets the requestable ID as the section ID.
  Section (
    {
      String section, String number, String title,
      String department, String instructor,
      String time, String term
    }
  ) {
    this
      .._section = section
      .._number = number
      .._title = title
      .._department = department
      .._instructor = instructor
      .._time = time
      .._term = term;

    this._id = this._section;
  }

  /// The getters for the [Section] fields.
  String get section => _section;
  String get number => _number;
  String get title => _title;
  String get department => _department;
  String get instructor => _instructor;
  String get time => _time;
  String get term => _term;

  /// The [isDay] method is used to determine if the course section this class
  /// represents is part of the Day Division (true) or DGCE (false). If it is
  /// indeterminable which division the course belongs, an instance of
  /// [RequestableException] will be thrown.
  bool isDay() {
    String digitStr = _section.substring (_section.length - 3, _section.length - 2);

    // Dual enrollment, and DGCE sections for Day division cross-registration.
    if (('R' == digitStr) || ('E' == digitStr)) {
      return false;
    }

    // Day division honors courses, and whatever a 'P' section refers to.
    if (('H' == digitStr) || ('P' == digitStr)) {
      return true;
    }

    try {
      return (5 == int.parse (digitStr)) ? false : true;
    } catch (e) {}

    throw new RequestableException (
      'Unable to determine if course is part of the Day division '
      '(unknown identifier: $digitStr).'
    );
  }

  /// The [toJson] method returns an [Object] representation containing the
  /// information of the course section for an instance of this class.
  Object toJson() {
    return {
      'section': _section,
      'number': _number,
      'title': _title,
      'department': _department,
      'instructor': _instructor,
      'time': _time,
      'term': _term
    };
  }
}
