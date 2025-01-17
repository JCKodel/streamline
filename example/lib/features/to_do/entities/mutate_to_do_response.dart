import 'package:dart_mappable/dart_mappable.dart';

part 'mutate_to_do_response.mapper.dart';

/// This is the response for all to-do mutations actions.
@MappableClass()
sealed class MutateToDoResponse with MutateToDoResponseMappable {
  const MutateToDoResponse();

  static const fromMap = MutateToDoResponseMapper.fromMap;
  static const fromJson = MutateToDoResponseMapper.fromJson;
}

/// The mutation was executed successfully.
@MappableClass()
final class SuccessMutateToDoResponse extends MutateToDoResponse
    with SuccessMutateToDoResponseMappable {
  const SuccessMutateToDoResponse();

  static const fromMap = SuccessMutateToDoResponseMapper.fromMap;
  static const fromJson = SuccessMutateToDoResponseMapper.fromJson;
}

/// Why use an enum to represent the error? Because it is not a magic string
/// you can typo, you can cover all the cases using switch statements and
/// the text that will be displayed is a UI domain thing (because is the only
/// place where you can apply localization, for instance, something that often
/// requires access to the BuildContext).
@MappableEnum()
enum MutateValidationError {
  /// For fun, we will not allow to delete a to-do if it is not completed.
  deletedUncompleted,

  /// No title was provided
  noTitle,

  /// No description was provided
  noDescription,
}

/// There is something wrong with the validation of the model.
@MappableClass()
final class InvalidMutateToDoResponse extends MutateToDoResponse
    with InvalidMutateToDoResponseMappable {
  const InvalidMutateToDoResponse({required this.reason});

  final MutateValidationError reason;

  static const fromMap = InvalidMutateToDoResponseMapper.fromMap;
  static const fromJson = InvalidMutateToDoResponseMapper.fromJson;
}

/// Something terrible happened while executing the mutation.
@MappableClass()
final class ExceptionMutateToDoResponse extends MutateToDoResponse
    with ExceptionMutateToDoResponseMappable {
  const ExceptionMutateToDoResponse(this.exception, this.stackTrace);

  final Exception exception;
  final StackTrace stackTrace;

  static const fromMap = ExceptionMutateToDoResponseMapper.fromMap;
  static const fromJson = ExceptionMutateToDoResponseMapper.fromJson;
}
