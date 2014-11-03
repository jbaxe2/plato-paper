part of plato.paper.utils;

/// The [Requestable] class is an abstract class that should be subclassed for
/// either course sections or sandboxes.
abstract class Requestable {
  String _id, _title;

  String get id => _id;
  String get title => _title;
}
