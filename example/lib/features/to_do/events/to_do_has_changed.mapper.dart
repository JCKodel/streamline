// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'to_do_has_changed.dart';

class ToDoHasChangedMapper extends ClassMapperBase<ToDoHasChanged> {
  ToDoHasChangedMapper._();

  static ToDoHasChangedMapper? _instance;
  static ToDoHasChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ToDoHasChangedMapper._());
      ToDoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ToDoHasChanged';

  static ToDo _$toDo(ToDoHasChanged v) => v.toDo;
  static const Field<ToDoHasChanged, ToDo> _f$toDo = Field('toDo', _$toDo);

  @override
  final MappableFields<ToDoHasChanged> fields = const {
    #toDo: _f$toDo,
  };

  static ToDoHasChanged _instantiate(DecodingData data) {
    return ToDoHasChanged(toDo: data.dec(_f$toDo));
  }

  @override
  final Function instantiate = _instantiate;

  static ToDoHasChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ToDoHasChanged>(map);
  }

  static ToDoHasChanged fromJson(String json) {
    return ensureInitialized().decodeJson<ToDoHasChanged>(json);
  }
}

mixin ToDoHasChangedMappable {
  String toJson() {
    return ToDoHasChangedMapper.ensureInitialized()
        .encodeJson<ToDoHasChanged>(this as ToDoHasChanged);
  }

  Map<String, dynamic> toMap() {
    return ToDoHasChangedMapper.ensureInitialized()
        .encodeMap<ToDoHasChanged>(this as ToDoHasChanged);
  }

  ToDoHasChangedCopyWith<ToDoHasChanged, ToDoHasChanged, ToDoHasChanged>
      get copyWith => _ToDoHasChangedCopyWithImpl(
          this as ToDoHasChanged, $identity, $identity);
  @override
  String toString() {
    return ToDoHasChangedMapper.ensureInitialized()
        .stringifyValue(this as ToDoHasChanged);
  }

  @override
  bool operator ==(Object other) {
    return ToDoHasChangedMapper.ensureInitialized()
        .equalsValue(this as ToDoHasChanged, other);
  }

  @override
  int get hashCode {
    return ToDoHasChangedMapper.ensureInitialized()
        .hashValue(this as ToDoHasChanged);
  }
}

extension ToDoHasChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ToDoHasChanged, $Out> {
  ToDoHasChangedCopyWith<$R, ToDoHasChanged, $Out> get $asToDoHasChanged =>
      $base.as((v, t, t2) => _ToDoHasChangedCopyWithImpl(v, t, t2));
}

abstract class ToDoHasChangedCopyWith<$R, $In extends ToDoHasChanged, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ToDoCopyWith<$R, ToDo, ToDo> get toDo;
  $R call({ToDo? toDo});
  ToDoHasChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ToDoHasChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ToDoHasChanged, $Out>
    implements ToDoHasChangedCopyWith<$R, ToDoHasChanged, $Out> {
  _ToDoHasChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ToDoHasChanged> $mapper =
      ToDoHasChangedMapper.ensureInitialized();
  @override
  ToDoCopyWith<$R, ToDo, ToDo> get toDo =>
      $value.toDo.copyWith.$chain((v) => call(toDo: v));
  @override
  $R call({ToDo? toDo}) =>
      $apply(FieldCopyWithData({if (toDo != null) #toDo: toDo}));
  @override
  ToDoHasChanged $make(CopyWithData data) =>
      ToDoHasChanged(toDo: data.get(#toDo, or: $value.toDo));

  @override
  ToDoHasChangedCopyWith<$R2, ToDoHasChanged, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ToDoHasChangedCopyWithImpl($value, $cast, t);
}
