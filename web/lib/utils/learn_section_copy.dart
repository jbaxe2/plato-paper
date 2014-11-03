part of plato.paper.utils;

class LearnSectionCopy extends PreviousContentable {
  /// The [LearnSectionCopy] constructor is used to create an instance, and
  /// sets the system to use Learn ('learn').
  LearnSectionCopy() : super() {
    _system = new Symbol ('learn');
  }
}
