import 'package:flutter/material.dart';

import 'package:streamline/streamline.dart';

import '../commands/save_to_do.dart';
import '../entities/to_do.dart';

import 'dialogs.dart';

/// This is the page responsible to create or edit a to-do.
///
/// Again, since the edition is a local state, we will use a simple
/// [StatefulWidget] to handle it.
///
/// State management is useful only for APP STATE, not for ephemeral or local
/// state, such as the filter in the home page or this form!
///
/// Validations should be handled by the [SaveToDoCommand] command, but you
/// could add extra validations here (using the form widgets validation methods,
/// for example, or some validation library, since that would be an UI thing).
final class EditToDoPage extends StatefulWidget {
  const EditToDoPage({this.toDo, super.key});

  // If null, it is a creation, otherwise, it is an update.
  final ToDo? toDo;

  @override
  State<EditToDoPage> createState() => _EditToDoPageState();
}

final class _EditToDoPageState extends State<EditToDoPage> {
  String _title = "";
  String _description = "";
  bool _completed = false;

  @override
  void initState() {
    super.initState();

    // If it is an edit operation, we copy the to-do value to our local state
    if (widget.toDo != null) {
      _title = widget.toDo!.title;
      _description = widget.toDo!.description;
      _completed = widget.toDo!.completed;
    }
  }

  Future<void> _saveToDo() async {
    // It's a good idea to validate the form before sending, but it is even
    // better to validate in the business layer, always. For sake of brevity,
    // we will just validate in the command handler.
    final toDo = widget.toDo == null
        ? ToDo(
            id: DateTime.now().toIso8601String(), // Just an example
            title: _title,
            description: _description,
            completed: _completed,
          )
        : widget.toDo!.copyWith(
            title: _title,
            description: _description,
            completed: _completed,
          );

    final result = await $dispatch(SaveToDoCommand(toDo: toDo));

    // Always check if your widget is still alive after using async methods,
    // otherwise, the context could be invalid (so our navigation or alerts
    // can throw exceptions) and the setState will also throw exceptions.
    if (mounted == false) {
      return;
    }

    showMutationResultErrorDialog(
      context: context,
      mutateToDoResponse: result,
      popOnSuccess: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.toDo == null ? "Create" : "Edit"} To Do"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                initialValue: _title,
                onChanged: (value) => setState(() => _title = value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
                initialValue: _description,
                onChanged: (value) => setState(() => _description = value),
              ),
            ),
            SwitchListTile.adaptive(
              value: _completed,
              title: const Text("Completed"),
              onChanged: (value) => setState(() => _completed = value),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: FilledButton(
                onPressed: _saveToDo,
                child: const Text("Save To Do"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
