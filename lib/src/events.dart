part of '../streamline.dart';

/// An event is something that happens in the application.
///
/// This class *MUST* use the @[MappableClass] annotation and implement the
/// dart_mappable functionality. To ensure this behavior, this interface will
/// ask for [toJson] and [toMap] implementations (which should be provided by
/// the dart_mappable package, and not created manually). This ensures this
/// class is safe to compare by value.
abstract interface class IEvent implements IAction<void> {}

/// A handler for events that implements the [IActionHandler] interface.
///
/// Event handlers process events but don't return any value (void).
abstract interface class IEventHandler<TEvent extends IEvent>
    implements IActionHandler<TEvent, void> {}

/// A function type that observes events and optionally transforms or filters
/// them.
///
/// Returns Some(event) to allow the event to proceed, or None() to cancel it.
typedef EventObserver<TEvent extends IEvent> = Option<TEvent> Function(TEvent event);

final class _EventsDispatcher
    extends _DispatcherManager<IEvent, void, IEventHandler<IEvent>> {
  final _eventSubjects = <String, BehaviorSubject<dynamic>>{};
  final _eventStreams = <String, ValueStream<dynamic>>{};
  final _eventObservers = <String, List<EventObserver>>{};
  final _globalEventObservers = <EventObserver>{};

  @override
  bool get _singleHandlersOnly => false;

  @override
  void dispose() {
    for (final subject in _eventSubjects.values) {
      subject.close();
    }

    for (final subject in _eventSubjects.values) {
      subject.drain<dynamic>().ignore();
    }

    _eventStreams.clear();
    _eventSubjects.clear();
    _eventObservers.clear();
    _globalEventObservers.clear();
    super.dispose();
  }

  BehaviorSubject<TEvent> _getSubjectByType<TEvent extends IEvent>() {
    final typeName = TEvent.toString();
    final subject = _eventSubjects[typeName] ??= BehaviorSubject<TEvent>();

    return subject as BehaviorSubject<TEvent>;
  }

  /// Gets the stream of events for a specific event type.
  ///
  /// Returns a [ValueStream] that emits events of type [TEvent].
  ValueStream<TEvent> getStream<TEvent extends IEvent>() {
    final typeName = TEvent.toString();
    final stream = _eventStreams[typeName];

    if (stream != null) {
      return stream as ValueStream<TEvent>;
    }

    final subject = _getSubjectByType<TEvent>();

    return _eventStreams[typeName] = subject.stream;
  }

  /// Gets the last emitted event of a specific type.
  ///
  /// Returns an [Option] containing the last event if one exists, or None if no
  /// event has been emitted.
  Option<TEvent> getLastEmittedEvent<TEvent extends IEvent>() {
    final typeName = TEvent.toString();
    final subject = _eventSubjects[typeName];
    final value = subject?.valueOrNull;

    return switch (value) {
      null => const Option.none(),
      _ => Option.some(value as TEvent),
    };
  }

  /// Registers an observer for a specific event type.
  ///
  /// The observer can transform or filter events before they are processed.
  void registerObserver<TEvent extends IEvent>(EventObserver<TEvent> hook) {
    final typeName = TEvent.toString();
    final hooks = _eventObservers[typeName] ??= [];

    hooks.add((event) => hook(event as TEvent));
  }

  /// Registers a global observer that receives all events.
  ///
  /// Global observers can transform or filter any event before it is processed.
  void registerGlobalObserver<TEvent extends IEvent>(EventObserver hook) {
    _globalEventObservers.add(hook);
  }

  /// Emits an event to all registered handlers and observers.
  ///
  /// The event passes through observers first, then is sent to handlers and
  /// added to the appropriate stream.
  void emit<TEvent extends IEvent>(TEvent event) {
    var currentEvent = Option<IEvent>.some(event);
    final hooks = _eventObservers[TEvent.toString()];

    if (hooks != null) {
      for (final hook in hooks) {
        currentEvent = hook(event);

        switch (currentEvent) {
          case None<IEvent>():
            return;
          default:
        }
      }
    }

    for (final hook in _globalEventObservers) {
      currentEvent = hook(event);

      switch (currentEvent) {
        case None<IEvent>():
          return;
        default:
      }
    }

    _dispatch(event, true);

    final subject = _getSubjectByType<TEvent>();

    subject.add(event);
  }
}
