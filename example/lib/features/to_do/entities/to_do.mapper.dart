// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'to_do.dart';

class ToDoMapper extends ClassMapperBase<ToDo> {
  ToDoMapper._();

  static ToDoMapper? _instance;
  static ToDoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ToDoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ToDo';

  static String _$id(ToDo v) => v.id;
  static const Field<ToDo, String> _f$id = Field('id', _$id);
  static String _$title(ToDo v) => v.title;
  static const Field<ToDo, String> _f$title = Field('title', _$title);
  static String _$description(ToDo v) => v.description;
  static const Field<ToDo, String> _f$description =
      Field('description', _$description);
  static bool _$completed(ToDo v) => v.completed;
  static const Field<ToDo, bool> _f$completed = Field('completed', _$completed);

  @override
  final MappableFields<ToDo> fields = const {
    #id: _f$id,
    #title: _f$title,
    #description: _f$description,
    #completed: _f$completed,
  };

  static ToDo _instantiate(DecodingData data) {
    return ToDo(
        id: data.dec(_f$id),
        title: data.dec(_f$title),
        description: data.dec(_f$description),
        completed: data.dec(_f$completed));
  }

  @override
  final Function instantiate = _instantiate;

  static ToDo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ToDo>(map);
  }

  static ToDo fromJson(String json) {
    return ensureInitialized().decodeJson<ToDo>(json);
  }
}

mixin ToDoMappable {
  String toJson() {
    return ToDoMapper.ensureInitialized().encodeJson<ToDo>(this as ToDo);
  }

  Map<String, dynamic> toMap() {
    return ToDoMapper.ensureInitialized().encodeMap<ToDo>(this as ToDo);
  }

  ToDoCopyWith<ToDo, ToDo, ToDo> get copyWith =>
      _ToDoCopyWithImpl(this as ToDo, $identity, $identity);
  @override
  String toString() {
    return ToDoMapper.ensureInitialized().stringifyValue(this as ToDo);
  }

  @override
  bool operator ==(Object other) {
    return ToDoMapper.ensureInitialized().equalsValue(this as ToDo, other);
  }

  @override
  int get hashCode {
    return ToDoMapper.ensureInitialized().hashValue(this as ToDo);
  }
}

extension ToDoValueCopy<$R, $Out> on ObjectCopyWith<$R, ToDo, $Out> {
  ToDoCopyWith<$R, ToDo, $Out> get $asToDo =>
      $base.as((v, t, t2) => _ToDoCopyWithImpl(v, t, t2));
}

abstract class ToDoCopyWith<$R, $In extends ToDo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? title, String? description, bool? completed});
  ToDoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ToDoCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, ToDo, $Out>
    implements ToDoCopyWith<$R, ToDo, $Out> {
  _ToDoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ToDo> $mapper = ToDoMapper.ensureInitialized();
  @override
  $R call({String? id, String? title, String? description, bool? completed}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (title != null) #title: title,
        if (description != null) #description: description,
        if (completed != null) #completed: completed
      }));
  @override
  ToDo $make(CopyWithData data) => ToDo(
      id: data.get(#id, or: $value.id),
      title: data.get(#title, or: $value.title),
      description: data.get(#description, or: $value.description),
      completed: data.get(#completed, or: $value.completed));

  @override
  ToDoCopyWith<$R2, ToDo, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ToDoCopyWithImpl($value, $cast, t);
}
