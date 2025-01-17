import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:streamline/streamline.dart';
import 'package:streamline_example/features/app/presentation/to_do_app.dart';
import 'package:streamline_example/features/to_do/commands/delete_to_do.dart';
import 'package:streamline_example/features/to_do/commands/save_to_do.dart';
import 'package:streamline_example/features/to_do/queries/get_to_dos.dart';
import 'package:streamline_example/impl/to_do/support/shared_preferences_to_do_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// This is the repository that will serve as our database so we will
  /// inject this on our queries and commands down bellow.
  final repo = SharedPreferencesToDoRepository(
    sharedPreferences: await SharedPreferences.getInstance(),
  );

  /// Just for fun, we will measure the time it takes to execute our queries
  /// and commands and also log all our messaging:
  $registerGenericQueryBehaviour(_measureQueryPerformance);
  $registerGenericCommandBehaviour(_measureCommandPerformance);
  $registerGenericAggregatorBehaviour(_measureAggregatorPerformance);
  $registerGenericEventBehaviour(_logEventDispatch);

  runApp(
    // The mediator config is where you bind all your commands, queries,
    // aggregators and event handlers with the appropriate handlers.
    //
    // Notice that you can do that manually, using, for instance the
    // [Mediator.$queryHandler] method or any other method in [Mediator].
    MediatorConfig(
      // This method will be called after all handlers are registered and
      // the widget is rendered.
      onInitialize: () => debugPrint("Mediator initialized!"),
      // Here we register all our request handlers. Notice that we are creating
      // our ToDo repository and passing it here (so, basically, this is a
      // singleton dependency being injected to whomever needs it). If you wish,
      // you can use a dependency injection library like GetIt for this purpose.
      queryHandlers: {
        GetToDosQuery: () => GetToDosQueryHandler(repository: repo),
      },
      // Here we register all our command handlers.
      commandHandlers: {
        SaveToDoCommand: () => SaveToDoCommandHandler(repository: repo),
        DeleteToDoCommand: () => DeleteToDoCommandHandler(repository: repo),
      },
      // From here on, you can use any Streamline widgets
      child: const ToDoApp(),
    ),
  );
}

// The code below are the responsible to measure the performance of each of
// our actions and also log them to the console.

Future<dynamic> _measureQueryPerformance(
  IQuery<dynamic> action,
  Future<dynamic> Function(IQuery<dynamic> newAction) next,
) =>
    _measureActionPerformance(
      action,
      (action) => next(action as IQuery<dynamic>),
    );

Future<dynamic> _measureCommandPerformance(
  ICommand<dynamic> action,
  Future<dynamic> Function(ICommand<dynamic> newAction) next,
) =>
    _measureActionPerformance(
      action,
      (action) => next(action as ICommand<dynamic>),
    );

Future<dynamic> _measureAggregatorPerformance(
  IAggregator<dynamic> action,
  Future<dynamic> Function(IAggregator<dynamic> newAction) next,
) =>
    _measureActionPerformance(
      action,
      (action) => next(action as IAggregator<dynamic>),
    );

Future<dynamic> _measureActionPerformance(
  IAction<dynamic> action,
  Future<dynamic> Function(IAction<dynamic> newAction) next,
) async {
  final sw = Stopwatch()..start();

  debugPrint("Executing ${action}");

  final result = await next(action);

  sw.stop();
  debugPrint("${action.runtimeType} executed in ${sw.elapsedMilliseconds}ms");

  return result;
}

Future<void> _logEventDispatch(
  IEvent event,
  Future<void> Function(IEvent newAction) next,
) {
  debugPrint("Emitting ${event}");

  return next(event);
}
