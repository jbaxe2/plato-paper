part of plato.paper.utils;

class CrossListing {
  /// A [List] of [Section] instances belonging to this cross-listing set.
  List<Section> _sections;

  /// Due to the policies surrounding which sections may be cross-listed, care
  /// is taken to ensure how sections are able to be added to the cross-listing
  /// set; as such, a getter for the [List] of [Section]s is used, but no
  /// corresponding setter.
  List<Section> get sections => _sections;

  /// The [CrossListing] constructor...
  CrossListing() {
    _sections = new List<Section>();
  }

  /// The [addSection] method is used to add a [Section] instance to the list
  /// of cross-listings.  If the list already contains the [Section] or if the
  /// [Section] is not cross-listable with the other sections in the list, an
  /// instance of [CrossListingException] will be thrown.
  void addSection (Section aSection) {
    if (_sections.contains (aSection)) {
      throw new CrossListingException (
        'Cannot add the same section a second time to a cross-listing set.'
      );
    }

    if (!verifyCrossListableWith (aSection)) {
      throw new CrossListingException (
        'Condition constraint in adding ${aSection._section} to the cross-listing.'
      );
    }

    _sections.add (aSection);
  }

  /// The [removeSection] method is used to remove an instance of [Section]
  /// from the cross-listing set.  If the [Section] is not part of the set,
  /// then a [CrossListingException] instance will be thrown.
  void removeSection (Section aSection) {
    if (!_sections.contains (aSection)) {
      throw new CrossListingException (
        'Cannot remove a section from a cross-listing that is not part of it.'
      );
    }

    _sections.remove (aSection);
  }

  /// The [verifyCrossListableWith] method is used to determine if a provided
  /// [Section] instance can be added to the cross-listing set; if so, returns
  /// true, and returns false otherwise.
  bool verifyCrossListableWith (Section aSection) {
    if (0 == _sections.length) {
      return true;
    }

    try {
      if (_sections.first.isDay()) {
        return (aSection.isDay()) ? true : false;
      } else {
        return (aSection.isDay()) ? false : true;
      }
    } catch (e) {
      // Cannot determine if course is cross-listable, so deny it.
      return false;
    }

    return false;
  }

  /// The [toJson] method outputs a JSON-based [Object] representation of the
  /// course sections contained within the cross-listing set some instance of
  /// this class is reflective of.
  Object toJson() {
    return {
      'sections': _sections
    };
  }
}
