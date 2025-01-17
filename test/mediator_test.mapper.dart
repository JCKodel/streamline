// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'mediator_test.dart';

class CommandAMapper extends ClassMapperBase<CommandA> {
  CommandAMapper._();

  static CommandAMapper? _instance;
  static CommandAMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CommandAMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CommandA';

  static String _$parameter(CommandA v) => v.parameter;
  static const Field<CommandA, String> _f$parameter =
      Field('parameter', _$parameter);

  @override
  final MappableFields<CommandA> fields = const {
    #parameter: _f$parameter,
  };

  static CommandA _instantiate(DecodingData data) {
    return CommandA(data.dec(_f$parameter));
  }

  @override
  final Function instantiate = _instantiate;

  static CommandA fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CommandA>(map);
  }

  static CommandA fromJson(String json) {
    return ensureInitialized().decodeJson<CommandA>(json);
  }
}

mixin CommandAMappable {
  String toJson() {
    return CommandAMapper.ensureInitialized()
        .encodeJson<CommandA>(this as CommandA);
  }

  Map<String, dynamic> toMap() {
    return CommandAMapper.ensureInitialized()
        .encodeMap<CommandA>(this as CommandA);
  }

  CommandACopyWith<CommandA, CommandA, CommandA> get copyWith =>
      _CommandACopyWithImpl(this as CommandA, $identity, $identity);
  @override
  String toString() {
    return CommandAMapper.ensureInitialized().stringifyValue(this as CommandA);
  }

  @override
  bool operator ==(Object other) {
    return CommandAMapper.ensureInitialized()
        .equalsValue(this as CommandA, other);
  }

  @override
  int get hashCode {
    return CommandAMapper.ensureInitialized().hashValue(this as CommandA);
  }
}

extension CommandAValueCopy<$R, $Out> on ObjectCopyWith<$R, CommandA, $Out> {
  CommandACopyWith<$R, CommandA, $Out> get $asCommandA =>
      $base.as((v, t, t2) => _CommandACopyWithImpl(v, t, t2));
}

