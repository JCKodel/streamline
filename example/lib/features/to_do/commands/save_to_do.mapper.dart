// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'save_to_do.dart';

class SaveToDoCommandMapper extends ClassMapperBase<SaveToDoCommand> {
  SaveToDoCommandMapper._();

  static SaveToDoCommandMapper? _instance;
  static SaveToDoCommandMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SaveToDoCommandMapper._());
      ToDoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SaveToDoCommand';

  static ToDo _$toDo(SaveToDoCommand v) => v.toDo;
  static const Field<SaveToDoCommand, ToDo> _f$toDo = Field('toDo', _$toDo);

  @override
  final MappableFields<SaveToDoCommand> fields = const {
    #toDo: _f$toDo,
  };

  static SaveToDoCommand _instantiate(DecodingData data) {
    return SaveToDoCommand(toDo: data.dec(_f$toDo));
  }

  @override
  final Function instantiate = _instantiate;

  static SaveToDoCommand fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SaveToDoCommand>(map);
  }

  static SaveToDoCommand fromJson(String json) {
    return ensureInitialized().decodeJson<SaveToDoCommand>(json);
  }
}

mixin SaveToDoCommandMappable {
  String toJson() {
    return SaveToDoCommandMapper.ensureInitialized()
        .encodeJson<SaveToDoCommand>(this as SaveToDoCommand);
  }

  Map<String, dynamic> toMap() {
    return SaveToDoCommandMapper.ensureInitialized()
        .encodeMap<SaveToDoCommand>(this as SaveToDoCommand);
  }

  SaveToDoCommandCopyWith<SaveToDoCommand, SaveToDoCommand, SaveToDoCommand>
      get copyWith => _SaveToDoCommandCopyWithImpl(
          this as SaveToDoCommand, $identity, $identity);
  @override
  String toString() {
    return SaveToDoCommandMapper.ensureInitialized()
        .stringifyValue(this as SaveToDoCommand);
  }

  @override
  bool operator ==(Object other) {
    return SaveToDoCommandMapper.ensureInitialized()
        .equalsValue(this as SaveToDoCommand, other);
  }

  @override
  int get hashCode {
    return SaveToDoCommandMapper.ensureInitialized()
        .hashValue(this as SaveToDoCommand);
  }
}

extension SaveToDoCommandValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SaveToDoCommand, $Out> {
  SaveToDoCommandCopyWith<$R, SaveToDoCommand, $Out> get $asSaveToDoCommand =>
      $base.as((v, t, t2) => _SaveToDoCommandCopyWithImpl(v, t, t2));
}

abstract class SaveToDoCommandCopyWith<$R, $In extends SaveToDoCommand, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ToDoCopyWith<$R, ToDo, ToDo> get toDo;
  $R call({ToDo? toDo});
  SaveToDoCommandCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SaveToDoCommandCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SaveToDoCommand, $Out>
    implements SaveToDoCommandCopyWith<$R, SaveToDoCommand, $Out> {
  _SaveToDoCommandCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SaveToDoCommand> $mapper =
      SaveToDoCommandMapper.ensureInitialized();
  @override
  ToDoCopyWith<$R, ToDo, ToDo> get toDo =>
      $value.toDo.copyWith.$chain((v) => call(toDo: v));
  @override
  $R call({ToDo? toDo}) =>
      $apply(FieldCopyWithData({if (toDo != null) #toDo: toDo}));
  @override
  SaveToDoCommand $make(CopyWithData data) =>
      SaveToDoCommand(toDo: data.get(#toDo, or: $value.toDo));

  @override
  SaveToDoCommandCopyWith<$R2, SaveToDoCommand, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SaveToDoCommandCopyWithImpl($value, $cast, t);
}
