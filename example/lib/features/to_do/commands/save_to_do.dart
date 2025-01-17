import 'package:dart_mappable/dart_mappable.dart';

import 'package:streamline/streamline.dart';

import '../contracts/i_to_dos_repository.dart';
import '../entities/mutate_to_do_response.dart';
import '../entities/to_do.dart';
import '../events/to_do_has_changed.dart';

part 'save_to_do.mapper.dart';

/// This command will request the handler to save this to-do to our database.
@MappableClass()
final class SaveToDoCommand
    with SaveToDoCommandMappable
    implements ICommand<MutateToDoResponse> {
  const SaveToDoCommand({required this.toDo});

  final ToDo toDo;

  static const fromMap = SaveToDoCommandMapper.fromMap;
  static const fromJson = SaveToDoCommandMapper.fromJson;
}

/// This command handler will be executed whenever a [SaveToDoCommand] command
/// is dispatched.
final class SaveToDoCommandHandler
    implements ICommandHandler<SaveToDoCommand, MutateToDoResponse> {
  const SaveToDoCommandHandler({required this.repository});

  /// Our injected repository
  final IToDosRepository repository;

  @override
  Future<MutateToDoResponse> handle(SaveToDoCommand command) async {
    if (command.toDo.title.isEmpty) {
      return const InvalidMutateToDoResponse(
        reason: MutateValidationError.noTitle,
      );
    }

    if (command.toDo.description.isEmpty) {
      return const InvalidMutateToDoResponse(
        reason: MutateValidationError.noDescription,
      );
    }

    final response = await repository.saveToDo(command.toDo);

    // If our response is a success, we inform whomever is listening that the
    // to-do was saved, through a domain event:
    if (response is SuccessMutateToDoResponse) {
      // If you prefer, you can emit different events, one for a to-do creation,
      // and another for a to-do update. This is just an example.
      $emit(ToDoHasChanged(toDo: command.toDo));
    }

    // Whatever the response is, the UI will handle it.
    return response;
  }
}
