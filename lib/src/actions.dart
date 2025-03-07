part of '../streamline.dart';

/// An action is a type that represents a [ICommand], [IQuery], [IAggregator]
/// or [IEvent].
///
/// This class *MUST* use the @[MappableClass] annotation and implement the
/// dart_mappable functionality. To ensure this behavior, this interface will
/// ask for [toJson] and [toMap] implementations (which should be provided by
/// the dart_mappable package, and not created manually). This ensures this
/// class is safe to compare by value.
abstract interface class IAction<TResult> {
  String toJson();
  Map<String, dynamic> toMap();
}

/// A handler interface for processing actions of type [TAction] and producing
/// results of type [TResult].
abstract interface class IActionHandler<TAction extends IAction<TResult>, TResult> {
  /// Handles the given action and returns a result.
  ///
  /// @param action The action to handle
  /// @returns A Future containing the result of handling the action

  Future<TResult> handle(TAction action);
}

final class _Pipeline<TAction extends IAction<TResult>, TResult> {
  _Pipeline();

  final List<
    Future<TResult> Function(
      TAction action,
      Future<TResult> Function(TAction newAction) next,
    )
  >
  _behaviours = [];

  void dispose() {
    _behaviours.clear();
  }

  Future<TResult> execute(
    TAction action,
    Future<TResult> Function(TAction action) handler,
  ) {
    Future<TResult> runner(TAction a, int index) async {
      if (index == _behaviours.length) {
        return handler(a);
      }

      final b = _behaviours[index];

      return b(a, (newAction) async => runner(newAction, index + 1));
    }

    return runner(action, 0);
  }
}

abstract base class _DispatcherManager<
  TAction extends IAction<TResult>,
  TResult,
  THandler extends IActionHandler<TAction, TResult>
> {
  final _pipeline = _Pipeline<TAction, TResult>();
  final _handlerFactories = <String, Set<THandler Function()>>{};

  @protected
  bool get _singleHandlersOnly;

  void dispose() {
    _handlerFactories.clear();
    _pipeline.dispose();
  }

  /// Register a pipeline behaviour.
  void registerGenericBehaviour(
    Future<TResult> Function(
      TAction action,
      Future<TResult> Function(TAction newAction) next,
    )
    behaviour,
  ) {
    _pipeline._behaviours.add(behaviour);
  }

  /// Register a pipeline behaviour.
  void registerBehaviour<TActionType extends IAction<TResultType>, TResultType>(
    Future<TResultType> Function(
      TActionType action,
      Future<TResultType> Function(TActionType newAction) next,
    )
    behaviour,
  ) {
    Future<TResult> b(
      TAction action,
      Future<TResult> Function(TAction newAction) next,
    ) =>
        behaviour(
              action as TActionType,
              (newAction) async => await next(newAction as TAction) as TResultType,
            )
            as Future<TResult>;

    _pipeline._behaviours.add(b);
  }

  /// Registers a [THandler] factory for a specific [IAction].
  void registerHandlerFactory<TActionType extends IAction<TResultType>, TResultType>(
    IActionHandler<TActionType, TResultType> Function() handlerFactory,
  ) {
    registerHandlerFactoryType(TActionType, handlerFactory as THandler Function());
  }

  /// Registers a [THandler] factory for a specific [IAction].
  void registerHandlerFactoryType(Type type, THandler Function() handlerFactory) {
    final typeName = type.toString();

    if (_singleHandlersOnly) {
      if (_handlerFactories.containsKey(typeName)) {
        throw ArgumentError("A handler for $typeName has already been registered");
      }
    }

    final set = _handlerFactories[typeName] ??= <THandler Function()>{};

    set.add(handlerFactory);
  }

  Future<List<TResult>> _dispatch(
    TAction action, [
    bool ignoreHandlers = false,
  ]) async {
    final typeName = action.runtimeType.toString();
    final handlerFactories = _handlerFactories[typeName];

    if (ignoreHandlers == false && handlerFactories == null) {
      throw ArgumentError("There is no handler for $typeName");
    }

    final resultTasks = <Future<TResult>>[];

    if (handlerFactories != null) {
      for (final handlerFactory in handlerFactories) {
        final handler = handlerFactory();

        resultTasks.add(_pipeline.execute(action, handler.handle));
      }
    } else {
      if (this is _EventsDispatcher) {
        Future<TResult> emptyHandler(TAction action) async => null as TResult;

        resultTasks.add(_pipeline.execute(action, emptyHandler));
      }
    }

    return await resultTasks.wait;
  }
}
