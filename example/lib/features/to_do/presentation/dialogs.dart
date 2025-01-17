import 'package:flutter/material.dart';

import 'package:streamline_example/features/to_do/entities/mutate_to_do_response.dart';

void showMutationResultErrorDialog({
  required BuildContext context,
  required MutateToDoResponse mutateToDoResponse,
  required bool popOnSuccess,
}) {
  // This exhaustively switch is the most wonderful feature of modern Dart.
  // Soooo much bugs are avoided by it.
  switch (mutateToDoResponse) {
    case SuccessMutateToDoResponse():
      // On success, just pop the page, if needed
      if (popOnSuccess) {
        Navigator.of(context).pop();
      }
    case InvalidMutateToDoResponse():
      // Show validation error message
      _showValidationError(context: context, reason: mutateToDoResponse.reason);
    case ExceptionMutateToDoResponse():
      // Something terrible happened, show an alert
      _showErrorMessage(
        context: context,
        title: mutateToDoResponse.exception.runtimeType.toString(),
        message: "An unknown error happened!",
      );
  }
}

void _showErrorMessage({
  required BuildContext context,
  required String title,
  required String message,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("OK"),
        ),
      ],
    ),
  );
}

void _showValidationError({
  required BuildContext context,
  required MutateValidationError reason,
}) {
  // Notice that if you create a new validation error, this code will
  // give you a compile error. That's the beauty of exaustive switches.
  final errorMessage = switch (reason) {
    MutateValidationError.deletedUncompleted =>
      "You can't delete an uncompleted to do!",
    MutateValidationError.noTitle => "You forgot to provide a title!",
    MutateValidationError.noDescription =>
      "You forgot to provide a description!",
  };

  // Notice how we reused the exception dialog message code to avoid
  // duplication of code (DRY baby!)
  //
  // p.s.: only a code-nerd would flex about this >.<
  return _showErrorMessage(
    context: context,
    title: "Validation error",
    message: errorMessage,
  );
}
