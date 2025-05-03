part of '../streamline.dart';

final class _MessagesDispatcher {
  _MessagesDispatcher();

  final _messageHandlers = <String, List<dynamic>>{};

  /// Emits a message to all registered handlers.
  ///
  /// A message differs from an event in that it doesn't have handlers, observers,
  /// pipelines and it always triggers the handlers, no matter if the previous
  /// message is the same.
  void publish<TMessage>(TMessage message) {
    final messageType = message.runtimeType.toString();
    final handlers = _messageHandlers[messageType];

    if (handlers != null) {
      for (final handler in handlers) {
        (handler as void Function(TMessage))(message);
      }
    }
  }

  /// Registers a handler for a specific message type.
  void addMessageHandler<TMessage>(void Function(TMessage message) handler) {
    final messageType = TMessage.toString();
    final handlers = _messageHandlers[messageType] ??= [];

    handlers.add(handler);
  }

  /// Unregisters a handler for a specific message type.
  void removeMessageHandler<TMessage>(void Function(TMessage message) handler) {
    final messageType = TMessage.toString();
    final handlers = _messageHandlers[messageType];

    if (handlers != null) {
      handlers.remove(handler);
    }
  }
}
