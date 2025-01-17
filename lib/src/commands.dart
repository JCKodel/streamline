part of '../streamline.dart';

/// A command is a type that represents a [ICommand].
///
/// Commands are used to perform an action that mutates the state of the
/// application.
///
/// This class *MUST* use the @[MappableClass] annotation and implement the
/// dart_mappable functionality. To ensure this behavior, this interface will
/// ask for [toJson] and [toMap] implementations (which should be provided by
/// the dart_mappable package, and not created manually). This ensures this
/// class is safe to compare by value.
abstract interface class ICommand<TResult> implements IAction<TResult> {}

/// A command handler is a type that handles an [ICommand].
abstract interface class ICommandHandler<TCommand extends ICommand<TResult>,
    TResult> implements IActionHandler<TCommand, TResult> {
  @override
  Future<TResult> handle(TCommand command);
}

/// A command dispatcher is a type that dispatches an [ICommand] to a
/// registered [ICommandHandler].
final class _CommandDispatcher extends _DispatcherManager<ICommand<dynamic>,
    dynamic, ICommandHandler<ICommand<dynamic>, dynamic>> {
  @override
  bool get _singleHandlersOnly => true;

  /// Dispatches a command to its registered handler and returns the result.
  ///
  /// Each command type must have exactly one registered handler. The command
  /// is processed through the pipeline before reaching the handler.
  ///
  /// @returns A Future containing the result of handling the command
  Future<TResult> dispatch<TResult>(ICommand<TResult> command) async {
    final results = await _dispatch(command);

    return results.first as TResult;
  }
}
