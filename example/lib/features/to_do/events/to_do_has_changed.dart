import 'package:dart_mappable/dart_mappable.dart';

import 'package:streamline/streamline.dart';

import '../entities/to_do.dart';

part 'to_do_has_changed.mapper.dart';

/// Whenever a to-do is created or updated, this event will be emitted, so the
/// ui can refresh the list of to-dos (or whatever UI showing this to-do).
@MappableClass()
final class ToDoHasChanged with ToDoHasChangedMappable implements IEvent {
  const ToDoHasChanged({required this.toDo});

  final ToDo toDo;

  static const fromMap = ToDoHasChangedMapper.fromMap;
  static const fromJson = ToDoHasChangedMapper.fromJson;
}
