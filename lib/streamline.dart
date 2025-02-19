library mediator;

import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:rxdart/rxdart.dart';

part 'src/actions.dart';
part 'src/aggregators.dart';
part 'src/commands.dart';
part 'src/events.dart';
part 'src/mediator.dart';
part 'src/option.dart';
part 'src/queries.dart';
part 'src/widgets.dart';

/// Emits an event to all registered handlers and observers.
///
/// The event passes through observers first, then is sent to handlers and
/// added to the appropriate stream.
final $emit = Mediator.events.emit;

/// Dispatches a command to its registered handler and returns the result.
///
/// Each command type must have exactly one registered handler. The command
/// is processed through the pipeline before reaching the handler.
///
/// @returns A Future containing the result of handling the command
final $dispatch = Mediator.commands.dispatch;

/// Requests a query to its registered handler and returns the result.
///
/// Each query type must have exactly one registered handler. The query
/// is processed through the pipeline before reaching the handler.
///
/// @param query The query to process
/// @returns A Future containing the requested data
final $request = Mediator.queries.request;

/// Processes an aggregator through all registered handlers and returns
/// their results.
///
/// Unlike commands which have a single handler, aggregators can have
/// multiple handlers.
///
/// The results from all handlers are collected and returned as a list.
///
/// @param aggregator The aggregator to process
/// @returns A Future containing a list of results from all handlers
final $aggregate = Mediator.aggregators.aggregate;

/// Registers a command handler factory for a specific [ICommand].
final $commandHandler = Mediator.commands.registerHandlerFactory;

/// Registers a query handler factory for a specific [IQuery].
final $queryHandler = Mediator.queries.registerHandlerFactory;

/// Registers an aggregator handler factory for a specific [IAggregator].
final $aggregatorHandler = Mediator.aggregators.registerHandlerFactory;

/// Registers an event handler factory for a specific [IEvent].
final $eventHandler = Mediator.events.registerHandlerFactory;

/// Registers an observer for a specific event type.
///
/// The observer can transform or filter events before they are processed.
final $eventObserver = Mediator.events.registerObserver;

/// Registers a global observer that receives all events.
///
/// Global observers can transform or filter any event before it is processed.
final $globalEventObserver = Mediator.events.registerGlobalObserver;

/// Gets the last emitted event of a specific type.
///
/// Returns an [Option] containing the last event if one exists, or None if no
/// event has been emitted.
final $lastEmitted = Mediator.events.getLastEmittedEvent;

/// Register a pipeline behaviour.
final $registerCommandBehaviour = Mediator.commands.registerBehaviour;

/// Register a pipeline behaviour.
final $registerGenericCommandBehaviour = Mediator.commands.registerGenericBehaviour;

/// Register a pipeline behaviour.
final $registerQueryBehaviour = Mediator.queries.registerBehaviour;

/// Register a pipeline behaviour.
final $registerGenericQueryBehaviour = Mediator.queries.registerGenericBehaviour;

/// Register a pipeline behaviour.
final $registerAggregatorBehaviour = Mediator.aggregators.registerBehaviour;

/// Register a pipeline behaviour.
final $registerGenericAggregatorBehaviour =
    Mediator.aggregators.registerGenericBehaviour;

/// Register a pipeline behaviour.
final $registerEventBehaviour = Mediator.events.registerBehaviour;

/// Register a pipeline behaviour.
final $registerGenericEventBehaviour = Mediator.events.registerGenericBehaviour;

/// Adds a subscription to this stream of [IEvent].
///
/// Returns a [StreamSubscription] which handles events from this stream.
StreamSubscription<TEvent> $subscribe<TEvent extends IEvent>(
  Future<void> Function(TEvent event) handler,
) => Mediator.events.getStream<TEvent>().listen(handler);

/// Gets the stream of events for a specific event type.
///
/// Returns a [ValueStream] that emits events of the event type.
final $eventStream = Mediator.events.getStream;
