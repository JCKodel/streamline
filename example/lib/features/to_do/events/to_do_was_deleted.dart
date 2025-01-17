import 'package:dart_mappable/dart_mappable.dart';

import 'package:streamline/streamline.dart';

part 'to_do_was_deleted.mapper.dart';

/// This event is emitted when a to-do is deleted.
///
/// Many parts can listen to this event, but our home page will listen to this
/// event in order to refresh the list of to-dos after a deletion.
///
/// Notice that an event must have two things: implement the [IEvent] interface
/// (this interface has nothing to implement, it is just a "decoration" to
/// indicate the library that this is an event - check "decoration pattern"
/// on Google for more info). Since repeated events are discarded (otherwise,
/// the UI would refresh without the need), this class must be value-equatable.
/// Another reason to use Dart Mappable (but you could use whatever means you
/// want, such as the Equatable package))
@MappableClass()
final class ToDoWasDeleted with ToDoWasDeletedMappable implements IEvent {
  const ToDoWasDeleted({required this.id});

  /// The id of the deleted to-do (to, maybe, make the UI animate the deletion)
  final String id;

  static const fromMap = ToDoWasDeletedMapper.fromMap;
  static const fromJson = ToDoWasDeletedMapper.fromJson;
}
