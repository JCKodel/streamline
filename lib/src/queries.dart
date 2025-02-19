part of '../streamline.dart';

/// A query is a type that represents a [IQuery].
///
/// Queries are used to retrieve data from the state of the application without
/// mutating the state.
///
/// This class *MUST* use the @[MappableClass] annotation and implement the
/// dart_mappable functionality. To ensure this behavior, this interface will
/// ask for [toJson] and [toMap] implementations (which should be provided by
/// the dart_mappable package, and not created manually). This ensures this
/// class is safe to compare by value.
abstract interface class IQuery<TResult> implements IAction<TResult> {}

/// A handler for queries that implements the [IActionHandler] interface.
///
/// Query handlers process queries and return data without modifying
/// application state.
///
/// Each query type must have exactly one handler.
abstract interface class IQueryHandler<TQuery extends IQuery<TResult>, TResult>
    implements IActionHandler<TQuery, TResult> {
  /// Handles the given query and returns the requested data.
  ///
  /// @param query The query to process
  /// @returns A Future containing the requested data
  @override
  Future<TResult> handle(TQuery query);
}

/// A query dispatcher is a type that dispatches an [IQuery] to a registered
/// [IQueryHandler].
final class _QueryDispatcher
    extends
        _DispatcherManager<
          IQuery<dynamic>,
          dynamic,
          IQueryHandler<IQuery<dynamic>, dynamic>
        > {
  @override
  bool get _singleHandlersOnly => true;

  /// Requests a query to its registered handler and returns the result.
  ///
  /// Each query type must have exactly one registered handler. The query
  /// is processed through the pipeline before reaching the handler.
  ///
  /// @param query The query to process
  /// @returns A Future containing the requested data
  Future<TResult> request<TResult>(IQuery<TResult> query) async {
    final results = await _dispatch(query);

    return results.first as TResult;
  }
}
