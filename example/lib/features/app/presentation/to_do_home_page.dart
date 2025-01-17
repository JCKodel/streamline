import 'package:flutter/material.dart';

import 'package:streamline_example/features/to_do/presentation/edit_to_do_page.dart';

import '../../to_do/presentation/to_dos_list.dart';

/// This is the main home page of the app.
final class ToDoHomePage extends StatefulWidget {
  const ToDoHomePage({super.key});

  @override
  State<ToDoHomePage> createState() => _ToDoHomePageState();
}

final class _ToDoHomePageState extends State<ToDoHomePage> {
  // This flag is used to filter completed to-dos in the list
  // Since it is a local state, only for this screen, there is no need
  // to use anything fancier than a simple [StatefulWidget].
  bool _showOnlyCompleted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Streamline To Do"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: SwitchListTile.adaptive(
            value: _showOnlyCompleted,
            title: const Text("Show only completed"),
            onChanged: (value) => setState(() => _showOnlyCompleted = value),
          ),
        ),
      ),
      body: ToDosList(
        showOnlyCompleted: _showOnlyCompleted,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const EditToDoPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
