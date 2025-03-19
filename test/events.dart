part of 'mediator_test.dart';

@MappableClass()
final class EventA with EventAMappable implements IEvent {
  const EventA(this.completer);

  final Completer<int> completer;

  static const fromMap = EventAMapper.fromMap;
  static const fromJson = EventAMapper.fromJson;
}

@MappableClass()
final class EventB with EventBMappable implements IEvent {
  const EventB(this.value);

  final int value;

  static const fromMap = EventBMapper.fromMap;
  static const fromJson = EventBMapper.fromJson;
}

final class EventAHandler implements IEventHandler<EventA> {
  @override
  Future<void> handle(EventA event) async {
    event.completer.complete(1);
  }
}

final class EventBHandler implements IEventHandler<EventB> {
  const EventBHandler(this.onEvent);

  final void Function(EventB event) onEvent;

  @override
  Future<void> handle(EventB event) async {
    onEvent(event);
  }
}

void _eventsTest() {
  test("Event is emmited", () async {
    final completer = Completer<int>();
    final event = EventA(completer);

    $eventHandler(EventAHandler.new);

    final lastEmitted = $lastEmitted<EventA>();

    expect(lastEmitted is None<EventA>, true);

    $emit(event);

    final lastEmittedEvent = $lastEmitted<EventA>();

    expect(lastEmittedEvent is Some, true);
    expect((lastEmittedEvent as Some<EventA>).value.completer, completer);

    await pumpEventQueue();

    await expectLater($eventStream<EventA>(), emitsInOrder([event]));

    await completer.future.timeout(const Duration(seconds: 1));
  });

  test("Event hook must filter events without watchers", () async {
    const event = EventB(42);
    final lastEmittedBefore = $lastEmitted<EventB>();

    expect(lastEmittedBefore is None<EventB>, true);

    var eventAverted = false;

    $eventObserver<EventB>((EventB event) {
      eventAverted = true;
      return const Option<EventB>.none();
    });

    $emit(event);

    await pumpEventQueue();

    expect(eventAverted, true);

    final lastEmittedAfter = $lastEmitted<EventB>();

    expect(lastEmittedAfter is None<EventB>, true);
  });

  test("Event hook must filter events without watchers (global)", () async {
    const event = EventB(42);
    final lastEmittedBefore = $lastEmitted<EventB>();

    expect(lastEmittedBefore is None<EventB>, true);

    var eventAverted = false;

    $globalEventObserver((IEvent event) {
      if (event is! EventB) {
        return Option<IEvent>.some(event);
      }

      eventAverted = true;
      return const Option<IEvent>.none();
    });

    $emit(event);

    await pumpEventQueue();

    expect(eventAverted, true);

    final lastEmittedAfter = $lastEmitted<EventB>();

    expect(lastEmittedAfter is None<EventB>, true);
  });

  test("Event subscription", () async {
    final handler = expectAsync1((int value) {
      expect(value, 42);
    });

    final subscription = $subscribe<EventB>((event) async {
      handler(event.value);
    });

    $emit(const EventB(42));
    await pumpEventQueue();

    subscription.cancel().ignore();
  });

  test("Generic pipeline", () async {
    final eventA = EventA(Completer());
    const eventB = EventB(42);
    var executions = 0;
    var eventAExecutions = 0;
    var eventBExecutions = 0;

    $registerGenericEventBehaviour((action, next) {
      switch (action) {
        case EventA():
          eventAExecutions++;
        case EventB():
          eventBExecutions++;
      }

      executions++;

      return next(action);
    });

    $emit(eventA);

    expect(executions, 1);
    expect(eventAExecutions, 1);
    expect(eventBExecutions, 0);

    $emit(eventB);

    expect(executions, 2);
    expect(eventAExecutions, 1);
    expect(eventBExecutions, 1);

    $emit(const EventB(3));

    expect(executions, 3);
    expect(eventAExecutions, 1);
    expect(eventBExecutions, 2);
  });

  test("Event handler with pipeline", () async {
    _EventBHandler.handleCount = 0;

    var genericBehaviorCount = 0;
    var globalBehaviorCount = 0;
    var eventArgument = 41;

    eventArgument++;

    $registerGenericEventBehaviour((e, next) {
      genericBehaviorCount++;
      return next(e);
    });

    Mediator.events.registerGlobalObserver((e) {
      globalBehaviorCount++;
      return Some(e);
    });

    $eventHandler<EventB, void>(_EventBHandler.new);

    expect(genericBehaviorCount, 0);
    expect(globalBehaviorCount, 0);
    expect(_EventBHandler.handleCount, 0);

    $emit(EventB(eventArgument));

    expect(genericBehaviorCount, 1);
    expect(globalBehaviorCount, 1);
    expect(_EventBHandler.handleCount, 1);

    $emit(EventB(eventArgument));

    expect(genericBehaviorCount, 1);
    expect(globalBehaviorCount, 2);
    expect(_EventBHandler.handleCount, 1);

    eventArgument++;
    $emit(EventB(eventArgument));

    expect(genericBehaviorCount, 2);
    expect(globalBehaviorCount, 3);
    expect(_EventBHandler.handleCount, 2);
  });

  test("Event handler with pipeline duplicate allowed", () async {
    _EventBHandler.handleCount = 0;

    var genericBehaviorCount = 0;
    var globalBehaviorCount = 0;
    var eventArgument = 41;

    eventArgument++;

    $registerGenericEventBehaviour((e, next) {
      genericBehaviorCount++;
      return next(e);
    });

    Mediator.events.registerGlobalObserver((e) {
      globalBehaviorCount++;
      return Some(e);
    });

    $eventHandler<EventB, void>(_EventBHandler.new);

    expect(genericBehaviorCount, 0);
    expect(globalBehaviorCount, 0);
    expect(_EventBHandler.handleCount, 0);

    $emit(EventB(eventArgument), skipIfSameAsLastEmitted: false);

    expect(genericBehaviorCount, 1);
    expect(globalBehaviorCount, 1);
    expect(_EventBHandler.handleCount, 1);

    $emit(EventB(eventArgument), skipIfSameAsLastEmitted: false);

    expect(genericBehaviorCount, 2);
    expect(globalBehaviorCount, 2);
    expect(_EventBHandler.handleCount, 2);

    eventArgument++;
    $emit(EventB(eventArgument), skipIfSameAsLastEmitted: false);

    expect(genericBehaviorCount, 3);
    expect(globalBehaviorCount, 3);
    expect(_EventBHandler.handleCount, 3);
  });
}

final class _EventBHandler implements IEventHandler<EventB> {
  const _EventBHandler();

  static int handleCount = 0;

  @override
  Future<void> handle(EventB action) async {
    handleCount++;
  }
}
