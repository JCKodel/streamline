// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'to_do_was_deleted.dart';

class ToDoWasDeletedMapper extends ClassMapperBase<ToDoWasDeleted> {
  ToDoWasDeletedMapper._();

  static ToDoWasDeletedMapper? _instance;
  static ToDoWasDeletedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ToDoWasDeletedMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ToDoWasDeleted';

  static String _$id(ToDoWasDeleted v) => v.id;
  static const Field<ToDoWasDeleted, String> _f$id = Field('id', _$id);

  @override
  final MappableFields<ToDoWasDeleted> fields = const {
    #id: _f$id,
  };

  static ToDoWasDeleted _instantiate(DecodingData data) {
    return ToDoWasDeleted(id: data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static ToDoWasDeleted fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ToDoWasDeleted>(map);
  }

  static ToDoWasDeleted fromJson(String json) {
    return ensureInitialized().decodeJson<ToDoWasDeleted>(json);
  }
}

mixin ToDoWasDeletedMappable {
  String toJson() {
    return ToDoWasDeletedMapper.ensureInitialized()
        .encodeJson<ToDoWasDeleted>(this as ToDoWasDeleted);
  }

  Map<String, dynamic> toMap() {
    return ToDoWasDeletedMapper.ensureInitialized()
        .encodeMap<ToDoWasDeleted>(this as ToDoWasDeleted);
  }

  ToDoWasDeletedCopyWith<ToDoWasDeleted, ToDoWasDeleted, ToDoWasDeleted>
      get copyWith => _ToDoWasDeletedCopyWithImpl(
          this as ToDoWasDeleted, $identity, $identity);
  @override
  String toString() {
    return ToDoWasDeletedMapper.ensureInitialized()
        .stringifyValue(this as ToDoWasDeleted);
  }

  @override
  bool operator ==(Object other) {
    return ToDoWasDeletedMapper.ensureInitialized()
        .equalsValue(this as ToDoWasDeleted, other);
  }

  @override
  int get hashCode {
    return ToDoWasDeletedMapper.ensureInitialized()
        .hashValue(this as ToDoWasDeleted);
  }
}

extension ToDoWasDeletedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ToDoWasDeleted, $Out> {
  ToDoWasDeletedCopyWith<$R, ToDoWasDeleted, $Out> get $asToDoWasDeleted =>
      $base.as((v, t, t2) => _ToDoWasDeletedCopyWithImpl(v, t, t2));
}

abstract class ToDoWasDeletedCopyWith<$R, $In extends ToDoWasDeleted, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id});
  ToDoWasDeletedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ToDoWasDeletedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ToDoWasDeleted, $Out>
    implements ToDoWasDeletedCopyWith<$R, ToDoWasDeleted, $Out> {
  _ToDoWasDeletedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ToDoWasDeleted> $mapper =
      ToDoWasDeletedMapper.ensureInitialized();
  @override
  $R call({String? id}) => $apply(FieldCopyWithData({if (id != null) #id: id}));
  @override
  ToDoWasDeleted $make(CopyWithData data) =>
      ToDoWasDeleted(id: data.get(#id, or: $value.id));

  @override
  ToDoWasDeletedCopyWith<$R2, ToDoWasDeleted, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ToDoWasDeletedCopyWithImpl($value, $cast, t);
}
