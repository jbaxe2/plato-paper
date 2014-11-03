part of plato.paper.utils;

class VistaSectionImport extends PreviousContentable {
  /// The [VistaSectionImport] constructor is used to create an instance, and
  /// sets the system to use Vista ('vista').
  VistaSectionImport() : super() {
    _system = new Symbol ('vista');
  }
}
