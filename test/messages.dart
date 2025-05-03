part of 'mediator_test.dart';

void _messagesTest() {
  test("Message is emmited", () async {
    // ignore: prefer_const_declarations
    final message = "Test";
    String? emittedMessage;

    $addMessageHandler((String message) => emittedMessage = message);
    $publish(message);
    expect(emittedMessage, message);
  });

  test("Message is not handled if emitted before its handler", () async {
    // ignore: prefer_const_declarations
    final message = "Test";
    String? emittedMessage;

    $publish(message);
    $addMessageHandler((String message) => emittedMessage = message);
    expect(emittedMessage, null);
  });

  test("Message is not handled if handler is removed", () async {
    // ignore: prefer_const_declarations
    final message = "Test";
    String? emittedMessage;
    String handler(String message) => emittedMessage = message;

    $addMessageHandler(handler);
    $removeMessageHandler(handler);
    $publish(message);
    expect(emittedMessage, null);
  });
}
