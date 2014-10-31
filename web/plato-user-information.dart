library plato.paper.user_information;

import 'package:polymer/polymer.dart';

import './lib/utils/plato_paper_utils.dart' show UserInformation;
import './lib/errors/plato_paper_errors.dart' show UserInfoException;

/// A Polymer-based element, using paper elements, to display user information.
@CustomTag('plato-user-information')
class PlatoUserInformation extends PolymerElement {
  @observable String firstName;
  @observable String lastName;
  @observable String email;
  @observable String userId;

  /// The [UserInformation] instance serving as the data model for this custom
  /// element.
  UserInformation _userInfo;

  PlatoUserInformation.created() : super.created() {
    _userInfo = new UserInformation();
  }

  /// The [fillUserInformation] method is used to retrieve the user information
  /// from the [UserInformation] instance, and set this custom element's fields as
  /// appropriate.  If the [UserInformation] instance does not contain this information
  /// yet, then a [UserInfoException] instance will be thrown.
  void fillUserInformation() {
    if ((1 > _userInfo.username.length) || (1 > _userInfo.password.length)) {
      throw new UserInfoException (
        'The user information has not yet been properly established'
      );
    }

    firstName = _userInfo.firstName;
    lastName = _userInfo.lastName;
    email = _userInfo.email;
    userId = _userInfo.userId;
  }
}
