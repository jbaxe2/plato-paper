library plato.paper.previous_content;

import 'package:polymer/polymer.dart';

import './lib/utils/plato_paper_utils.dart';
import './lib/errors/plato_paper_errors.dart' show PreviousContentException;

/// The [PlatoPreviousContent] class is a Polymer based element.
@CustomTag('plato-previous-content')
class PlatoPreviousContent extends PolymerElement {
  @observable String requestableId = '';
  @observable String previousId = '';

  /// A [Requestable] instance serving as the data model for the requestable
  /// item previous content will be copied/imported into.
  Requestable _requested;

  /// A [PreviousContentable] instance serving as the data model for the previous
  /// content to be copied into this class's [Requestable] instance.  The [Requestable]
  /// instance of this class must match (equality, not identity) the [Requestable]
  /// instance of the [PreviousContentable] instance.
  PreviousContentable _previous;

  /// The [PlatoPreviousContent.created] method...
  PlatoPreviousContent.created() : super.created() {}

  /// The requested setter is used to set the [Requestable] instance of this custom
  /// element, provided that if the [PreviousContentable] instance has already been
  /// set, its [Requestable] instance must match or a [PreviousContentException]
  /// instance will be thrown.
  set requested (Requestable aRequestable) {
    if (null == _previous) {
      _requested = aRequestable;
    } else {
      if (_previous.requested != aRequestable) {
        throw new PreviousContentException (
          'Cannot add a requestable that conflicts with the previous content requestable.'
        );
      }
    }
  }

  /// The previous setter is used to set the [PreviousContentable] instance.
  /// If the [Requestable] instance has not yet been set, this will be as well.
  /// Should it not be null, then it must match the [Requestable] instance of the
  /// argument.  Otherwise a [PreviousContentException] instance will be thrown.
  set previous (PreviousContentable aPreviousContentable) {
    if (null == _requested) {
      _previous = aPreviousContentable;
      _requested = aPreviousContentable.requested;
    } else {
      if (_requested != aPreviousContentable.requested) {
        throw new PreviousContentException (
          'Cannot add a previous content that conflicts with the requested section.'
        );
      }
    }
  }

  /// The requested and previous getters are used to retrieve the [Requestable]
  /// and [PreviousContentable] instances.
  Requestable get requested => _requested;
  PreviousContentable get previous => _previous;
}
