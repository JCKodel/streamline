part of '../streamline.dart';

/// An aggregator is a type that represents a [IAggregator], a message that
/// have multiple handlers and all results are returned.
///
/// This class *MUST* use the @[MappableClass] annotation and implement the
/// dart_mappable functionality. To ensure this behavior, this interface will
/// ask for [toJson] and [toMap] implementations (which should be provided by
/// the dart_mappable package, and not created manually). This ensures this
/// class is safe to compare by value.
abstract interface class IAggregator<TResult> implements IAction<TResult> {}

/// An aggregator handler is a type that handles an [IAggregator].
///
/// Multiple aggregator handlers can be registered for a specific
/// [IAggregator].
abstract interface class IAggregatorHandler<
  TAggregator extends IAggregator<TResult>,
  TResult
>
    implements IActionHandler<TAggregator, TResult> {
  @override
  Future<TResult> handle(TAggregator aggregator);
}

/// An aggregator dispatcher is a type that dispatches an [IAggregator] to
/// all registered [IAggregatorHandler]s.
final class _AggregatorDispatcher
    extends
        _DispatcherManager<
          IAggregator<dynamic>,
          dynamic,
          IAggregatorHandler<IAggregator<dynamic>, dynamic>
        > {
  @override
  bool get _singleHandlersOnly => false;

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
  Future<List<TResult>> aggregate<TResult>(IAggregator<TResult> aggregator) async {
    final result = await _dispatch(aggregator);

    return result.cast<TResult>();
  }
}
