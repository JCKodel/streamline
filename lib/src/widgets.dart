part of '../streamline.dart';

Widget _errorBuilder(
  BuildContext context,
  Object error,
  StackTrace stackTrace,
) {
  return ErrorWidget(error);
}

/// Type definition for a query handler factory function.
typedef QueryHandlerDelegate = IQueryHandler<IQuery<dynamic>, dynamic>
    Function();

/// Type definition for a command handler factory function.
typedef CommandHandlerDelegate = ICommandHandler<ICommand<dynamic>, dynamic>
    Function();

/// Type definition for an aggregator handler factory function.
typedef AggregatorHandlerDelegate
    = IAggregatorHandler<IAggregator<dynamic>, dynamic> Function();

/// Type definition for an event handler factory function.
typedef EventHandlerDelegate = IEventHandler<IEvent> Function();

/// Widget that configures and initializes the Mediator system.
///
/// Allows registration of handlers for commands, queries, aggregators, and
/// events.
///
/// Also provides initialization callback and automatic cleanup.
final class MediatorConfig extends StatefulWidget {
  const MediatorConfig({
    required this.child,
    this.onInitialize,
    this.commandHandlers,
    this.queryHandlers,
    this.aggregatorHandlers,
    this.eventHandlers,
    super.key,
  });

  /// Callback executed after widget initialization
  final void Function()? onInitialize;

  // Map of command types to their handler factories
  final Map<Type, CommandHandlerDelegate>? commandHandlers;

  /// Map of query types to their handler factories
  final Map<Type, QueryHandlerDelegate>? queryHandlers;

  /// Map of aggregator types to their handler factories
  final Map<Type, List<AggregatorHandlerDelegate>>? aggregatorHandlers;

  /// Map of event types to their handler factories
  final Map<Type, List<EventHandlerDelegate>>? eventHandlers;

  /// Child widget to render
  final Widget child;

  @override
  State<MediatorConfig> createState() => _MediatorConfigState();
}

final class _MediatorConfigState extends State<MediatorConfig> {
  @override
  void initState() {
    super.initState();

    if (widget.commandHandlers != null) {
      for (final entry in widget.commandHandlers!.entries) {
        Mediator.commands.registerHandlerFactoryType(entry.key, entry.value);
      }
    }

    if (widget.queryHandlers != null) {
      for (final entry in widget.queryHandlers!.entries) {
        Mediator.queries.registerHandlerFactoryType(entry.key, entry.value);
      }
    }

    if (widget.aggregatorHandlers != null) {
      for (final entry in widget.aggregatorHandlers!.entries) {
        for (final handler in entry.value) {
          Mediator.aggregators.registerHandlerFactoryType(entry.key, handler);
        }
      }
    }

    if (widget.eventHandlers != null) {
      for (final entry in widget.eventHandlers!.entries) {
        for (final watcher in entry.value) {
          Mediator.events.registerHandlerFactoryType(entry.key, watcher);
        }
      }
    }

    if (widget.onInitialize != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          widget.onInitialize!();
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    Mediator.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

sealed class _ActionBuilder<TAction extends IAction<TResponse>, TResponse,
    TResult> extends StatefulWidget {
  const _ActionBuilder({
    required this.action,
    required this.builder,
    this.onError,
    this.onResponseReceived,
    this.waiterBuilder,
    this.errorBuilder,
    this.eventObservers,
    this.cacheUntilChanged,
    super.key,
  });

  /// If true, the action will be cached until some eventObserver reports a
  /// change in the underlying data.
  final bool? cacheUntilChanged;

  final TAction action;

  final Widget Function(
    BuildContext context,
    TResult response,
  ) builder;

  final void Function(
    BuildContext context,
    Object error,
    StackTrace stackTrace,
  )? onError;

  final void Function(BuildContext context, TResult response)?
      onResponseReceived;

  final Widget Function(BuildContext context)? waiterBuilder;

  final Widget Function(
    BuildContext context,
    Object error,
    StackTrace stackTrace,
  )? errorBuilder;

  final List<Stream<IEvent>>? eventObservers;

  @override
  State<_ActionBuilder<TAction, TResponse, TResult>> createState() =>
      _ActionBuilderState<TAction, TResponse, TResult>();
}

final class _ActionBuilderState<TAction extends IAction<TResponse>, TResponse,
    TResult> extends State<_ActionBuilder<TAction, TResponse, TResult>> {
  Completer<TResult>? _requestCompleter;

  List<StreamSubscription<IEvent>>? _eventRefreshSubscriptions;
  TResult? _response;

  @override
  void initState() {
    super.initState();

    if (widget.eventObservers != null) {
      _eventRefreshSubscriptions = <StreamSubscription<IEvent>>[];

      for (final filter in widget.eventObservers!) {
        final subscription = filter.listen((_) => _dispatchAction());

        _eventRefreshSubscriptions!.add(subscription);
      }
    }

    _dispatchAction();
  }

  @override
  void didUpdateWidget(_ActionBuilder<TAction, TResponse, TResult> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.action != oldWidget.action) {
      _response = null;
      _dispatchAction();
    }
  }

  @override
  void dispose() {
    super.dispose();

    if (_eventRefreshSubscriptions != null) {
      for (final subscription in _eventRefreshSubscriptions!) {
        subscription.cancel();
      }
    }
  }

  void _dispatchAction() {
    if (_response != null) {
      final cacheResult = widget.cacheUntilChanged ??
          (widget.eventObservers != null && widget.eventObservers!.isNotEmpty);

      if (cacheResult) {
        return;
      }
    }

    final isRefresh = _requestCompleter != null;

    _requestCompleter = Completer<TResult>();

    requestAction(_requestCompleter!).then((value) {
      _response = value;

      if (mounted == false) {
        return;
      }

      if (widget.onResponseReceived != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onResponseReceived?.call(context, value);
        });
      }

      if (isRefresh) {
        setState(() {});
      }
    });
  }

