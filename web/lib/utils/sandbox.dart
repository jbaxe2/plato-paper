part of plato.paper.utils;

class Sandbox extends Requestable {
  UserInformation _userInfo;

  Sandbox (this._userInfo) {
    if (null == _userInfo) {
      _userInfo = new UserInformation();
    }
  }

  /**
   * The [toJson] method...
   */
  String toJson() {
    Map sandboxJson = new Map();

    return JSON.encode (sandboxJson);
  }
}
