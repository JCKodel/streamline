import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:streamline_example/features/to_do/contracts/i_to_dos_repository.dart';
import 'package:streamline_example/features/to_do/entities/mutate_to_do_response.dart';
import 'package:streamline_example/features/to_do/entities/to_do.dart';
import 'package:streamline_example/features/to_do/queries/get_to_dos.dart';

final class SharedPreferencesToDoRepository implements IToDosRepository {
  const SharedPreferencesToDoRepository({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  /// This is just a helper to make shared preferences easier to use
  List<ToDo> _getAllToDos() {
    final toDosJson = sharedPreferences.getString("toDos");

    if (toDosJson == null) {
      return [];
    }

    final toDosList = jsonDecode(toDosJson) as List<dynamic>;

    return List.from(
      toDosList.map((e) => ToDo.fromMap(e as Map<String, dynamic>)),
    );
  }

  void _saveAllToDos(List<ToDo> toDos) {
    final toDosJson = jsonEncode(toDos.map((e) => e.toMap()).toList());

    sharedPreferences.setString("toDos", toDosJson);
  }

  @override
  Future<GetToDosResponse> getToDos(bool showOnlyCompleted) async {
    try {
      // This is only an example app. Shared Preferences is not a good
      // database and should not be used as such.
      //
      // Also, filtering things in Dart is a bad idea (here, the
      // showOnlyCompleted argument would be passed to the remote API or, if
      // you are using a database, to the database WHERE clause)
      final toDos = List<ToDo>.from(_getAllToDos());
      final totalToDosAvailable = toDos.length;

      if (showOnlyCompleted) {
        toDos.removeWhere((e) => e.completed);
      }

      return toDos.isEmpty
          ? EmptyGetToDosResponse(totalToDosAvailable: totalToDosAvailable)
          : SuccessGetToDosResponse(toDos);
    } on Exception catch (ex, st) {
      // Pretty sure nothing can go wrong here, but, code in this folder is
      // considered "unsafe" and better be safe than sorry.
      //
      // Notice that we only catch Exceptions here (in theory, Errors should
      // not be catched, but you can't trust 3rd party packages understand
      // the Flutter's difference between [Error] and [Exception]).
      return ExceptionGetToDosResponse(ex, st);
    }
  }

  @override
  Future<MutateToDoResponse> deleteToDo(String id) async {
    try {
      final toDos = _getAllToDos();

      toDos.removeWhere((e) => e.id == id);

      _saveAllToDos(toDos);

      return const SuccessMutateToDoResponse();
    } on Exception catch (ex, st) {
      return ExceptionMutateToDoResponse(ex, st);
    }
  }

  @override
  Future<MutateToDoResponse> saveToDo(ToDo toDo) async {
    try {
      final toDos = _getAllToDos();
      final currentIndex = toDos.indexWhere((e) => e.id == toDo.id);

      if (currentIndex == -1) {
        toDos.add(toDo);
      } else {
        toDos[currentIndex] = toDo;
      }

      _saveAllToDos(toDos);

      return const SuccessMutateToDoResponse();
    } on Exception catch (ex, st) {
      return ExceptionMutateToDoResponse(ex, st);
    }
  }
}
