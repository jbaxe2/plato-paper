library plato.paper.error;

import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_dialog.dart';

import './lib/errors/plato_paper_errors.dart';

/// A Polymer-based element, using paper elements, to display error messages.
@CustomTag('plato-error')
class PlatoError extends PolymerElement {
  @observable String title;
  @observable String message;

  PlatoError.created() : super.created();

  /// The [setError] method is used to set the title of the error along with its
  /// associated exception, forwhich the exception is a subclass of the
  /// [PlatoPaperException] class.  A Boolean value may be passed in, which defaults
  /// to true, specifying whether the error dialog should be displayed.
  void setError (String title, PlatoPaperException error, [bool display = true]) {
    if (1 > title.length) {
      title = 'Unknown Error';
    }

    this.title = title;
    this.message = error.toString();

    displayError (display);
  }

  /// The [displayError] method...
  void displayError ([bool display = true]) {
    PaperDialog errorDialog = $['error-dialog'] as PaperDialog;

    // If the error dialog isn't opened, but display is true, show the dialog.
    if (display && !errorDialog.opened) {
      errorDialog.toggle();
      return;
    }

    // If the error dialog is opened, but display is false, hide the dialog.
    if (!display && errorDialog.opened) {
      errorDialog.toggle();
      return;
    }
  }
}
