import '../entities/mutate_to_do_response.dart';
import '../entities/to_do.dart';
import '../queries/get_to_dos.dart';

/// This is a contract for a repository that will handle the to-dos on some
/// kind of database.
///
/// A contract is a way to make your app knows exactly what an repository can
/// do without having to know anything about how it is implemented.
///
/// Another use for contracts is to change your dependency: on your app, you'll
/// use something like a SQLite database or a remote API. In tests, you cannot
/// use such dependencies in unit tests, so you'll create a mock repository or
/// a fake repository that will work only in memory.
///
/// It also allows you to change your implementation if something goes wrong.
/// For example: you used Firebase Auth to make your authentication system.
/// But now, your app needs enterprise authentication, something that Firebase
/// cannot provide, but Zitadel can. Instead of changing all your app and
/// breaking a lot of things, all you'll ever need to do is to implement this
/// contract using the new library you want. And you're done!
abstract interface class IToDosRepository {
  /// Since this implementation MUST handle exceptions, it doesn't make sense
  /// to return a [List<ToDo>] directly, so we return a [GetToDosResponse].
  ///
  /// Is this business logic in the "wrong place"? Maybe. But it is useful, so
  /// it is not "wrong".
  Future<GetToDosResponse> getToDos(bool showOnlyCompleted);

  /// Deletes a to-do by its id.
  Future<MutateToDoResponse> deleteToDo(String id);

  /// Saves the changes of a to-do to the database.
  Future<MutateToDoResponse> saveToDo(ToDo toDo);
}
