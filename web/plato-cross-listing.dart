library plato.paper.cross_listing;

import 'package:polymer/polymer.dart';

import './lib/utils/plato_paper_utils.dart' show CrossListing, Section;

/// A Polymer-based element, using paper elements, to display error messages.
@CustomTag('plato-cross-listing')
class PlatoCrossListing extends PolymerElement {
  /// A [CrossListing] instance serving as the data model for this custom element.
  @observable CrossListing crossListing;

  PlatoCrossListing.created() : super.created() {
    crossListing = new CrossListing();
  }

  /// The [setCrossListingInElement] method is used to set the [CrossListing]
  /// instance used in this custom element.
  void setCrossListingInElement (CrossListing aCrossListing) {
    crossListing = aCrossListing;
  }

  /// The [addSectionToCrossListing] method may be used to add a [Section] instance
  /// to the [CrossListing] instance.
  void addSectionToCrossListing (Section aSection) {
    try {
      crossListing.addSection (aSection);
    } catch (e) { throw e; }
  }
}
