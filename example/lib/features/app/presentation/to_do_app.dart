import 'package:flutter/material.dart';

import 'package:streamline_example/features/app/presentation/to_do_home_page.dart';

/// This is the main app widget, as usual.
final class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const ToDoHomePage(),
    );
  }
}
