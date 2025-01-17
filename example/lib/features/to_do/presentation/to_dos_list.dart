import 'package:flutter/material.dart';

import 'package:streamline/streamline.dart';
import 'package:streamline_example/features/to_do/events/to_do_has_changed.dart';
import 'package:streamline_example/features/to_do/events/to_do_was_deleted.dart';
import 'package:streamline_example/features/to_do/presentation/dialogs.dart';
import 'package:streamline_example/features/to_do/presentation/edit_to_do_page.dart';

import '../commands/delete_to_do.dart';
import '../commands/save_to_do.dart';
import '../entities/to_do.dart';
import '../queries/get_to_dos.dart';

/// Fetchs all available to-dos and shows them in a list.
final class ToDosList extends StatelessWidget {
  const ToDosList({required this.showOnlyCompleted, super.key});

  final bool showOnlyCompleted;

  @override
  Widget build(BuildContext context) {
    debugPrint(
      "We are rebuilding the ToDosList "
      "with showOnlyCompleted=$showOnlyCompleted",
    );

    return QueryBuilder(
      // This is the query we will request and rebuild the UI with the
      // response...
      query: GetToDosQuery(showOnlyCompleted: showOnlyCompleted),
      // that will auto-refresh whenever these events are emitted:
      eventObservers: [
        // Notice that you can apply filters in those streams to reduce
        // or pin-point exactly what you want to listen to:
        Mediator.events.getStream<ToDoWasDeleted>(),
        Mediator.events.getStream<ToDoHasChanged>(),
      ],
      builder: (context, response) => AnimatedSwitcher(
        duration: kThemeAnimationDuration,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: switch (response) {
          // That can be a list of to-dos, ...
          SuccessGetToDosResponse() => _ToDosList(response.toDos),
          // ...an empty list (either by filters or no to-dos available), or ...
          EmptyGetToDosResponse() => _EmptyResult(response.totalToDosAvailable),
          // ...an exception, so we can show an appropriate message to the user
          ExceptionGetToDosResponse() => ErrorWidget(response.exception),
        },
      ),
    );
  }
}

/// This is the UI for the list of to-dos.
final class _ToDosList extends StatelessWidget {
  const _ToDosList(this.toDos);

  final List<ToDo> toDos;

  Future<void> _deleteToDo(BuildContext context, ToDo todo) async {
    final doDelete = (await showAdaptiveDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog.adaptive(
            title: const Text("Delete To-Do"),
            content: Text("Are you sure you want to delete ${todo.title}?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Delete"),
              ),
            ],
          ),
        )) ??
        false;

    if (doDelete == false) {
      return;
    }

    final mutateToDoResponse = await $dispatch(DeleteToDoCommand(todo));

    // Always check if your widget is still alive after using async methods,
    // otherwise, the context could be invalid (so our navigation or alerts
    // can throw exceptions) and the setState will also throw exceptions.
    if (context.mounted == false) {
      return;
    }

    showMutationResultErrorDialog(
      context: context,
      mutateToDoResponse: mutateToDoResponse,
      popOnSuccess: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: toDos.length,
      primary: true,
      itemBuilder: (context, index) {
        final todo = toDos[index];

        return ListTile(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => EditToDoPage(toDo: todo),
            ),
          ),
          leading: SizedBox.square(
            dimension: 40,
            child: Center(
              child: Switch.adaptive(
                value: todo.completed,
                onChanged: (value) => $dispatch(
                  SaveToDoCommand(toDo: todo.copyWith(completed: value)),
                ),
              ),
            ),
          ),
          title: Text(todo.title),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteToDo(context, todo),
          ),
        );
      },
    );
  }
}

/// This is the UI for an empty list of to-dos.
final class _EmptyResult extends StatelessWidget {
  const _EmptyResult(this.totalToDosAvailable);

  final int totalToDosAvailable;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          switch (totalToDosAvailable) {
            0 => "There are no to-dos available",
            1 => "There are one to-dos available, "
                "but it is not being shown because it is completed",
            _ => "There are $totalToDosAvailable to-dos available, "
                "but they are not being shown because they are completed",
          },
        ),
      ),
    );
  }
}
