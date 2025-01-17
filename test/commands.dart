part of 'mediator_test.dart';

@MappableClass()
final class CommandA with CommandAMappable implements ICommand<String> {
  const CommandA(this.parameter);

  final String parameter;

  static const fromMap = CommandAMapper.fromMap;
  static const fromJson = CommandAMapper.fromJson;
}

final class CommandAHandler implements ICommandHandler<CommandA, String> {
  const CommandAHandler();

  @override
  Future<String> handle(CommandA command) {
    return Future.value(command.parameter * 2);
  }
}

void _commandsTest() {
  test(
    "Commands are dispatched",
    () async {
      const command = CommandA("Hello");

      $commandHandler(CommandAHandler.new);

      final result = await $dispatch(command);

      expect(result, "HelloHello");
    },
  );

  test("Commands without handlers throws exception", () async {
    const command = CommandA("Hello");

    expect(
      () async => await $dispatch(command),
      throwsA(isA<ArgumentError>()),
    );
  });

  test("Multiple handlers for the same command throws exception", () async {
    $commandHandler(CommandAHandler.new);

    expect(
      () => $commandHandler(CommandAHandler.new),
      throwsA(isA<ArgumentError>()),
    );
  });

  test("Pipeline", () async {
    const command = CommandA("Hello");

    $commandHandler(CommandAHandler.new);

    var pointer = 0;
    var preHandler = "";

    $registerGenericCommandBehaviour((action, next) {
      final command = action as CommandA;

      ++pointer;
      preHandler += command.parameter * 2;

      return next(command);
    });

    $registerCommandBehaviour((
      CommandA action,
      Future<String> Function(CommandA newAction) next,
    ) {
      ++pointer;
      preHandler += action.parameter * 2;

      return next(action);
    });

    final result = await $dispatch(command);

    expect(result, "HelloHello");
    expect(preHandler, "HelloHelloHelloHello");
    expect(pointer, 2);
  });

  test("Change behaviour", () async {
    const command = CommandA("Hello");

    $commandHandler(CommandAHandler.new);

    final originalResult = await $dispatch(command);

    expect(originalResult, "HelloHello");

    $registerCommandBehaviour((
      CommandA action,
      Future<String> Function(CommandA newAction) next,
    ) {
      return next(const CommandA("Hi"));
    });

    final changedResult = await $dispatch(command);

    expect(changedResult, "HiHi");
  });
}
