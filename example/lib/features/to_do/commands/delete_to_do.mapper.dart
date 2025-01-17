// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'delete_to_do.dart';

class DeleteToDoCommandMapper extends ClassMapperBase<DeleteToDoCommand> {
  DeleteToDoCommandMapper._();

  static DeleteToDoCommandMapper? _instance;
  static DeleteToDoCommandMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DeleteToDoCommandMapper._());
      ToDoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DeleteToDoCommand';

  static ToDo _$toDo(DeleteToDoCommand v) => v.toDo;
  static const Field<DeleteToDoCommand, ToDo> _f$toDo = Field('toDo', _$toDo);

  @override
  final MappableFields<DeleteToDoCommand> fields = const {
    #toDo: _f$toDo,
  };

  static DeleteToDoCommand _instantiate(DecodingData data) {
    return DeleteToDoCommand(data.dec(_f$toDo));
  }

  @override
  final Function instantiate = _instantiate;

  static DeleteToDoCommand fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DeleteToDoCommand>(map);
  }

  static DeleteToDoCommand fromJson(String json) {
    return ensureInitialized().decodeJson<DeleteToDoCommand>(json);
  }
}

mixin DeleteToDoCommandMappable {
  String toJson() {
    return DeleteToDoCommandMapper.ensureInitialized()
        .encodeJson<DeleteToDoCommand>(this as DeleteToDoCommand);
  }

  Map<String, dynamic> toMap() {
    return DeleteToDoCommandMapper.ensureInitialized()
        .encodeMap<DeleteToDoCommand>(this as DeleteToDoCommand);
  }

  DeleteToDoCommandCopyWith<DeleteToDoCommand, DeleteToDoCommand,
          DeleteToDoCommand>
      get copyWith => _DeleteToDoCommandCopyWithImpl(
          this as DeleteToDoCommand, $identity, $identity);
  @override
  String toString() {
    return DeleteToDoCommandMapper.ensureInitialized()
        .stringifyValue(this as DeleteToDoCommand);
  }

  @override
  bool operator ==(Object other) {
    return DeleteToDoCommandMapper.ensureInitialized()
        .equalsValue(this as DeleteToDoCommand, other);
  }

  @override
  int get hashCode {
    return DeleteToDoCommandMapper.ensureInitialized()
        .hashValue(this as DeleteToDoCommand);
  }
}

extension DeleteToDoCommandValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DeleteToDoCommand, $Out> {
  DeleteToDoCommandCopyWith<$R, DeleteToDoCommand, $Out>
      get $asDeleteToDoCommand =>
          $base.as((v, t, t2) => _DeleteToDoCommandCopyWithImpl(v, t, t2));
}

abstract class DeleteToDoCommandCopyWith<$R, $In extends DeleteToDoCommand,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ToDoCopyWith<$R, ToDo, ToDo> get toDo;
  $R call({ToDo? toDo});
  DeleteToDoCommandCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DeleteToDoCommandCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DeleteToDoCommand, $Out>
    implements DeleteToDoCommandCopyWith<$R, DeleteToDoCommand, $Out> {
  _DeleteToDoCommandCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DeleteToDoCommand> $mapper =
      DeleteToDoCommandMapper.ensureInitialized();
  @override
  ToDoCopyWith<$R, ToDo, ToDo> get toDo =>
      $value.toDo.copyWith.$chain((v) => call(toDo: v));
  @override
  $R call({ToDo? toDo}) =>
      $apply(FieldCopyWithData({if (toDo != null) #toDo: toDo}));
  @override
  DeleteToDoCommand $make(CopyWithData data) =>
      DeleteToDoCommand(data.get(#toDo, or: $value.toDo));

  @override
  DeleteToDoCommandCopyWith<$R2, DeleteToDoCommand, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DeleteToDoCommandCopyWithImpl($value, $cast, t);
}
