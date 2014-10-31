part of plato.paper.utils;

/**
 * The [PreviousContentable] class is an abstract class, designed to be subclassed
 * for the specific system, Learn or Vista, the previous content will ultimately
 * be sourced from.
 */
abstract class PreviousContentable {
  /**
   * The [Requestable] instance represents a section or sandbox, for which the
   * previous content will either be copied (Learn) or imported (Vista) into.
   */
  Requestable _requested;

  /**
   * The [Requestable] instance represents a section or sandbox, for which its
   * content will be copied (Learn) or imported (Vista) into a requestable.
   */
  Requestable _previous;

  /**
   * A [Symbol] representing either Learn ('learn') or Vista ('vista').
   */
  Symbol _system;

  /**
   * The requested setter only allows it to be set provided it does not match
   * (either identical or equatable) the previous [Requestable] instance.
   */
  set requested (Requestable requested) =>
    (requested != _previous) ? requested : null;

  /**
   * The previous setter only allows it to be set provided it does not match
   * (either identical or equatable) the requested [Requestable] instance.
   */
  set previous (Requestable previous) =>
    (previous != _requested) ? previous : null;

  Requestable get requested => _requested;
  Requestable get previous => _previous;

  Symbol get system => _system;
}
