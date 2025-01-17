part of '../streamline.dart';

/// A type that can be either [Some] or [None].
///
/// [Some] is a type that contains a value of type [TValue].
/// [None] is a type that does not contain a value.
///
/// This class is meant to be used as a return type for functions that may
/// return either a value or nothing, to avoid the need for null checks.
@immutable
sealed class Option<TValue> {
  const Option();

  /// Creates a [Some] instance.
  ///
  /// [value] is the value that will be contained in the [Some] instance.
  const factory Option.some(TValue value) = Some<TValue>;

  /// Creates a [None] instance.
  ///
  /// [None] is a type that does not contain a value.
  const factory Option.none() = None<TValue>;

  /// Maps the [Option] to a new [Option] based on the provided [onSome] and
  /// [onNone] functions.
  T map<T>({
    required T Function(TValue value) onSome,
    required T Function() onNone,
  }) {
    return switch (this) {
      Some<TValue>(value: final value) => onSome(value),
      None<TValue>() => onNone(),
    };
  }

  /// Calls the provided [onSome] function if the [Option] is a [Some] instance.
  Option<TValue> onSome(void Function(TValue value) onSome) {
    switch (this) {
      case Some(value: final value):
        onSome(value);
      default:
    }

    return this;
  }

  /// Calls the provided [onNone] function if the [Option] is a [None] instance.
  Option<TValue> onNone(void Function() onNone) {
    switch (this) {
      case None():
        onNone();
      default:
    }

    return this;
  }
}

/// [Some] is a type that contains a value of type [TValue].
@immutable
final class Some<TValue> extends Option<TValue> {
  const Some(this.value);

  final TValue value;

  @override
  bool operator ==(Object other) {
    return super == other || (other is Some<TValue> && value == other.value);
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => "Some<$TValue>($value)";
}

/// [None] is a type that does not contain a value.
@immutable
final class None<TValue> extends Option<TValue> {
  const None();

  @override
  bool operator ==(Object other) {
    return super == other || other is None<TValue>;
  }

  @override
  int get hashCode => TValue.hashCode;

  @override
  String toString() => "None<$TValue>()";
}
