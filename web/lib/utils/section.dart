part of plato.paper.utils;

class Section extends Requestable {
  String section;
  String number;
  String department;
  String instructor;
  String time;
  String term;

  /**
   * The [Section] constructor uses named parameters for implementing the data
   * structure's fields, and sets the requestable ID as the section ID.
   */
  Section (
    {
      String section, String number, String title,
      String department, String instructor,
      String time, String term
    }
  ) {
    this
      ..section = section
      ..number = number
      ..title = title
      ..department = department
      ..instructor = instructor
      ..time = time
      ..term = term;

    this.id = this.section;
  }

  /**
   * The [isDay] method is used to determine if the course section this class
   * represents is part of the Day Division (true) or DGCE (false). If it is
   * indeterminable which division the course belongs, a [RequestableException]
   * instance will be thrown.
   */
  bool isDay() {
    String digitStr = section.substring (section.length - 3, section.length - 2);

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

  /**
   * The [toJson] method returns a JSON-based [String] representation containing
   * the information of the course section for an instance of this class.
   */
  String toJson() {
    Map sectionJson = new Map()
      ..['section'] = section
      ..['number'] = number
      ..['title'] = title
      ..['department'] = department
      ..['instructor'] = instructor
      ..['time'] = time
      ..['term'] = term;

    return JSON.encode (sectionJson);
  }
}
