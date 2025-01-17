import 'package:dart_mappable/dart_mappable.dart';

import 'package:streamline/streamline.dart';

import '../contracts/i_to_dos_repository.dart';
import '../entities/mutate_to_do_response.dart';
import '../entities/to_do.dart';
import '../events/to_do_was_deleted.dart';

part 'delete_to_do.mapper.dart';

@MappableClass()
final class DeleteToDoCommand
    with DeleteToDoCommandMappable
    implements ICommand<MutateToDoResponse> {
  const DeleteToDoCommand(this.toDo);

  final ToDo toDo;

  static const fromMap = DeleteToDoCommandMapper.fromMap;
  static const fromJson = DeleteToDoCommandMapper.fromJson;
}

/// Commands are no different from queries whatsoever (they share the same
/// code inside the library). This difference is only semantic: whenever you
/// see a command, you know it will mutate something, while a query will only
/// return something without causing any side-effect. Notice that no actions
/// are taken to actually enforce this behavior. This is YOUR responsibility.
final class DeleteToDoCommandHandler
    implements ICommandHandler<DeleteToDoCommand, MutateToDoResponse> {
  const DeleteToDoCommandHandler({required IToDosRepository repository})
      : _repository = repository;

  /// We will inject this data repository here
  final IToDosRepository _repository;

  /// This will be executed whenever a [DeleteToDoCommand] command is
  /// dispatched.
  @override
  Future<MutateToDoResponse> handle(DeleteToDoCommand command) async {
    // Yes, I'm a wirdo that don't like to use ! as a boolean negator. Sue me.
    if (command.toDo.completed == false) {
      // We will not allow to delete a to-do if it is not completed because
      // we want to annoy our users.
      return const InvalidMutateToDoResponse(
        reason: MutateValidationError.deletedUncompleted,
      );
    }

    final response = await _repository.deleteToDo(command.toDo.id);

    // If the response is a success, we inform whomever is listening that the
    // to-do was deleted, through a domain event:
    if (response is SuccessMutateToDoResponse) {
      $emit(ToDoWasDeleted(id: command.toDo.id));
    }

    // Whatever the response is, the UI will handle it.
    return response;
  }
}
