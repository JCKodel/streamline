import 'package:dart_mappable/dart_mappable.dart';

part 'to_do.mapper.dart';

/// This entity represents a to do entry.
///
/// We use [MappableClass] here because it helps with serialization, copyWith,
/// and equality, should we need any of those features, but if you prefer
/// to use something else (or nothing at all), no problems.
///
/// Notice that Events are not processed if they are the same as the last
/// one emitted, and if an Event has a [ToDo] field, then this class MUST
/// be value-equality comparable (otherwise, the event will always be
/// considered different than the previous one, even if it carries the
/// exact same data)
///
/// Also, immutable classes are always a good idea to make things less
/// error-prone. Dart Mappable also helps with that implementing a
/// [copyWith] method.
@MappableClass()
final class ToDo with ToDoMappable {
  const ToDo({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
  });

  // There is nothing special here regarding Streamline
  final String id;
  final String title;
  final String description;
  final bool completed;

  // This optional methods are for Dart Mappable serialization
  static const fromMap = ToDoMapper.fromMap;
  static const fromJson = ToDoMapper.fromJson;
}
