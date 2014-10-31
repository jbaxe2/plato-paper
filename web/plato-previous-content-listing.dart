library plato.paper.previous_content;

import 'dart:html';

import 'package:polymer/polymer.dart';

import './lib/utils/plato_paper_utils.dart' show PreviousContentable;
import './lib/errors/plato_paper_errors.dart' show PreviousContentException;

/// The [PlatoPreviousContentListing] class is a Polymer based element.
@CustomTag('plato-previous-content-listing')
class PlatoPreviousContentListing extends PolymerElement {
  /// A [Symbol] representing either the Learn or Vista LMS; all
  /// [PreviousContentable] instances of this custom element must share the
  /// same system.
  @observable Symbol system;

  /// A [List] of [PreviousContentable] instances serving as this custom element's
  /// data model.
  @observable List<PreviousContentable> previousContentables;

  PlatoPreviousContentListing.created() : super.created() {}

  /// The [setPreviousContentables] method is used to add a list of [PreviousContentable]
  /// instances, of which all must be of the same system (Learn or Vista).  If
  /// not every instance is of the same system, or if it differs from the potentially
  /// already established system, a [PreviousContentException] will be thrown.
  void setPreviousContentables (List<PreviousContentable> somePreviousContentables) {
    if (0 == somePreviousContentables.length) {
      throw new PreviousContentException (
        'Cannot add an emptpy list of previous content sections.'
      );
    }

    Symbol firstSystem = somePreviousContentables.first.system;

    if (!somePreviousContentables.every (
      (PreviousContentable previousContentable) =>
        (previousContentable.system == firstSystem) ? true : false
    )) {
      throw new PreviousContentException (
        'Cannot add a list of previous content for differing systems.'
      );
    }

    if ((null != system) && (firstSystem != system)) {
      throw new PreviousContentException (
        'Cannot add a list of previous content for differing systems.'
      );
    }

    if (null == system) {
      system = firstSystem;
    }

    previousContentables.addAll (somePreviousContentables);
  }

  /// The [addPreviousContentable] method is used to add a single instance of
  /// established system, a [PreviousContentException] will be thrown.
  void addPreviousContentable (PreviousContentable aPreviousContentable) {
    if ((system != aPreviousContentable.system) ||
        (aPreviousContentable.system != previousContentables.first.system)) {
      throw new PreviousContentException (
        'Cannot add previous content item with a different system than the current list.'
      );
    }

    if (previousContentables.contains (aPreviousContentable)) {
      throw new PreviousContentException (
        'Cannot add a previous content item a second time.'
      );
    }

    previousContentables.add (aPreviousContentable);

    if (null == system) {
      system = aPreviousContentable.system;
    }
  }

  /// The [removePreviousContentable] method is used to remove a single instance
  /// of [PreviousContentable] from the custom element's data model.
  void removePreviousContentable (PreviousContentable aPreviousContentable) {
    if (!previousContentables.contains (aPreviousContentable)) {
      throw new PreviousContentException (
        'Cannot remove a previous content item that has not been added.'
      );
    }

    previousContentables.remove (aPreviousContentable);
  }

  /// The [handlePreviousContentable] method...
  void handlePreviousContentable (Event event, var detail, Element target) {}
}