  @protected
  Future<TResult> requestAction(Completer<TResult> completer) async {
    final response = await switch (widget) {
      AggregatorBuilder<dynamic>() => $aggregate(
          widget.action as IAggregator<dynamic>,
        ),
      CommandBuilder<dynamic>() => $dispatch(
          widget.action as ICommand<dynamic>,
        ),
      QueryBuilder<dynamic>() => $request(
          widget.action as IQuery<dynamic>,
        ),
    };

    if (widget is AggregatorBuilder && response is List) {
      final list = <TResponse>[];

      for (final result in response) {
        list.add(result as TResponse);
      }

      final castList = list as TResult;

      completer.complete(castList);

      return castList;
    }

    completer.complete(response as TResult);

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: _response,
      future: _requestCompleter!.future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final builder = widget.errorBuilder ?? _errorBuilder;

          widget.onError?.call(context, snapshot.error!, snapshot.stackTrace!);

          return builder(context, snapshot.error!, snapshot.stackTrace!);
        }

        if (snapshot.connectionState == ConnectionState.waiting &&
            _response == null) {
          return widget.waiterBuilder?.call(context) ?? const SizedBox.shrink();
        }

        final data = (snapshot.data ?? _response) as TResult;

        return widget.builder(context, data);
      },
    );
  }
}

/// Widget that executes an aggregator and builds UI based on its results.
final class AggregatorBuilder<TResponse>
    extends _ActionBuilder<IAggregator<TResponse>, TResponse, List<TResponse>> {
  const AggregatorBuilder({
    required IAggregator<TResponse> aggregate,
    required super.builder,
    super.cacheUntilChanged,
    super.errorBuilder,
    super.waiterBuilder,
    super.eventObservers,
    super.key,
  }) : super(action: aggregate);
}

/// Widget that executes a command and builds UI based on its result.
final class CommandBuilder<TResponse>
    extends _ActionBuilder<ICommand<TResponse>, TResponse, TResponse> {
  const CommandBuilder({
    required ICommand<TResponse> command,
    required super.builder,
    super.errorBuilder,
    super.waiterBuilder,
    super.key,
  }) : super(action: command);
}

/// Widget that executes a query and builds UI based on its result.
final class QueryBuilder<TResponse>
    extends _ActionBuilder<IQuery<TResponse>, TResponse, TResponse> {
  const QueryBuilder({
    required IQuery<TResponse> query,
    required super.builder,
    super.cacheUntilChanged,
    super.onError,
    super.onResponseReceived,
    super.errorBuilder,
    super.waiterBuilder,
    super.eventObservers,
    super.key,
  }) : super(action: query);
}

/// Widget that observes events of type T and builds UI based on the latest
/// event.
final class EventBuilder<T extends IEvent> extends StatelessWidget {
  const EventBuilder({
    required this.builder,
    this.waiterBuilder,
    this.errorBuilder,
    super.key,
  });

  final Widget Function(BuildContext context, T event) builder;
  final Widget Function(BuildContext context)? waiterBuilder;

  final Widget Function(
    BuildContext context,
    Object error,
    StackTrace stackTrace,
  )? errorBuilder;

  @override
  Widget build(BuildContext context) {
    final initialData = switch (Mediator.events.getLastEmittedEvent<T>()) {
      None() => null,
      Some(value: final value) => value,
    };

    return StreamBuilder<T>(
      initialData: initialData,
      stream: Mediator.events.getStream<T>().distinct(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final builder = errorBuilder ?? _errorBuilder;

          return builder(context, snapshot.error!, snapshot.stackTrace!);
        }

        if (snapshot.connectionState == ConnectionState.waiting &&
            initialData == null) {
          return waiterBuilder?.call(context) ?? const SizedBox.shrink();
        }

        final data = snapshot.data ?? initialData;

        if (data == null) {
          final message = "Event stream error "
              "(no data because ${snapshot.connectionState})";

          final ex = StateError(message);
          final st = StackTrace.current;
          final builder = errorBuilder ?? _errorBuilder;

          return builder(context, ex, st);
        }

        return builder(context, data);
      },
    );
  }
}
