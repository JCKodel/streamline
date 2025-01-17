part of '../streamline.dart';

/// Central mediator that manages dispatchers for different types of actions in
/// the application.
///
/// Provides access to dispatchers for events, commands, queries, and
/// aggregators.
///
/// Acts as the main entry point for handling all application actions.
final class Mediator {
  // coverage:ignore-start
  const Mediator._();
  // coverage:ignore-end

  /// Dispatcher for handling events in the application.
  ///
  /// Events represent things that have happened and can have multiple
  /// observers.
  static final events = _EventsDispatcher();

  /// Dispatcher for handling commands in the application.
  ///
  /// Commands represent actions that modify state and have exactly one handler.
  static final commands = _CommandDispatcher();

  /// Dispatcher for handling queries in the application.
  ///
  /// Queries represent requests for data and have exactly one handler.
  static final queries = _QueryDispatcher();

  /// Dispatcher for handling aggregators in the application.
  ///
  /// Aggregators represent actions that can have multiple handlers with
  /// results combined.
  static final aggregators = _AggregatorDispatcher();

  /// Disposes all dispatchers and cleans up resources.
  ///
  /// Should be called when the application is shutting down or the mediator
  /// is no longer needed (for example, when testing).
  static void dispose() {
    events.dispose();
    commands.dispose();
    queries.dispose();
    aggregators.dispose();
  }
}