abstract class CommandACopyWith<$R, $In extends CommandA, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? parameter});
  CommandACopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CommandACopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CommandA, $Out>
    implements CommandACopyWith<$R, CommandA, $Out> {
  _CommandACopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CommandA> $mapper =
      CommandAMapper.ensureInitialized();
  @override
  $R call({String? parameter}) =>
      $apply(FieldCopyWithData({if (parameter != null) #parameter: parameter}));
  @override
  CommandA $make(CopyWithData data) =>
      CommandA(data.get(#parameter, or: $value.parameter));

  @override
  CommandACopyWith<$R2, CommandA, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CommandACopyWithImpl($value, $cast, t);
}

class QueryAMapper extends ClassMapperBase<QueryA> {
  QueryAMapper._();

  static QueryAMapper? _instance;
  static QueryAMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = QueryAMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'QueryA';

  static String _$parameter(QueryA v) => v.parameter;
  static const Field<QueryA, String> _f$parameter =
      Field('parameter', _$parameter);

  @override
  final MappableFields<QueryA> fields = const {
    #parameter: _f$parameter,
  };

  static QueryA _instantiate(DecodingData data) {
    return QueryA(data.dec(_f$parameter));
  }

  @override
  final Function instantiate = _instantiate;

  static QueryA fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<QueryA>(map);
  }

  static QueryA fromJson(String json) {
    return ensureInitialized().decodeJson<QueryA>(json);
  }
}

mixin QueryAMappable {
  String toJson() {
    return QueryAMapper.ensureInitialized().encodeJson<QueryA>(this as QueryA);
  }

  Map<String, dynamic> toMap() {
    return QueryAMapper.ensureInitialized().encodeMap<QueryA>(this as QueryA);
  }

  QueryACopyWith<QueryA, QueryA, QueryA> get copyWith =>
      _QueryACopyWithImpl(this as QueryA, $identity, $identity);
  @override
  String toString() {
    return QueryAMapper.ensureInitialized().stringifyValue(this as QueryA);
  }

  @override
  bool operator ==(Object other) {
    return QueryAMapper.ensureInitialized().equalsValue(this as QueryA, other);
  }

  @override
  int get hashCode {
    return QueryAMapper.ensureInitialized().hashValue(this as QueryA);
  }
}

extension QueryAValueCopy<$R, $Out> on ObjectCopyWith<$R, QueryA, $Out> {
  QueryACopyWith<$R, QueryA, $Out> get $asQueryA =>
      $base.as((v, t, t2) => _QueryACopyWithImpl(v, t, t2));
}

abstract class QueryACopyWith<$R, $In extends QueryA, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? parameter});
  QueryACopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _QueryACopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, QueryA, $Out>
    implements QueryACopyWith<$R, QueryA, $Out> {
  _QueryACopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<QueryA> $mapper = QueryAMapper.ensureInitialized();
  @override
  $R call({String? parameter}) =>
      $apply(FieldCopyWithData({if (parameter != null) #parameter: parameter}));
  @override
  QueryA $make(CopyWithData data) =>
      QueryA(data.get(#parameter, or: $value.parameter));

  @override
  QueryACopyWith<$R2, QueryA, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _QueryACopyWithImpl($value, $cast, t);
}

class EventAMapper extends ClassMapperBase<EventA> {
  EventAMapper._();

  static EventAMapper? _instance;
  static EventAMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventAMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EventA';

  static Completer<int> _$completer(EventA v) => v.completer;
  static const Field<EventA, Completer<int>> _f$completer =
      Field('completer', _$completer);

  @override
  final MappableFields<EventA> fields = const {
    #completer: _f$completer,
  };

  static EventA _instantiate(DecodingData data) {
    return EventA(data.dec(_f$completer));
  }

  @override
  final Function instantiate = _instantiate;

  static EventA fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventA>(map);
  }

  static EventA fromJson(String json) {
    return ensureInitialized().decodeJson<EventA>(json);
  }
}

mixin EventAMappable {
  String toJson() {
    return EventAMapper.ensureInitialized().encodeJson<EventA>(this as EventA);
  }

  Map<String, dynamic> toMap() {
    return EventAMapper.ensureInitialized().encodeMap<EventA>(this as EventA);
  }

  EventACopyWith<EventA, EventA, EventA> get copyWith =>
      _EventACopyWithImpl(this as EventA, $identity, $identity);
  @override
  String toString() {
    return EventAMapper.ensureInitialized().stringifyValue(this as EventA);
  }

  @override
  bool operator ==(Object other) {
    return EventAMapper.ensureInitialized().equalsValue(this as EventA, other);
  }

  @override
  int get hashCode {
    return EventAMapper.ensureInitialized().hashValue(this as EventA);
  }
}

extension EventAValueCopy<$R, $Out> on ObjectCopyWith<$R, EventA, $Out> {
  EventACopyWith<$R, EventA, $Out> get $asEventA =>
      $base.as((v, t, t2) => _EventACopyWithImpl(v, t, t2));
}

abstract class EventACopyWith<$R, $In extends EventA, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({Completer<int>? completer});
  EventACopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EventACopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, EventA, $Out>
    implements EventACopyWith<$R, EventA, $Out> {
  _EventACopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventA> $mapper = EventAMapper.ensureInitialized();
  @override
  $R call({Completer<int>? completer}) =>
      $apply(FieldCopyWithData({if (completer != null) #completer: completer}));
  @override
  EventA $make(CopyWithData data) =>
      EventA(data.get(#completer, or: $value.completer));

  @override
  EventACopyWith<$R2, EventA, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _EventACopyWithImpl($value, $cast, t);
}

class EventBMapper extends ClassMapperBase<EventB> {
  EventBMapper._();

  static EventBMapper? _instance;
  static EventBMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventBMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EventB';

  static int _$value(EventB v) => v.value;
  static const Field<EventB, int> _f$value = Field('value', _$value);

  @override
  final MappableFields<EventB> fields = const {
    #value: _f$value,
  };

  static EventB _instantiate(DecodingData data) {
    return EventB(data.dec(_f$value));
  }

  @override
  final Function instantiate = _instantiate;

  static EventB fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventB>(map);
  }

  static EventB fromJson(String json) {
    return ensureInitialized().decodeJson<EventB>(json);
  }
}

mixin EventBMappable {
  String toJson() {
    return EventBMapper.ensureInitialized().encodeJson<EventB>(this as EventB);
  }

  Map<String, dynamic> toMap() {
    return EventBMapper.ensureInitialized().encodeMap<EventB>(this as EventB);
  }

  EventBCopyWith<EventB, EventB, EventB> get copyWith =>
      _EventBCopyWithImpl(this as EventB, $identity, $identity);
  @override
  String toString() {
    return EventBMapper.ensureInitialized().stringifyValue(this as EventB);
  }

  @override
  bool operator ==(Object other) {
    return EventBMapper.ensureInitialized().equalsValue(this as EventB, other);
  }

  @override
  int get hashCode {
    return EventBMapper.ensureInitialized().hashValue(this as EventB);
  }
}

extension EventBValueCopy<$R, $Out> on ObjectCopyWith<$R, EventB, $Out> {
  EventBCopyWith<$R, EventB, $Out> get $asEventB =>
      $base.as((v, t, t2) => _EventBCopyWithImpl(v, t, t2));
}

abstract class EventBCopyWith<$R, $In extends EventB, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? value});
  EventBCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EventBCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, EventB, $Out>
    implements EventBCopyWith<$R, EventB, $Out> {
  _EventBCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventB> $mapper = EventBMapper.ensureInitialized();
  @override
  $R call({int? value}) =>
      $apply(FieldCopyWithData({if (value != null) #value: value}));
  @override
  EventB $make(CopyWithData data) => EventB(data.get(#value, or: $value.value));

  @override
  EventBCopyWith<$R2, EventB, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _EventBCopyWithImpl($value, $cast, t);
}

class AggregatorAMapper extends ClassMapperBase<AggregatorA> {
  AggregatorAMapper._();

  static AggregatorAMapper? _instance;
  static AggregatorAMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AggregatorAMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AggregatorA';

  static int _$value(AggregatorA v) => v.value;
  static const Field<AggregatorA, int> _f$value = Field('value', _$value);

  @override
  final MappableFields<AggregatorA> fields = const {
    #value: _f$value,
  };

  static AggregatorA _instantiate(DecodingData data) {
    return AggregatorA(data.dec(_f$value));
  }

  @override
  final Function instantiate = _instantiate;

  static AggregatorA fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AggregatorA>(map);
  }

  static AggregatorA fromJson(String json) {
    return ensureInitialized().decodeJson<AggregatorA>(json);
  }
}

mixin AggregatorAMappable {
  String toJson() {
    return AggregatorAMapper.ensureInitialized()
        .encodeJson<AggregatorA>(this as AggregatorA);
  }

  Map<String, dynamic> toMap() {
    return AggregatorAMapper.ensureInitialized()
        .encodeMap<AggregatorA>(this as AggregatorA);
  }

  AggregatorACopyWith<AggregatorA, AggregatorA, AggregatorA> get copyWith =>
      _AggregatorACopyWithImpl(this as AggregatorA, $identity, $identity);
  @override
  String toString() {
    return AggregatorAMapper.ensureInitialized()
        .stringifyValue(this as AggregatorA);
  }

  @override
  bool operator ==(Object other) {
    return AggregatorAMapper.ensureInitialized()
        .equalsValue(this as AggregatorA, other);
  }

  @override
  int get hashCode {
    return AggregatorAMapper.ensureInitialized().hashValue(this as AggregatorA);
  }
}

extension AggregatorAValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AggregatorA, $Out> {
  AggregatorACopyWith<$R, AggregatorA, $Out> get $asAggregatorA =>
      $base.as((v, t, t2) => _AggregatorACopyWithImpl(v, t, t2));
}

abstract class AggregatorACopyWith<$R, $In extends AggregatorA, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? value});
  AggregatorACopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AggregatorACopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AggregatorA, $Out>
    implements AggregatorACopyWith<$R, AggregatorA, $Out> {
  _AggregatorACopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AggregatorA> $mapper =
      AggregatorAMapper.ensureInitialized();
  @override
  $R call({int? value}) =>
      $apply(FieldCopyWithData({if (value != null) #value: value}));
  @override
  AggregatorA $make(CopyWithData data) =>
      AggregatorA(data.get(#value, or: $value.value));

  @override
  AggregatorACopyWith<$R2, AggregatorA, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AggregatorACopyWithImpl($value, $cast, t);
}
